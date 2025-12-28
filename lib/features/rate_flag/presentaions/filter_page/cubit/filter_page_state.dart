import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:rate_flag/features/rate_flag/core/enum/filter_list_type.dart';
import 'package:rate_flag/features/rate_flag/core/enum/request_status.dart';
import 'package:rate_flag/features/rate_flag/domain/model/post.dart';
import 'package:rate_flag/features/rate_flag/domain/model/user.dart';

class FilterPageState extends Equatable {
  final RequestStatus userStatus;
  final RequestStatus postStatus;
  final RequestStatus cityStatus;
  final FilterListType filterListType;

  final String? errorMessage;

  final List<User> allUsers;
  final List<User> filteredUsers;

  final List<Post> allPosts;
  final List<Post> filteredPosts;

  final String searchQuery;

  final RangeValues ageRange;
  final String gender;

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
    this.filterListType = FilterListType.users,
  });

  FilterPageState copyWith({
    RequestStatus? userStatus,
    RequestStatus? postStatus,
    String? errorMessage,
    FilterListType? filterListType,
    List<User>? allUsers,
    List<User>? filteredUsers,
    List<Post>? allPosts,
    List<Post>? filteredPosts,
    bool? isPublic,
    bool isPublicSet = false,
    String? searchQuery,
    RangeValues? ageRange,
    String? gender,
    String? selectedCity,
  }) {
    return FilterPageState(
      userStatus: userStatus ?? this.userStatus,
      postStatus: postStatus ?? this.postStatus,
      errorMessage: errorMessage,
      isPublic: isPublicSet ? isPublic : this.isPublic,
      filterListType: filterListType ?? this.filterListType,
      allUsers: allUsers ?? this.allUsers,
      filteredUsers: filteredUsers ?? this.filteredUsers,
      allPosts: allPosts ?? this.allPosts,
      filteredPosts: filteredPosts ?? this.filteredPosts,

      searchQuery: searchQuery ?? this.searchQuery,
      ageRange: ageRange ?? this.ageRange,
      gender: gender ?? this.gender,
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
    filterListType,
    filteredPosts,
    searchQuery,
    ageRange,
    gender,
  ];
}
