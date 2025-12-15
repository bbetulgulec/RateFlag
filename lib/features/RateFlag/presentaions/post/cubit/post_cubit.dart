import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rate_flag/features/RateFlag/domain/entity/post.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/create_post_user_usecase.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/upload_image_storage_user_usecase.dart';
import 'package:rate_flag/features/RateFlag/presentaions/home/cubit/home_cubit.dart';
import 'package:rate_flag/features/RateFlag/presentaions/post/cubit/post_state.dart';

class PostCubit extends Cubit<PostState> {
  final CreatePostUserUsecase createPostUserUsecase;
  final UploadImageStorageUserUsecase uploadImageUsecase;

  PostCubit(this.createPostUserUsecase, this.uploadImageUsecase)
    : super(const PostState());
  Future<void> createPost(Post post, BuildContext context) async {
    print("createPost started: ${post.postId}");
    emit(state.copyWith(isCreatePostLoading: true));
    try {
      final coords = await fetchCoordinates(
        city: post.city,
        district: post.district,
      );

      String? uploadedImageUrl;
      if (post.imageUrl != null) {
        uploadedImageUrl = await uploadImageUsecase.execute(
          File(post.imageUrl!),
          post.postId,
        );

        // 🔥 STORAGE URL'yi post nesnesine yaz
        post = Post(
          postId: post.postId,
          userId: post.userId,
          description: post.description,
          imageUrl: uploadedImageUrl,
          isPublic: post.isPublic,
          date: post.date,
          city: post.city,
          district: post.district,
          latitude: coords["latitude"]!,
          longitude: coords["longitude"]!,
          createdAt: DateTime.now(),
        );
      }

      try {
        await createPostUserUsecase.execute(
          collection: "posts",
          data: {
            "postId": post.postId,
            "userId": post.userId,
            "description": post.description,
            "imageUrl": uploadedImageUrl,
            "isPublic": post.isPublic,
            "date": post.date.toIso8601String(),
            "city": post.city,
            "district": post.district,
            "latitude": post.latitude,
            "longitude": post.longitude,
            "createdAt": post.createdAt?.toIso8601String(),
          },
          post: post,
        );
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(" Post Paylaşıldı")));
        print("Post successfully saved to Firestore");
      } catch (e) {
        print("Firestore save failed: $e");
      }

      final homeCubit = context.read<HomeCubit>();
      homeCubit.addPost(post);
      emit(
        state.copyWith(isCreatePostLoading: false, isCreatePostSuccess: true),
      );
    } catch (e) {
      print("createPost ERROR: $e");
      emit(
        state.copyWith(
          isCreatePostLoading: false,
          isCreatePostSuccess: false,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  // UI event: public/private seçimi
  void setPublic(bool value, {bool goNext = true}) {
    final nextPage = goNext ? state.currentPage + 1 : state.currentPage;
    emit(state.copyWith(isPublic: value, currentPage: nextPage));
  }

  // Page kontrol
  void goToPage(int page) {
    emit(state.copyWith(currentPage: page));
  }

  void nextPage() {
    emit(state.copyWith(currentPage: state.currentPage + 1));
  }

  void previousPage() {
    emit(state.copyWith(currentPage: (state.currentPage - 1).clamp(0, 10)));
  }

  Future<void> checkGalleryPermission() async {
    var status = await Permission.photos.request();

    if (status.isGranted) {
      emit(state.copyWith(isPermissionGranted: true));
    } else if (status.isPermanentlyDenied) {
      emit(state.copyWith(isPermissionPermanentlyDenied: true));
    } else {
      emit(state.copyWith(isPermissionGranted: false));
    }
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      emit(state.copyWith(selectedImage: File(image.path)));
    }
  }

  Future<void> searchCities(String query) async {
    if (query.length < 2) {
      emit(state.copyWith(citySuggestions: []));
      return;
    }

    emit(state.copyWith(isCityLoading: true));

    final url = Uri.parse(
      "https://turkiyeapi.dev/api/v1/provinces?name=$query",
    );

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        emit(
          state.copyWith(citySuggestions: data["data"], isCityLoading: false),
        );
      } else {
        emit(state.copyWith(isCityLoading: false));
      }
    } catch (e) {
      emit(state.copyWith(isCityLoading: false));
    }
  }

  void selectCity(Map<String, dynamic> city) {
    final coords = city["coordinates"];

    emit(
      state.copyWith(
        selectedCity: city["name"],
        latitude: coords?["latitude"] != null
            ? (coords!["latitude"] as num).toDouble()
            : null,
        longitude: coords?["longitude"] != null
            ? (coords!["longitude"] as num).toDouble()
            : null,
        currentPage: state.currentPage + 1,
      ),
    );
  }

  void selectDistrict(String districtName) {
    emit(
      state.copyWith(
        selectedDistrict: districtName,
        currentPage: state.currentPage + 1,
      ),
    );
  }

  void setDistricts(List<dynamic> districts) {
    emit(state.copyWith(citySuggestions: districts));
  }

  void setDescription(String description) {
    emit(state.copyWith(description: description));
  }

  void filterDistricts(String query) {
    final cityData = state.citySuggestions.firstWhere(
      (city) => city["name"] == state.selectedCity,
      orElse: () => {"districts": []},
    );

    final districts = List.from(cityData["districts"] ?? []);
    final filtered = districts
        .where(
          (d) => (d["name"] ?? "").toString().toLowerCase().contains(
            query.toLowerCase(),
          ),
        )
        .toList();

    emit(state.copyWith(filteredDistricts: filtered));
  }

  Future<Map<String, double>> fetchCoordinates({
    required String city,
    required String district,
  }) async {
    final url = Uri.parse(
      'https://nominatim.openstreetmap.org/search'
      '?q=$district,$city,Turkey'
      '&format=json'
      '&limit=1',
    );

    final response = await http.get(
      url,
      headers: {'User-Agent': 'rate-flag-app'},
    );

    if (response.statusCode != 200) {
      throw Exception("Konum servisine ulaşılamadı");
    }

    final data = jsonDecode(response.body);

    if (data.isEmpty) {
      throw Exception("Bu ilçe için koordinat bulunamadı");
    }

    final latRaw = data[0]["lat"];
    final lonRaw = data[0]["lon"];

    return {
      "latitude": latRaw is String
          ? double.parse(latRaw)
          : (latRaw as num).toDouble(),
      "longitude": lonRaw is String
          ? double.parse(lonRaw)
          : (lonRaw as num).toDouble(),
    };
  }
}
