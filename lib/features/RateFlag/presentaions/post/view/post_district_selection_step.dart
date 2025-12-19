import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    final districtController = TextEditingController();

    return BlocBuilder<PostCubit, PostState>(
      builder: (context, state) {
        final districts = state.filteredDistricts.isNotEmpty
            ? state.filteredDistricts
            : (state.citySuggestions.firstWhere(
                    (city) => city["name"] == state.selectedCity,
                    orElse: () => {"districts": []},
                  )["districts"] ??
                  []);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (state.selectedCity != null)
              RateFlagText.head2(text: "Seçilen Şehir : ${state.selectedCity}"),

            const SizedBox(height: 20),
            CustomTextField(
              controller: districtController,

              icon: Icons.search,
              keyboardType: TextInputType.text,
              onChanged: (query) {
                cubit.filterDistricts(query);
              },
              label: 'Şehir ara ',
            ),

            const SizedBox(height: 10),

            districts.isEmpty
                ? const Center(child: Text("İlçe bulunamadı"))
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

            const SizedBox(height: 10),

            SizedBox(
              width: double.infinity,
              child: CustomElevatedButton.secondary(
                text: "İlerle",
                onPressed: state.selectedDistrict == null
                    ? null
                    : () {
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
