import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flag/features/RateFlag/common/constants/text_constant.dart';
import 'package:rate_flag/features/RateFlag/common/responsive/responsive.dart';
import 'package:rate_flag/features/RateFlag/common/widgets/buttons/custom_elevated_button.dart';
import 'package:rate_flag/features/RateFlag/common/widgets/texts/custom_text.dart';
import 'package:rate_flag/features/RateFlag/common/widgets/text_fields/custom_text_field.dart';
import 'package:rate_flag/features/RateFlag/presentaions/post/cubit/post_cubit.dart';
import 'package:rate_flag/features/RateFlag/presentaions/post/cubit/post_state.dart';
import 'package:rate_flag/features/RateFlag/presentaions/post/widget/page_list_view.dart';

class PostDistrictSelectionStep extends StatelessWidget {
  const PostDistrictSelectionStep({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PostCubit>();

    return BlocBuilder<PostCubit, PostState>(
      builder: (context, state) {
        final districts = state.filteredDistricts.isNotEmpty
            ? state.filteredDistricts
            : (state.citySuggestions.firstWhere(
                    (city) => city["name"] == state.draftPost?.city,

                    orElse: () => {"districts": []},
                  )["districts"] ??
                  []);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (state.draftPost?.city.isNotEmpty == true)
              RateFlagText.head2(
                text: "${TextConstants.searchCity} ${state.draftPost!.city}",
                context: context,
              ),

            SizedBox(height: 20.h),
            CustomTextField(
              initialValue: state.districtQuery,
              icon: Icons.search,
              keyboardType: TextInputType.text,
              onChanged: cubit.onDistrictQueryChanged,
              label: TextConstants.searchDisritct,
            ),

            SizedBox(height: 10.h),

            districts.isEmpty
                ? const Center(child: Text(TextConstants.didNotFoundDistrict))
                : Expanded(
                    child: PageListView(
                      itemCount: districts.length,
                      itemBuilder: (context, index) {
                        final district = districts[index];
                        return ListTile(
                          title: Text(district["name"] ?? ""),
                          onTap: () {
                            cubit.selectDistrict(district["name"]);
                          },
                        );
                      },
                    ),
                  ),

            SizedBox(height: 10.h),

            SizedBox(
              width: double.infinity,
              child: CustomElevatedButton.secondary(
                text: TextConstants.move,
                onPressed: () {
                  cubit.nextPage();
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
