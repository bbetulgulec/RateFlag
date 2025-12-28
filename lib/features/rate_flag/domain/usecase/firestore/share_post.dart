import 'package:flutter/foundation.dart';
import 'package:share_plus/share_plus.dart';

class PostShare {
  PostShare();

  Future<void> execute({
    required String description,
    required String userName,
    required String city,
    required String district,
    String? imageUrl,
  }) async {
    final message =
        '''
$userName adlı kullanıcının paylaşımı:

$description

📍 $city / $district
''';

    try {
      SharePlus.instance.share(ShareParams(text: message));
    } catch (e) {
      debugPrint("Share ERROR: $e");
      rethrow;
    }
  }
}
