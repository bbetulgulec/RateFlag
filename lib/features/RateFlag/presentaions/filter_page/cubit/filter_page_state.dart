import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:rate_flag/features/RateFlag/domain/entity/post.dart';
import 'package:rate_flag/features/RateFlag/domain/entity/user.dart';

class FilterPageState extends Equatable {
  final bool isLoading;
  final bool isPostLoading; // ✅ EKLENDİ
  final String? error;

  final bool isUserLoading;
  final List<User> allUsers;
  final List<User> filteredUsers;

  final List<Post> allPosts;
  final List<Post> filteredPosts;

  final String searchQuery;

  final RangeValues ageRange;
  final String gender;

  final String? selectedCity;

  final bool isCityLoading;
  final String cityQuery;
  final List<dynamic> allCities;
  final List<dynamic> filteredCities;

  const FilterPageState({
    this.isLoading = false,
    this.isPostLoading = false, // ✅ DEFAULT
    this.error,
    this.isUserLoading = false,
    this.allUsers = const [],
    this.filteredUsers = const [],

    this.allPosts = const [],
    this.filteredPosts = const [],

    this.searchQuery = '',

    this.ageRange = const RangeValues(18, 75),
    this.gender = 'all',
    this.selectedCity,

    this.isCityLoading = false,
    this.cityQuery = '',
    this.allCities = const [],
    this.filteredCities = const [],
  });

  FilterPageState copyWith({
    bool? isLoading,
    bool? isPostLoading, // ✅ optional
    String? error,
    bool? isUserLoading,
    List<User>? allUsers,
    List<User>? filteredUsers,
    List<Post>? allPosts,
    List<Post>? filteredPosts,

    String? searchQuery,

    RangeValues? ageRange,
    String? gender,
    String? selectedCity,

    bool? isCityLoading,
    String? cityQuery,
    List<dynamic>? allCities,
    List<dynamic>? filteredCities,
  }) {
    return FilterPageState(
      isLoading: isLoading ?? this.isLoading,
      isPostLoading: isPostLoading ?? this.isPostLoading,
      error: error,
      isUserLoading: isUserLoading ?? this.isUserLoading,
      allUsers: allUsers ?? this.allUsers,
      filteredUsers: filteredUsers ?? this.filteredUsers,
      allPosts: allPosts ?? this.allPosts,
      filteredPosts: filteredPosts ?? this.filteredPosts,

      searchQuery: searchQuery ?? this.searchQuery,

      ageRange: ageRange ?? this.ageRange,
      gender: gender ?? this.gender,
      selectedCity: selectedCity ?? this.selectedCity,

      isCityLoading: isCityLoading ?? this.isCityLoading,
      cityQuery: cityQuery ?? this.cityQuery,
      allCities: allCities ?? this.allCities,
      filteredCities: filteredCities ?? this.filteredCities,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    isPostLoading, // ✅ props’a eklendi
    error,
    allPosts,
    isUserLoading,
    allUsers,
    filteredUsers,
    filteredPosts,
    searchQuery,
    ageRange,
    gender,
    selectedCity,
    isCityLoading,
    cityQuery,
    allCities,
    filteredCities,
  ];
}
