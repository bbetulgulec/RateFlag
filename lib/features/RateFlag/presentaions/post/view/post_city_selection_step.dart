import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flag/features/RateFlag/common/widgets/buttons/custom_elevated_button.dart';
import 'package:rate_flag/features/RateFlag/common/widgets/texts/custom_text.dart';
import 'package:rate_flag/features/RateFlag/common/widgets/text_fields/custom_text_field.dart';
import 'package:rate_flag/features/RateFlag/presentaions/post/cubit/post_cubit.dart';
import 'package:rate_flag/features/RateFlag/presentaions/post/cubit/post_state.dart';
import 'package:rate_flag/features/RateFlag/presentaions/post/widget/page_list_view.dart';

class PostCitySelectionStep extends StatelessWidget {
  const PostCitySelectionStep({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PostCubit>();
    final cityController = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (cubit.state.citySuggestions.isEmpty) {
        cubit.searchCities("");
      }
    });

    return BlocBuilder<PostCubit, PostState>(
      builder: (context, state) {
        return Column(
          children: [
            RateFlagText.head2(text: "Sizi nerede bulabiliriz ?"),

            const SizedBox(height: 20),
            CustomTextField(
              controller: cityController,
              icon: Icons.search,
              keyboardType: TextInputType.text,
              onChanged: cubit.searchCities,
              label: 'Şehir ara',
            ),

            const SizedBox(height: 15),

            if (state.isCityLoading) const CircularProgressIndicator(),

            if (!state.isCityLoading)
              Expanded(
                child: PageListView(
                  itemCount: state.filteredCities.length,
                  itemBuilder: (context, index) {
                    final item = state.filteredCities[index];
                    return ListTile(
                      title: Text(item["name"]),
                      onTap: () => cubit.selectCity(item),
                    );
                  },
                ),
              ),

            const SizedBox(height: 10),

            CustomElevatedButton.primary(
              text: "Devam",
              onPressed: state.selectedCity == null
                  ? null
                  : () => cubit.nextPage(),
            ),
          ],
        );
      },
    );
  }
}
