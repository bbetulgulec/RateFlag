import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flag/features/RateFlag/presentaions/post/cubit/post_cubit.dart';
import 'package:rate_flag/features/RateFlag/presentaions/post/cubit/post_state.dart';

class Page4 extends StatelessWidget {
  const Page4({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PostCubit>();

    return BlocBuilder<PostCubit, PostState>(
      builder: (context, state) {
        final districts = state.filteredDistricts.isNotEmpty
            ? state.filteredDistricts
            : (state.citySuggestions.firstWhere(
                    (city) => city["name"] == state.selectedCity,
                    orElse: () => {"districts": []},
                  )["districts"] ??
                  []);

        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (state.selectedCity != null)
                Text(
                  "Seçilen şehir: ${state.selectedCity}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              const SizedBox(height: 20),

              TextField(
                onChanged: (query) {
                  cubit.filterDistricts(query);
                },
                decoration: InputDecoration(
                  hintText: "İlçe Ara...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.search),
                ),
              ),
              const SizedBox(height: 10),

              districts.isEmpty
                  ? const Center(child: Text("İlçe bulunamadı"))
                  : Expanded(
                      child: ListView.builder(
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
                child: ElevatedButton(
                  onPressed: state.selectedDistrict == null
                      ? null
                      : () {
                          cubit.nextPage();
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
