import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flag/features/RateFlag/common/constants/text_constant.dart';
import 'package:rate_flag/features/RateFlag/common/responsive/responsive.dart';
import '../cubit/filter_page_cubit.dart';
import 'filter_radio_tile.dart';

class FilterBottomSheet extends StatelessWidget {
  const FilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FilterPageCubit>();

    RangeValues currentAgeRange = cubit.state.ageRange;
    String currentGender = cubit.state.gender;
    bool? currentIsPublic = cubit.state.isPublic;

    return Padding(
      padding: EdgeInsets.all(16.h),
      child: StatefulBuilder(
        builder: (context, setState) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // HEADER
              Row(
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
                    onPressed: () {
                      cubit.clearFilters();
                      setState(() {
                        currentAgeRange = const RangeValues(18, 75);
                        currentGender = TextConstants.all;
                        currentIsPublic = null;
                      });
                    },
                    child: Text(
                      TextConstants.clean,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20.h),

              // AGE
              const Text(TextConstants.ageBetween),
              RangeSlider(
                values: currentAgeRange,
                min: 18,
                max: 75,
                divisions: 57,
                labels: RangeLabels(
                  currentAgeRange.start.round().toString(),
                  currentAgeRange.end.round().toString(),
                ),
                onChanged: (range) {
                  setState(() => currentAgeRange = range);
                },
              ),

              SizedBox(height: 20.h),

              // GENDER
              const Text(TextConstants.gender),
              FilterRadioTile<String>(
                title: TextConstants.genderMale,
                value: 'male',
                groupValue: currentGender,
                onChanged: (v) {
                  setState(() => currentGender = v!);
                  cubit.selectGender(v!);
                },
              ),
              FilterRadioTile<String>(
                title: TextConstants.genderFemale,
                value: 'female',
                groupValue: currentGender,
                onChanged: (v) {
                  setState(() => currentGender = v!);
                  cubit.selectGender(v!);
                },
              ),

              SizedBox(height: 20.h),

              // POST TYPE
              const Text(TextConstants.postType),
              FilterRadioTile<bool?>(
                title: TextConstants.all,
                value: null,
                groupValue: currentIsPublic,
                onChanged: (v) {
                  setState(() => currentIsPublic = v);
                  cubit.setIsPublic(v);
                },
              ),
              FilterRadioTile<bool?>(
                title: TextConstants.postSomeoneElse,
                value: true,
                groupValue: currentIsPublic,
                onChanged: (v) {
                  setState(() => currentIsPublic = v);
                  cubit.setIsPublic(v);
                },
              ),
              FilterRadioTile<bool?>(
                title: TextConstants.postMyself,
                value: false,
                groupValue: currentIsPublic,
                onChanged: (v) {
                  setState(() => currentIsPublic = v);
                  cubit.setIsPublic(v);
                },
              ),

              SizedBox(height: 24.h),

              // APPLY
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    cubit.filterByAge(currentAgeRange);
                    cubit.filterPosts();
                    Navigator.pop(context);
                  },
                  child: const Text(TextConstants.apply),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
