import 'dart:convert';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rate_flag/features/RateFlag/domain/entity/post.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/firestore/create_post.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/storage/upload_image_storage.dart';
import 'package:rate_flag/features/RateFlag/presentaions/post/cubit/post_state.dart';

class PostCubit extends Cubit<PostState> {
  final CreatePost createPostUserUsecase;
  final UploadImageStorage uploadImageUsecase;

  PostCubit(this.createPostUserUsecase, this.uploadImageUsecase)
    : super(const PostState()) {
    loadAllCities();
  }

  final ImagePicker picker = ImagePicker();

  Future<void> createPost(Post post) async {
    if (post.imageUrl == null) {
      emit(
        state.copyWith(
          isCreatePostLoading: false,
          isCreatePostSuccess: false,
          errorMessage: "Lütfen bir resim seçin!",
        ),
      );
      return;
    }

    emit(state.copyWith(isCreatePostLoading: true));

    try {
      // Storage'a yükle
      final uploadedImageUrl = await uploadImageUsecase.execute(
        File(post.imageUrl!),
        post.postId,
      );

      if (uploadedImageUrl == null) {
        emit(
          state.copyWith(
            isCreatePostLoading: false,
            isCreatePostSuccess: false,
            errorMessage: "Resim yüklenirken bir hata oluştu",
          ),
        );
        return;
      }

      // Firestore'a kaydedilecek post objesi
      final postToSave = post.copyWith(
        imageUrl: uploadedImageUrl, // artık Storage URL
        createdAt: DateTime.now(),
      );

      await createPostUserUsecase.execute(post: postToSave);

      emit(
        state.copyWith(isCreatePostLoading: false, isCreatePostSuccess: true),
      );

      print("Post başarıyla kaydedildi!");
    } catch (e) {
      emit(
        state.copyWith(
          isCreatePostLoading: false,
          isCreatePostSuccess: false,
          errorMessage: e.toString(),
        ),
      );
      print("createPost ERROR: $e");
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

  Future<void> pickFromGallery() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (pickedFile != null) {
      emit(state.copyWith(selectedImage: File(pickedFile.path)));
    }
  }

  Future<void> pickFromCamera() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
    );

    if (pickedFile != null) {
      emit(state.copyWith(selectedImage: File(pickedFile.path)));
    }
  }

  void searchCities(String query) {
    final allCities = state.citySuggestions;

    if (query.isEmpty) {
      emit(state.copyWith(filteredCities: allCities));
      return;
    }

    final filtered = allCities
        .where(
          (c) =>
              c["name"].toString().toLowerCase().contains(query.toLowerCase()),
        )
        .toList();

    emit(state.copyWith(filteredCities: filtered));
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

  Future<void> loadAllCities() async {
    emit(state.copyWith(isCityLoading: true));

    final url = Uri.parse("https://turkiyeapi.dev/api/v1/provinces");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        emit(
          state.copyWith(
            citySuggestions: data["data"],
            filteredCities: data["data"],
            isCityLoading: false,
          ),
        );
      } else {
        emit(state.copyWith(isCityLoading: false));
      }
    } catch (_) {
      emit(state.copyWith(isCityLoading: false));
    }
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
