import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flag/features/RateFlag/common/widget/elevatedButtonWidget.dart';
import 'package:rate_flag/features/RateFlag/common/widget/rateFlagText.dart';
import 'package:rate_flag/features/RateFlag/common/widget/rateFlagTextField.dart';
import 'package:rate_flag/features/RateFlag/presentaions/post/cubit/post_cubit.dart';
import 'package:rate_flag/features/RateFlag/presentaions/post/cubit/post_state.dart';
import 'package:rate_flag/features/RateFlag/presentaions/post/widget/page_list_view.dart';

class Page3 extends StatelessWidget {
  const Page3({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PostCubit>();
    final cityController = TextEditingController();

    return BlocBuilder<PostCubit, PostState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Rateflagtext.Maintitle(text: "Sizi nerede bulabiliriz ?"),

              const SizedBox(height: 20),
              Rateflagtextfield(
                controller: cityController,

                icon: Icons.search,
                keyboardType: TextInputType.text,
                onChanged: (value) => cubit.searchCities(value),
                label: 'Şehir ara ',
              ),

              const SizedBox(height: 15),

              if (state.isCityLoading)
                const Center(child: CircularProgressIndicator()),

              if (!state.isCityLoading)
                Expanded(
                  child: PageListView(
                    itemCount: state.citySuggestions.length,
                    itemBuilder: (context, index) {
                      final item = state.citySuggestions[index];

                      return ListTile(
                        title: Text(item["name"]),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () {
                          cubit.selectCity(item["name"]);
                        },
                      );
                    },
                  ),
                ),

              const SizedBox(height: 10),

              /// ✔ İlerle butonu (şehir seçilmeden basılamaz)
              SizedBox(
                child: Onboardingelevetedbutton.primary(
                  text: "Devam",
                  onPressed: () {
                    state.selectedCity == null
                        ? null
                        : () {
                            context.read<PostCubit>().nextPage();
                          };
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
