import 'dart:io';

import 'package:equatable/equatable.dart';

class PostState extends Equatable {
  final bool isCreatePostLoading;
  final bool isCreatePostSuccess;
  final String? errorMessage;
  final String? description;
  final double? latitude;
  final double? longitude;

  //1.page
  final bool? isPublic;
  final int currentPage;

  //2.page
  final File? selectedImage;
  final bool isPermissionGranted;
  final bool isPermissionPermanentlyDenied;

  //3.page
  final List<dynamic> citySuggestions;
  final List<dynamic> filteredCities;
  final bool isCityLoading;
  final String? selectedCity;

  //4.page
  final String? selectedDistrict;
  final List<dynamic> filteredDistricts;

  const PostState({
    this.isCreatePostLoading = false,
    this.isCreatePostSuccess = false,
    this.errorMessage,
    this.description,
    this.latitude,
    this.longitude,
    this.isPublic,
    this.currentPage = 0,
    this.selectedImage,
    this.isPermissionGranted = false,
    this.isPermissionPermanentlyDenied = false,
    this.citySuggestions = const [],
    this.filteredCities = const [],
    this.isCityLoading = false,
    this.selectedCity,
    this.selectedDistrict,
    this.filteredDistricts = const [],
  });

  PostState copyWith({
    bool? isCreatePostLoading,
    bool? isCreatePostSuccess,
    String? errorMessage,
    String? description,
    double? latitude,
    double? longitude,
    bool? isPublic,
    int? currentPage,
    File? selectedImage,
    bool? isPermissionGranted,
    bool? isPermissionPermanentlyDenied,
    List<dynamic>? citySuggestions,
    List<dynamic>? filteredCities,
    bool? isCityLoading,
    String? selectedCity,
    String? selectedDistrict,
    List<dynamic>? filteredDistricts,
  }) {
    return PostState(
      isCreatePostLoading: isCreatePostLoading ?? this.isCreatePostLoading,
      isCreatePostSuccess: isCreatePostSuccess ?? this.isCreatePostSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
      description: description ?? this.description,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      isPublic: isPublic ?? this.isPublic,
      currentPage: currentPage ?? this.currentPage,
      selectedImage: selectedImage ?? this.selectedImage,
      isPermissionGranted: isPermissionGranted ?? this.isPermissionGranted,
      isPermissionPermanentlyDenied:
          isPermissionPermanentlyDenied ?? this.isPermissionPermanentlyDenied,
      citySuggestions: citySuggestions ?? this.citySuggestions,
      filteredCities: filteredCities ?? this.filteredCities,
      isCityLoading: isCityLoading ?? this.isCityLoading,
      selectedCity: selectedCity ?? this.selectedCity,
      selectedDistrict: selectedDistrict ?? this.selectedDistrict,
      filteredDistricts: filteredDistricts ?? this.filteredDistricts,
    );
  }

  @override
  List<Object?> get props => [
    isCreatePostLoading,
    isCreatePostSuccess,
    errorMessage,
    description,
    latitude,
    longitude,
    isPublic,
    currentPage,
    selectedImage,
    isPermissionGranted,
    isPermissionPermanentlyDenied,
    citySuggestions,
    filteredCities,
    isCityLoading,
    selectedCity,
    selectedDistrict,
    filteredDistricts,
  ];
}
