import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flag/features/RateFlag/common/constants/text_constant.dart';
import 'package:rate_flag/features/RateFlag/common/widgets/buttons/commun_text_button.dart';
import 'package:rate_flag/features/RateFlag/common/widgets/text_fields/common_text_field.dart';
import 'package:rate_flag/features/RateFlag/presentaions/filter_page/widget/filter_page_bottom_sheet.dart';
import '../cubit/filter_page_cubit.dart';

class FilterAppBar extends StatelessWidget implements PreferredSizeWidget {
  const FilterAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FilterPageCubit>();

    return AppBar(
      title: CustomTextField(
        keyboardType: TextInputType.text,
        label: TextConstants.searchHint,
        onChanged: cubit.searchUser,
      ),
      actions: [
        CommunTextButton(
          text: TextConstants.filterButton,
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              builder: (sheetContext) {
                return BlocProvider.value(
                  value: cubit,
                  child: const FilterBottomSheet(),
                );
              },
            );
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
