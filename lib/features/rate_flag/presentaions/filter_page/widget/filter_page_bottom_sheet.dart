import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flag/features/RateFlag/common/constants/text_constant.dart';
import 'package:rate_flag/features/RateFlag/common/responsive/responsive.dart';
import 'package:rate_flag/features/RateFlag/presentaions/filter_page/cubit/filter_page_state.dart';
import '../cubit/filter_page_cubit.dart';
import 'filter_radio_tile.dart';

class FilterBottomSheet extends StatelessWidget {
  const FilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.h),
      child: BlocBuilder<FilterPageCubit, FilterPageState>(
        builder: (context, state) {
          final cubit = context.read<FilterPageCubit>();

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
                    onPressed: cubit.clearFilters,
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
                values: state.ageRange,
                min: 18,
                max: 75,
                divisions: 57,
                labels: RangeLabels(
                  state.ageRange.start.round().toString(),
                  state.ageRange.end.round().toString(),
                ),
                onChanged: cubit.changeAgeRange,
              ),

              SizedBox(height: 20.h),

              // GENDER
              const Text(TextConstants.gender),
              FilterRadioTile<String>(
                title: TextConstants.genderMale,
                value: 'male',
                groupValue: state.gender,
                onChanged: (v) => cubit.selectGender(v!),
              ),
              FilterRadioTile<String>(
                title: TextConstants.genderFemale,
                value: 'female',
                groupValue: state.gender,
                onChanged: (v) => cubit.selectGender(v!),
              ),

              SizedBox(height: 20.h),

              // POST TYPE
              const Text(TextConstants.postType),
              FilterRadioTile<bool?>(
                title: TextConstants.all,
                value: null,
                groupValue: state.isPublic,
                onChanged: cubit.setIsPublic,
              ),
              FilterRadioTile<bool?>(
                title: TextConstants.postSomeoneElse,
                value: true,
                groupValue: state.isPublic,
                onChanged: cubit.setIsPublic,
              ),
              FilterRadioTile<bool?>(
                title: TextConstants.postMyself,
                value: false,
                groupValue: state.isPublic,
                onChanged: cubit.setIsPublic,
              ),

              SizedBox(height: 24.h),

              // APPLY
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    cubit.applyFilters(state.ageRange, state.gender);
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
