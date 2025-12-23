import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flag/features/RateFlag/common/constants/text_constant.dart';
import 'package:rate_flag/features/RateFlag/common/responsive/responsive.dart';
import 'package:rate_flag/features/RateFlag/common/widgets/buttons/custom_elevated_button.dart';
import 'package:rate_flag/features/RateFlag/common/widgets/texts/custom_text.dart';
import 'package:rate_flag/features/RateFlag/common/widgets/text_fields/common_text_field.dart';
import 'package:rate_flag/features/RateFlag/presentaions/post/cubit/post_cubit.dart';
import 'package:rate_flag/features/RateFlag/presentaions/post/cubit/post_state.dart';
import 'package:rate_flag/features/RateFlag/presentaions/post/widget/page_list_view.dart';

class PostCitySelectionStep extends StatelessWidget {
  const PostCitySelectionStep({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PostCubit>();

    return BlocBuilder<PostCubit, PostState>(
      builder: (context, state) {
        return Column(
          children: [
            RateFlagText.head2(
              text: TextConstants.whereFoundYou,
              context: context,
            ),

            SizedBox(height: 20.h),
            CustomTextField(
              initialValue: state.cityQuery,
              icon: Icons.search,
              keyboardType: TextInputType.text,
              onChanged: cubit.onCityQueryChanged,
              label: TextConstants.searchCity,
            ),

            SizedBox(height: 15.h),

            if (state.isCityLoading) const CircularProgressIndicator(),

            if (!state.isCityLoading)
              Expanded(
                child: PageListView(
                  itemCount: state.filteredCities.length,
                  itemBuilder: (context, index) {
                    final item = state.filteredCities[index];

                    return ListTile(
                      title: Text(item["name"]),
                      onTap: () {
                        cubit.selectCity(cityName: item["name"] ?? "");
                      },
                    );
                  },
                ),
              ),

            SizedBox(height: 10.h),

            CustomElevatedButton.primary(
              text: TextConstants.continueText,
              onPressed:
                  (state.draftPost?.city == null ||
                      state.draftPost!.city.isEmpty)
                  ? null
                  : () => cubit.nextPage(),
            ),
          ],
        );
      },
    );
  }
}
