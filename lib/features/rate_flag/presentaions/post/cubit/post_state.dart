import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:rate_flag/features/RateFlag/domain/model/post.dart';

class PostState extends Equatable {
  final bool isCreatePostLoading;
  final bool isCreatePostSuccess;
  final String? errorMessage;

  final Post? draftPost;

  //1.page

  final int currentPage;

  //2.page
  final File? selectedImage;
  final bool isPermissionGranted;
  final bool isPermissionPermanentlyDenied;
  final String cityQuery;

  //3.page
  final List<dynamic> citySuggestions;
  final List<dynamic> filteredCities;
  final bool isCityLoading;
  final String districtQuery;

  //4.page

  final List<dynamic> filteredDistricts;

  const PostState({
    this.isCreatePostLoading = false,
    this.isCreatePostSuccess = false,
    this.errorMessage,

    this.currentPage = 0,
    this.selectedImage,
    this.isPermissionGranted = false,
    this.isPermissionPermanentlyDenied = false,
    this.cityQuery = '',
    this.citySuggestions = const [],
    this.filteredCities = const [],
    this.isCityLoading = false,
    this.districtQuery = '',

    this.filteredDistricts = const [],
    this.draftPost,
  });

  PostState copyWith({
    bool? isCreatePostLoading,
    bool? isCreatePostSuccess,
    String? errorMessage,

    int? currentPage,
    File? selectedImage,
    bool? isPermissionGranted,
    bool? isPermissionPermanentlyDenied,
    String? cityQuery,
    List<dynamic>? citySuggestions,
    List<dynamic>? filteredCities,
    bool? isCityLoading,
    String? districtQuery,

    List<dynamic>? filteredDistricts,
    Post? draftPost,
  }) {
    return PostState(
      isCreatePostLoading: isCreatePostLoading ?? this.isCreatePostLoading,
      isCreatePostSuccess: isCreatePostSuccess ?? this.isCreatePostSuccess,
      errorMessage: errorMessage ?? this.errorMessage,

      currentPage: currentPage ?? this.currentPage,
      selectedImage: selectedImage ?? this.selectedImage,
      isPermissionGranted: isPermissionGranted ?? this.isPermissionGranted,
      isPermissionPermanentlyDenied:
          isPermissionPermanentlyDenied ?? this.isPermissionPermanentlyDenied,
      cityQuery: cityQuery ?? this.cityQuery,
      citySuggestions: citySuggestions ?? this.citySuggestions,
      filteredCities: filteredCities ?? this.filteredCities,
      isCityLoading: isCityLoading ?? this.isCityLoading,
      districtQuery: districtQuery ?? this.districtQuery,

      filteredDistricts: filteredDistricts ?? this.filteredDistricts,
      draftPost: draftPost ?? this.draftPost,
    );
  }

  @override
  List<Object?> get props => [
    isCreatePostLoading,
    isCreatePostSuccess,
    errorMessage,

    currentPage,
    selectedImage,
    isPermissionGranted,
    isPermissionPermanentlyDenied,
    cityQuery,
    citySuggestions,
    filteredCities,
    isCityLoading,
    districtQuery,
    filteredDistricts,
    draftPost,
  ];
}
