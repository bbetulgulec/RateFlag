import 'package:flutter/material.dart';
import 'package:rate_flag/features/rate_flag/common/constants/text_constant.dart';
import 'package:rate_flag/features/rate_flag/common/responsive/responsive.dart';
import 'package:rate_flag/features/rate_flag/core/enum/filter_list_type.dart';
import 'package:rate_flag/features/rate_flag/presentaions/filter_page/cubit/filter_page_state.dart';
import 'filter_radio_tile.dart';

class FilterBottomSheet extends StatelessWidget {
  final FilterPageState state;

  final VoidCallback onClearFilters;
  final VoidCallback onApply;

  final ValueChanged<FilterListType> onFilterTypeChanged;
  final ValueChanged<RangeValues> onAgeRangeChanged;
  final ValueChanged<String> onGenderChanged;
  final ValueChanged<bool?> onIsPublicChanged;

  const FilterBottomSheet({
    super.key,
    required this.state,
    required this.onClearFilters,
    required this.onApply,
    required this.onFilterTypeChanged,
    required this.onAgeRangeChanged,
    required this.onGenderChanged,
    required this.onIsPublicChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.h),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    TextConstants.filterButton,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  TextButton(
                    onPressed: onClearFilters,
                    child: Text(
                      TextConstants.clean,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20.h),

            /// FILTER TYPE
            const Text("Tür"),
            RadioGroup<FilterListType>(
              groupValue: state.filterListType,
              onChanged: (value) {
                if (value != null) {
                  onFilterTypeChanged(value);
                }
              },
              child: Row(
                children: const [
                  Expanded(
                    child: FilterRadioTile<FilterListType>(
                      title: "kullanıcı",
                      value: FilterListType.users,
                    ),
                  ),
                  Expanded(
                    child: FilterRadioTile<FilterListType>(
                      title: "postlar",
                      value: FilterListType.posts,
                    ),
                  ),
                ],
              ),
            ),

            /// USER FILTERS
            if (state.filterListType == FilterListType.users) ...[
              const Text(TextConstants.ageBetween),
              RangeSlider(
                values: state.ageRange,
                min: 18,
                max: 75,
                divisions: 57,
                labels: RangeLabels(
                  state.ageRange.start.round().toString(),
                  state.ageRange.end.round().toString(),
                ),
                onChanged: onAgeRangeChanged,
              ),

              SizedBox(height: 20.h),

              const Text(TextConstants.gender),
              RadioGroup<String>(
                groupValue: state.gender,
                onChanged: (value) {
                  if (value != null) {
                    onGenderChanged(value);
                  }
                },
                child: Column(
                  children: const [
                    FilterRadioTile<String>(
                      title: TextConstants.genderMale,
                      value: 'male',
                    ),
                    FilterRadioTile<String>(
                      title: TextConstants.genderFemale,
                      value: 'female',
                    ),
                  ],
                ),
              ),
            ],

            /// POST FILTERS
            if (state.filterListType == FilterListType.posts) ...[
              const Text(TextConstants.postType),
              RadioGroup<bool?>(
                groupValue: state.isPublic,
                onChanged: onIsPublicChanged,
                child: Column(
                  children: const [
                    FilterRadioTile<bool?>(
                      title: TextConstants.all,
                      value: null,
                    ),
                    FilterRadioTile<bool?>(
                      title: TextConstants.postSomeoneElse,
                      value: true,
                    ),
                    FilterRadioTile<bool?>(
                      title: TextConstants.postMyself,
                      value: false,
                    ),
                  ],
                ),
              ),
            ],

            SizedBox(height: 24.h),

            /// APPLY
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onApply,
                child: const Text(TextConstants.apply),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
