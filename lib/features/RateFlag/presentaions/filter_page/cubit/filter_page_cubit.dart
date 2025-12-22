import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:rate_flag/features/RateFlag/common/constants/api_constants.dart';
import 'package:rate_flag/features/RateFlag/common/utils/functions/calculate_age.dart';
import 'package:rate_flag/features/RateFlag/core/enum/request_status.dart';
import 'package:rate_flag/features/RateFlag/domain/entity/post.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/firestore/load_all_post.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/firestore/load_all_user.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/firestore/search_post_city.dart';
import 'filter_page_state.dart';

class FilterPageCubit extends Cubit<FilterPageState> {
  FilterPageCubit(this.searchPostCity, this.loadAllUser, this.loadAllPost)
    : super(const FilterPageState());
  final SearchPostCity searchPostCity;
  final LoadAllUser loadAllUser;
  final LoadAllPost loadAllPost;

  Future<void> loadCities() async {
    emit(state.copyWith(cityStatus: RequestStatus.loading));

    final response = await http.get(Uri.parse(kTurkeyCitiesApiUrl));
    final data = jsonDecode(response.body);

    emit(
      state.copyWith(
        cityStatus: RequestStatus.success,
        allCities: data["data"],
        filteredCities: data["data"],
      ),
    );
  }

  Future<void> selectCity(String city) async {
    emit(
      state.copyWith(selectedCity: city, cityQuery: city, filteredCities: []),
    );

    await loadPostsBySelectedCity(city);
  }

  Future<void> loadPostsBySelectedCity(String city) async {
    emit(state.copyWith(postStatus: RequestStatus.loading));

    final posts = await searchPostCity.execute(city);

    emit(
      state.copyWith(
        postStatus: RequestStatus.success,
        allPosts: posts,
        filteredPosts: posts,
      ),
    );
  }

  void search(String query) {
    final q = query.toLowerCase();

    final filtered = state.allPosts.where((post) {
      return post.description.toLowerCase().contains(q);
    }).toList();

    emit(state.copyWith(searchQuery: query, filteredPosts: filtered));
  }

  void searchUser(String query) {
    final q = query.toLowerCase();

    final filtered = state.allUsers.where((user) {
      final fullName = "${user.firstName} ${user.lastName}".toLowerCase();
      return fullName.contains(q);
    }).toList();

    emit(state.copyWith(filteredUsers: filtered));
  }

  Future<void> loadAllUsers() async {
    emit(state.copyWith(userStatus: RequestStatus.loading));

    try {
      final users = await loadAllUser.execute();

      emit(
        state.copyWith(
          userStatus: RequestStatus.success,
          allUsers: users,
          filteredUsers: users,
        ),
      );
    } catch (e) {
      emit(state.copyWith(userStatus: RequestStatus.failure));
    }
  }

  void selectGender(String gender) {
    emit(state.copyWith(gender: gender));
  }

  void applyFilters(RangeValues ageRange, String gender, String? city) {
    emit(
      state.copyWith(ageRange: ageRange, gender: gender, selectedCity: city),
    );

    final ageCalculator = Calculateage();

    final filtered = state.allUsers.where((user) {
      final int age = ageCalculator.calculateAge(user.birthDate);
      final int minAge = ageRange.start.round();
      final int maxAge = ageRange.end.round();
      final bool matchesAge = age >= minAge && age <= maxAge;

      final bool matchesGender =
          gender == 'all' ||
          (user.gender.toString().toLowerCase() == gender.toLowerCase());

      return matchesAge && matchesGender;
    }).toList();

    emit(state.copyWith(filteredUsers: filtered));
  }

  void clearFilters() {
    emit(
      state.copyWith(
        ageRange: const RangeValues(18, 75),
        selectedCity: null,
        gender: 'all',
      ),
    );
    emit(state.copyWith(filteredUsers: state.allUsers));
  }

  void filterByAge(RangeValues range) {
    emit(state.copyWith(ageRange: range));

    final ageCalculator = Calculateage();

    final filtered = state.allUsers.where((user) {
      final int age = ageCalculator.calculateAge(user.birthDate);

      final int minAge = range.start.round();
      final int maxAge = range.end.round();

      return age >= minAge && age <= maxAge;
    }).toList();

    emit(state.copyWith(filteredUsers: filtered));
  }

  Future<void> loadPosts() async {
    emit(state.copyWith(postStatus: RequestStatus.loading));

    final posts = await loadAllPost.execute();

    emit(
      state.copyWith(
        postStatus: RequestStatus.success,
        allPosts: posts,
        filteredPosts: posts,
      ),
    );
  }

  void filterPosts() {
    List<Post> posts = state.allPosts;

    // 🔹 isPublic filtresi
    if (state.isPublic != null) {
      posts = posts.where((post) => post.isPublic == state.isPublic).toList();
    }

    emit(state.copyWith(filteredPosts: posts));
  }

  void setIsPublic(bool? value) {
    emit(state.copyWith(isPublic: value));
  }
}
