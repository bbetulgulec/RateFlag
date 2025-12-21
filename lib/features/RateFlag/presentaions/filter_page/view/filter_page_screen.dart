import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flag/features/RateFlag/common/widgets/buttons/commun_text_button.dart';
import 'package:rate_flag/features/RateFlag/common/widgets/text_fields/custom_text_field.dart';
import 'package:rate_flag/features/RateFlag/presentaions/follow_list/widget/follow_user_tile.dart';
import '../cubit/filter_page_cubit.dart';
import '../cubit/filter_page_state.dart';

class FilterPage extends StatelessWidget {
  const FilterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterPageCubit, FilterPageState>(
      builder: (context, state) {
        final cubit = context.read<FilterPageCubit>();

        return Scaffold(
          appBar: AppBar(
            title: CustomTextField(
              hintText: "SEARCH USER",
              keyboardType: TextInputType.text,
              onChanged: cubit.searchUser,
              label: '',
            ),
            actions: [
              CommunTextButton(
                text: "Filtrele",
                onPressed: () {
                  _showFilterBottomSheet(context);
                },
              ),
            ],
          ),
          body: _buildBody(context, state),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, FilterPageState state) {
    if (state.isUserLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.filteredUsers.isEmpty) {
      return const Center(child: Text("Kullanıcı bulunamadı"));
    }

    return ListView.builder(
      itemCount: state.filteredUsers.length,
      itemBuilder: (context, index) {
        final user = state.filteredUsers[index];
        return FollowUserTile(
          fullName: "${user.firstName} ${user.lastName}",
          photoUrl: user.photoUrl,
        );
      },
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    final cubit = context.read<FilterPageCubit>();

    // Yerel değişkenler - bottom sheet kapandığında kaybolur
    RangeValues currentAgeRange = cubit.state.ageRange;
    String currentGender = cubit.state.gender;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (bottomSheetContext) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Başlık + Temizle
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Filtreler",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          cubit.clearFilters();
                          setState(() {
                            currentAgeRange = const RangeValues(18, 75);
                            currentGender = 'all';
                          });
                        },
                        child: const Text(
                          "Temizle",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Yaş Aralığı
                  const Text(
                    "Yaş aralığı:",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 10),
                  RangeSlider(
                    values: currentAgeRange,
                    min: 18,
                    max: 75,
                    divisions: 57,
                    labels: RangeLabels(
                      currentAgeRange.start.round().toString(),
                      currentAgeRange.end.round().toString(),
                    ),
                    onChanged: (newRange) {
                      setState(() {
                        currentAgeRange = newRange;
                      });
                    },
                  ),
                  Center(
                    child: Text(
                      "${currentAgeRange.start.round()} - ${currentAgeRange.end.round()} yaş",
                      style: const TextStyle(fontSize: 16, color: Colors.blue),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Cinsiyet
                  const Text(
                    "Cinsiyet:",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 10),
                  RadioListTile<String>(
                    title: const Text("All"),
                    value: 'all',
                    groupValue: currentGender,
                    activeColor: Colors.blue,
                    onChanged: (value) {
                      setState(() => currentGender = value!);
                      cubit.selectGender(value!); // Anında filtre uygula
                    },
                  ),
                  RadioListTile<String>(
                    title: const Text("Male"),
                    value: 'male',
                    groupValue: currentGender,
                    activeColor: Colors.blue,
                    onChanged: (value) {
                      setState(() => currentGender = value!);
                      cubit.selectGender(value!);
                    },
                  ),
                  RadioListTile<String>(
                    title: const Text("Female"),
                    value: 'female',
                    groupValue: currentGender,
                    activeColor: Colors.blue,
                    onChanged: (value) {
                      setState(() => currentGender = value!);
                      cubit.selectGender(value!);
                    },
                  ),
                  const SizedBox(height: 30),

                  // Şehir
                  const Text(
                    "Şehir:",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 10),
                  if (cubit.state.filteredCities.isNotEmpty)
                    SizedBox(
                      height: 200,
                      child: ListView.builder(
                        itemCount: cubit.state.filteredCities.length,
                        itemBuilder: (_, index) {
                          final city = cubit.state.filteredCities[index];
                          return ListTile(
                            title: Text(city["name"]),
                            trailing: cubit.state.selectedCity == city["name"]
                                ? const Icon(Icons.check, color: Colors.blue)
                                : null,
                            onTap: () {
                              cubit.selectCity(city["name"]);
                            },
                          );
                        },
                      ),
                    ),
                  const SizedBox(height: 30),

                  // Uygula Butonu - Sadece yaşı günceller, gerisi zaten aktif
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        cubit.filterByAge(
                          currentAgeRange,
                        ); // applyAllFilters burada çağrılacak
                        Navigator.pop(bottomSheetContext);
                      },
                      child: const Text("Uygula"),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
