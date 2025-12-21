import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flag/features/RateFlag/common/responsive/responsive.dart';
import 'package:rate_flag/features/RateFlag/common/widgets/text_fields/custom_text_field.dart';
import 'package:rate_flag/features/RateFlag/presentaions/filter_page/cubit/filter_page_cubit.dart';
import 'package:rate_flag/features/RateFlag/presentaions/filter_page/cubit/filter_page_state.dart';
/*
class CommonFilterBottomSheet extends StatelessWidget {
  final VoidCallback onClear;
  final VoidCallback onApply;

  const CommonFilterBottomSheet({
    super.key,
    required this.onClear,
    required this.onApply,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterPageCubit, FilterPageState>(
      builder: (context, state) {
        final cubit = context.read<FilterPageCubit>();

        return Padding(
          padding: EdgeInsets.all(16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.close),
                  const Text(
                    "Filters",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  TextButton(onPressed: onClear, child: const Text("Clear")),
                ],
              ),

              SizedBox(height: 20.h),

              /// CITY SEARCH
              CustomTextField(
                label: "Şehir ara",
                icon: Icons.search,
                initialValue: state.cityQuery,
                onChanged: cubit.onCityQueryChanged,
                keyboardType: TextInputType.text,
              ),

              SizedBox(height: 8.h),

              if (state.isCityLoading)
                const Center(child: CircularProgressIndicator()),

              if (!state.isCityLoading && state.filteredCities.isNotEmpty)
                SizedBox(
                  height: 200.h,
                  child: ListView.builder(
                    itemCount: state.filteredCities.length,
                    itemBuilder: (_, index) {
                      final city = state.filteredCities[index];
                      return ListTile(
                        title: Text(city["name"]),
                        onTap: () => cubit.selectCity(city["name"]),
                      );
                    },
                  ),
                ),

              if (state.selectedCity != null)
                Padding(
                  padding: EdgeInsets.only(top: 8.h),
                  child: Text(
                    "Seçilen şehir: ${state.selectedCity}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ),

              const Spacer(),

              /// APPLY
              SizedBox(
                width: double.infinity,
                height: 52.h,
                child: ElevatedButton(
                  onPressed: onApply,
                  child: Text(
                    "Apply Filters",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
*/