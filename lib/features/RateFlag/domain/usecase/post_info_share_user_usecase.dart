import 'package:share_plus/share_plus.dart';

class PostInfoShareUserUsecase {
  PostInfoShareUserUsecase();

  Future<void> execute({
    required String description,
    required String userName,
    required String city,
    required String district,
    String? imageUrl,
  }) async {
    final message =
        """
$userName adlı kullanıcının paylaşımı:

$description

📍 $city / $district
""";

    try {
      await Share.share(message);
    } catch (e) {
      print("Share ERROR: $e");
      rethrow;
    }
  }
}
