import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rate_flag/features/rate_flag/domain/model/post.dart';
import '../../../common/utils/functions/circle_image_marker.dart';

class PostMarkerWidget extends StatelessWidget {
  final Post post;
  final VoidCallback onTap;

  const PostMarkerWidget({super.key, required this.post, required this.onTap});

  Future<Marker> buildMarker() async {
    final icon = await CircleImageMarker.fromUrl(post.imageUrl!);

    return Marker(
      markerId: MarkerId(post.postId),
      position: LatLng(post.latitude, post.longitude),
      icon: icon,
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) => const SizedBox.shrink();
}
