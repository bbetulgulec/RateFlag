import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rate_flag/features/RateFlag/common/get_it/service_locator.dart';
import 'package:rate_flag/features/RateFlag/presentaions/home/cubit/home_cubit.dart';
import 'package:rate_flag/features/RateFlag/presentaions/home/cubit/home_state.dart';
import 'package:rate_flag/features/RateFlag/presentaions/home/widget/post_marker_widget.dart';
import 'package:rate_flag/features/RateFlag/presentaions/post_info/cubit/post_info_cubit.dart';
import 'package:rate_flag/features/RateFlag/presentaions/post_info/view/post_info_screen.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  Future<Set<Marker>> _buildMarkers(BuildContext context, List posts) async {
    final futures = posts.where((p) => p.imageUrl != null).map((post) async {
      final widget = PostMarkerWidget(
        post: post,
        onTap: () {
          context.read<HomeCubit>().openPost(post);
        },
      );
      return widget.buildMarker();
    }).toList();

    final markers = await Future.wait(futures);
    return markers.toSet();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeCubit, HomeState>(
      listenWhen: (p, c) =>
          p.openedPost != c.openedPost && c.openedPost != null,
      listener: (context, state) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (_) =>
                  getIt<PostInfoCubit>()
                    ..loadPostInfo(postId: state.openedPost!.postId),
              child: PostInfoScreen(postId: state.openedPost!.postId),
            ),
          ),
        );

        context.read<HomeCubit>().openPost(null);
      },

      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return FutureBuilder<Set<Marker>>(
            future: _buildMarkers(context, state.posts),
            builder: (context, snapshot) {
              return GoogleMap(
                initialCameraPosition: const CameraPosition(
                  target: LatLng(41.0082, 28.9784),
                  zoom: 7,
                ),
                markers: snapshot.data ?? {},
              );
            },
          );
        },
      ),
    );
  }
}
