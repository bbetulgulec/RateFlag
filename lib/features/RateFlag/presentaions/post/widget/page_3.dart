import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flag/features/RateFlag/presentaions/post/cubit/post_cubit.dart';
import 'package:rate_flag/features/RateFlag/presentaions/post/cubit/post_state.dart';

class Page3 extends StatelessWidget {
  const Page3({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PostCubit>();

    return BlocBuilder<PostCubit, PostState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Where can you be found?',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              TextField(
                onChanged: (value) => cubit.searchCities(value),
                decoration: InputDecoration(
                  hintText: "Şehir Ara...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.search),
                ),
              ),

              const SizedBox(height: 15),

              /// ✔ Seçilen şehir burada gösteriliyor
              if (state.selectedCity != null)
                Text(
                  "Seçilen şehir: ${state.selectedCity}",
                  style: const TextStyle(
                    color: Colors.blue,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),

              const SizedBox(height: 10),

              if (state.isCityLoading)
                const Center(child: CircularProgressIndicator()),

              if (!state.isCityLoading)
                Expanded(
                  child: ListView.builder(
                    itemCount: state.citySuggestions.length,
                    itemBuilder: (context, index) {
                      final item = state.citySuggestions[index];

                      return ListTile(
                        title: Text(item["name"]),
                        onTap: () {
                          cubit.selectCity(item["name"]); // Şehir seç
                        },
                      );
                    },
                  ),
                ),

              const SizedBox(height: 10),

              /// ✔ İlerle butonu (şehir seçilmeden basılamaz)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: state.selectedCity == null
                      ? null
                      : () {
                          context.read<PostCubit>().nextPage();
                        },
                  child: const Text("İlerle"),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
