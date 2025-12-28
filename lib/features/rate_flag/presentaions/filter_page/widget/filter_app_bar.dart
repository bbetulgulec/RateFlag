import 'package:flutter/material.dart';
import 'package:rate_flag/features/rate_flag/common/constants/text_constant.dart';
import 'package:rate_flag/features/rate_flag/common/responsive/responsive.dart';
import 'package:rate_flag/features/rate_flag/common/widgets/buttons/commun_text_button.dart';
import 'package:rate_flag/features/rate_flag/common/widgets/text_fields/common_text_field.dart';

class FilterAppBar extends StatelessWidget implements PreferredSizeWidget {
  final ValueChanged<String> onSearchChanged;
  final VoidCallback onFilterPressed;

  const FilterAppBar({
    super.key,
    required this.onSearchChanged,
    required this.onFilterPressed,
  });

  @override
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          Expanded(
            child: CustomTextField(
              keyboardType: TextInputType.text,
              label: TextConstants.searchHint,
              onChanged: onSearchChanged,
            ),
          ),
        ],
      ),
      actions: [
        SizedBox(
          width: 80.w,
          child: CommunTextButton(
            text: TextConstants.filterButton,
            onPressed: onFilterPressed,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
