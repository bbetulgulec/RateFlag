import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flag/app/common/functions/calculate_age.dart';
import 'package:rate_flag/app/common/enum/filter_list_type.dart';
import 'package:rate_flag/app/common/enum/request_status.dart';
import 'package:rate_flag/app/features/data/usecase/firestore/load_all_post.dart';
import 'package:rate_flag/app/features/data/usecase/firestore/load_all_user.dart';
import 'package:rate_flag/app/features/data/usecase/firestore/search_post_city.dart';
import 'filter_page_state.dart';

class FilterPageCubit extends Cubit<FilterPageState> {
  FilterPageCubit(this.searchPostCity, this.loadAllUser, this.loadAllPost)
    : super(const FilterPageState());
  final SearchPostCity searchPostCity;
  final LoadAllUser loadAllUser;
  final LoadAllPost loadAllPost;

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

  void applyFilters(RangeValues ageRange, String gender) {
    emit(state.copyWith(ageRange: ageRange, gender: gender));

    final ageCalculator = Calculateage();

    final filtered = state.allUsers.where((user) {
      final int age = ageCalculator.calculateAge(user.birthDate);
      final int minAge = ageRange.start.round();
      final int maxAge = ageRange.end.round();
      final bool matchesAge = age >= minAge && age <= maxAge;

      final bool matchesGender = gender == 'all' || user.gender.name == gender;

      return matchesAge && matchesGender;
    }).toList();

    emit(state.copyWith(filteredUsers: filtered));
  }

  void applySelectedFilters() {
    if (state.filterListType == FilterListType.users) {
      applyFilters(state.ageRange, state.gender);
    } else if (state.filterListType == FilterListType.posts) {
      filterPosts();
    }
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

  void filterUsers() {
    final ageCalculator = Calculateage();

    final filtered = state.allUsers.where((user) {
      final int age = ageCalculator.calculateAge(user.birthDate);

      final bool ageOk =
          age >= state.ageRange.start && age <= state.ageRange.end;

      final bool genderOk =
          state.gender == 'all' ||
          user.gender.name.toLowerCase() == state.gender.toLowerCase();

      return ageOk && genderOk;
    }).toList();

    emit(state.copyWith(filteredUsers: filtered));
  }

  void changeAgeRange(RangeValues range) {
    emit(state.copyWith(ageRange: range));
  }

  void selectGender(String gender) {
    emit(state.copyWith(gender: gender));
  }

  void selectfilterListType(FilterListType list) {
    emit(state.copyWith(filterListType: list));
  }

  void setIsPublic(bool? value) {
    emit(state.copyWith(isPublic: value, isPublicSet: true));
  }

  void filterPosts() {
    final filtered = state.allPosts.where((post) {
      final bool publicOk =
          state.isPublic == null || post.isPublic == state.isPublic;

      return publicOk;
    }).toList();

    emit(state.copyWith(filteredPosts: filtered));
  }

  void isSelectFilterType() {
    if (state.filterListType == FilterListType.users) {
      applySelectedFilters();
    } else if (state.filterListType == FilterListType.posts) {
      filterPosts();
    }
  }
}
