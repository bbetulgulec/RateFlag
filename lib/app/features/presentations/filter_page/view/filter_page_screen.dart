import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flag/core/routes/routes.dart';
import 'package:rate_flag/app/features/presentations/filter_page/cubit/filter_page_cubit.dart';
import 'package:rate_flag/app/features/presentations/filter_page/cubit/filter_page_state.dart';
import 'package:rate_flag/app/features/presentations/filter_page/widget/filter_app_bar.dart';
import 'package:rate_flag/app/features/presentations/filter_page/widget/filter_page_bottom_sheet.dart';
import 'package:rate_flag/app/features/presentations/filter_page/widget/filter_search_list.dart';

class FilterPageScreen extends StatelessWidget {
  const FilterPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FilterPageCubit>();

    return BlocBuilder<FilterPageCubit, FilterPageState>(
      builder: (context, state) {
        return Scaffold(
          appBar: FilterAppBar(
            onSearchChanged: cubit.searchUser,

            onFilterPressed: () {
              final cubit = context.read<FilterPageCubit>();

              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                builder: (context) {
                  return BlocProvider.value(
                    value: cubit,
                    child: BlocBuilder<FilterPageCubit, FilterPageState>(
                      builder: (context, state) {
                        return FilterBottomSheet(
                          state: state,
                          onClearFilters: cubit.clearFilters,
                          onFilterTypeChanged: cubit.selectfilterListType,
                          onAgeRangeChanged: cubit.changeAgeRange,
                          onGenderChanged: cubit.selectGender,
                          onIsPublicChanged: cubit.setIsPublic,
                          onApply: () {
                            cubit.isSelectFilterType();
                            Routes.pop(context);
                          },
                        );
                      },
                    ),
                  );
                },
              );
            },
          ),
          body: FilterSearchList(state: state),
        );
      },
    );
  }
}
