import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rate_flag/features/RateFlag/common/constants/api_constants.dart';
import 'package:rate_flag/features/RateFlag/common/constants/text_constant.dart';
import 'package:rate_flag/features/RateFlag/domain/model/post.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/firestore/create_post.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/local/local_send_notification.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/storage/upload_image_storage.dart';
import 'package:rate_flag/features/RateFlag/presentaions/post/cubit/post_state.dart';

class PostCubit extends Cubit<PostState> {
  final CreatePost createPostUserUsecase;
  final UploadImageStorage uploadImageUsecase;
  final LocalSendNotification localSendNotification;

  PostCubit(
    this.createPostUserUsecase,
    this.uploadImageUsecase,
    this.localSendNotification,
  ) : super(
        PostState(
          draftPost: Post(
            postId: 'post_${DateTime.now().millisecondsSinceEpoch}',
            userId: FirebaseAuth.instance.currentUser?.uid ?? "CURRENT_USER_ID",
            isPublic: true,
            date: DateTime.now(),
            city: '',
            district: '',
            description: '',
            latitude: 0,
            longitude: 0,
          ),
        ),
      ) {
    loadAllCities();
  }

  final ImagePicker picker = ImagePicker();

  void onCityQueryChanged(String query) {
    emit(state.copyWith(cityQuery: query));
    searchCities(query);
  }

  void onDistrictQueryChanged(String query) {
    emit(state.copyWith(districtQuery: query));
    filterDistricts(query);
  }

  Future<void> createPost() async {
    final post = state.draftPost!;
    if (post.imageUrl == null) {
      emit(
        state.copyWith(
          isCreatePostLoading: false,
          isCreatePostSuccess: false,
          errorMessage: TextConstants.pleaseChooseImge,
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
            errorMessage: TextConstants.uploadMistakeImage,
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

      final city = post.city;
      final uid = FirebaseAuth.instance.currentUser!.uid;

      await localSendNotification.call(
        userId: uid,
        title: TextConstants.uploasingPost,
        body: "$city ${TextConstants.shareLocationPost}",
      );

      emit(
        state.copyWith(isCreatePostLoading: false, isCreatePostSuccess: true),
      );

      print(TextConstants.successSavePost);
    } catch (e) {
      emit(
        state.copyWith(
          isCreatePostLoading: false,
          isCreatePostSuccess: false,
          errorMessage: e.toString(),
        ),
      );
      print("${TextConstants.error} $e");
    }
  }

  void setPublic(bool value, {bool goNext = true}) {
    final updatedPost = state.draftPost!.copyWith(isPublic: value);

    emit(
      state.copyWith(
        draftPost: updatedPost,
        currentPage: goNext ? state.currentPage + 1 : state.currentPage,
      ),
    );
  }

  // Page kontrol
  void goToPage(int page) {
    emit(state.copyWith(currentPage: page));
  }

  void nextPage() {
    emit(state.copyWith(currentPage: state.currentPage + 1));
  }

  void previousPage() {
    if (state.currentPage > 0) {
      emit(state.copyWith(currentPage: state.currentPage - 1));
    }
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
      emit(
        state.copyWith(
          selectedImage: File(pickedFile.path),
          draftPost: state.draftPost!.copyWith(imageUrl: pickedFile.path),
        ),
      );
    }
  }

  Future<void> pickFromCamera() async {
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
    );

    if (pickedFile == null) return;

    emit(
      state.copyWith(
        selectedImage: File(pickedFile.path),
        draftPost: state.draftPost!.copyWith(imageUrl: pickedFile.path),
      ),
    );
  }

  void searchCities(String query) {
    final allCities = state.citySuggestions;

    final filtered = query.isEmpty
        ? allCities
        : allCities.where((c) {
            return (c["name"] ?? "").toString().toLowerCase().contains(
              query.toLowerCase(),
            );
          }).toList();

    emit(state.copyWith(filteredCities: filtered));
  }

  void selectCity({required String cityName}) {
    final updatedPost = state.draftPost!.copyWith(city: cityName);

    emit(
      state.copyWith(
        draftPost: updatedPost,
        currentPage: state.currentPage + 1,
      ),
    );
  }

  Future<void> loadAllCities() async {
    emit(state.copyWith(isCityLoading: true));

    final url = Uri.parse(kTurkeyCitiesApiUrl);

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

  Future<void> selectDistrict(String districtName) async {
    final city = state.draftPost!.city;

    // önce district set et
    emit(
      state.copyWith(
        draftPost: state.draftPost!.copyWith(district: districtName),
      ),
    );

    //  koordinat çek
    final coords = await fetchCoordinates(city: city, district: districtName);

    final updatedPost = state.draftPost!.copyWith(
      latitude: coords["latitude"]!,
      longitude: coords["longitude"]!,
    );

    emit(
      state.copyWith(
        draftPost: updatedPost,
        currentPage: state.currentPage + 1,
      ),
    );
  }

  void setDescription(String description) {
    final updatedPost = state.draftPost!.copyWith(description: description);

    emit(state.copyWith(draftPost: updatedPost));
  }

  void filterDistricts(String query) {
    final cityName = state.draftPost?.city;
    if (cityName == null || cityName.isEmpty) {
      emit(state.copyWith(filteredDistricts: []));
      return;
    }

    final city = state.citySuggestions.firstWhere(
      (c) => c["name"] == cityName,
      orElse: () => {"districts": []},
    );

    final districts = List<Map<String, dynamic>>.from(city["districts"] ?? []);

    final filtered = query.isEmpty
        ? districts
        : districts.where((d) {
            return (d["name"] ?? "").toString().toLowerCase().contains(
              query.toLowerCase(),
            );
          }).toList();

    emit(state.copyWith(filteredDistricts: filtered));
  }

  Future<Map<String, double>> fetchCoordinates({
    required String city,
    required String district,
  }) async {
    final url = Uri.parse(
      '$openstreetmap'
      '?q=$district,$city,Turkey'
      '&format=json'
      '&limit=1',
    );

    final response = await http.get(
      url,
      headers: {'User-Agent': 'rate-flag-app'},
    );

    if (response.statusCode != 200) {
      throw Exception(TextConstants.didNotFoundLocationService);
    }

    final data = jsonDecode(response.body);

    if (data.isEmpty) {
      throw Exception(TextConstants.didNotFoundDistricService);
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
