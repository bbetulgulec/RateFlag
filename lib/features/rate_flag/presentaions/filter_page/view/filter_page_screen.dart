import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flag/features/RateFlag/presentaions/filter_page/cubit/filter_page_cubit.dart';
import 'package:rate_flag/features/RateFlag/presentaions/filter_page/cubit/filter_page_state.dart';
import 'package:rate_flag/features/RateFlag/presentaions/filter_page/widget/filter_app_bar.dart';
import 'package:rate_flag/features/RateFlag/presentaions/filter_page/widget/filter_search_list.dart';

class FilterPageScreen extends StatelessWidget {
  const FilterPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterPageCubit, FilterPageState>(
      builder: (context, state) {
        return Scaffold(
          appBar: const FilterAppBar(),
          body: FilterSearchList(state: state),
        );
      },
    );
  }
}
