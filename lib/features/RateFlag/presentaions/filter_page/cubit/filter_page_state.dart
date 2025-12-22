import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:rate_flag/features/RateFlag/core/enum/request_status.dart';
import 'package:rate_flag/features/RateFlag/domain/entity/post.dart';
import 'package:rate_flag/features/RateFlag/domain/entity/user.dart';

class FilterPageState extends Equatable {
  final RequestStatus userStatus;
  final RequestStatus postStatus;
  final RequestStatus cityStatus;

  final String? errorMessage;

  final List<User> allUsers;
  final List<User> filteredUsers;

  final List<Post> allPosts;
  final List<Post> filteredPosts;

  final String searchQuery;

  final RangeValues ageRange;
  final String gender;
  final String? selectedCity;

  final String cityQuery;
  final List<dynamic> allCities;
  final List<dynamic> filteredCities;
  final bool? isPublic;

  const FilterPageState({
    this.userStatus = RequestStatus.initial,
    this.postStatus = RequestStatus.initial,
    this.cityStatus = RequestStatus.initial,
    this.errorMessage,

    this.allUsers = const [],
    this.filteredUsers = const [],

    this.allPosts = const [],
    this.filteredPosts = const [],
    this.isPublic,
    this.searchQuery = '',
    this.ageRange = const RangeValues(18, 75),
    this.gender = 'all',
    this.selectedCity,

    this.cityQuery = '',
    this.allCities = const [],
    this.filteredCities = const [],
  });

  FilterPageState copyWith({
    RequestStatus? userStatus,
    RequestStatus? postStatus,
    RequestStatus? cityStatus,
    String? errorMessage,

    List<User>? allUsers,
    List<User>? filteredUsers,
    List<Post>? allPosts,
    List<Post>? filteredPosts,
    bool? isPublic,
    String? searchQuery,
    RangeValues? ageRange,
    String? gender,
    String? selectedCity,

    String? cityQuery,
    List<dynamic>? allCities,
    List<dynamic>? filteredCities,
  }) {
    return FilterPageState(
      userStatus: userStatus ?? this.userStatus,
      postStatus: postStatus ?? this.postStatus,
      cityStatus: cityStatus ?? this.cityStatus,
      errorMessage: errorMessage,
      isPublic: isPublic ?? this.isPublic,
      allUsers: allUsers ?? this.allUsers,
      filteredUsers: filteredUsers ?? this.filteredUsers,
      allPosts: allPosts ?? this.allPosts,
      filteredPosts: filteredPosts ?? this.filteredPosts,

      searchQuery: searchQuery ?? this.searchQuery,
      ageRange: ageRange ?? this.ageRange,
      gender: gender ?? this.gender,
      selectedCity: selectedCity ?? this.selectedCity,

      cityQuery: cityQuery ?? this.cityQuery,
      allCities: allCities ?? this.allCities,
      filteredCities: filteredCities ?? this.filteredCities,
    );
  }

  @override
  List<Object?> get props => [
    userStatus,
    postStatus,
    cityStatus,
    errorMessage,
    allUsers,
    filteredUsers,
    isPublic,
    allPosts,
    filteredPosts,
    searchQuery,
    ageRange,
    gender,
    selectedCity,
    cityQuery,
    allCities,
    filteredCities,
  ];
}
