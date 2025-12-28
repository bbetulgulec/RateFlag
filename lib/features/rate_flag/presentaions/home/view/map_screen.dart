import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rate_flag/features/rate_flag/common/routes/routes.dart';
import 'package:rate_flag/features/rate_flag/presentaions/home/cubit/home_cubit.dart';
import 'package:rate_flag/features/rate_flag/presentaions/home/cubit/home_state.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeCubit, HomeState>(
      listenWhen: (p, c) =>
          p.openedPost != c.openedPost && c.openedPost != null,
      listener: (context, state) {
        Routes.push(context, Routes.postInfo, arguments: state.openedPost!);

        context.read<HomeCubit>().openPost(null);
      },
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state.markers.isEmpty && state.posts.isNotEmpty) {
            context.read<HomeCubit>().buildMarkers(context, state.posts);
          }

          return GoogleMap(
            initialCameraPosition: const CameraPosition(
              target: LatLng(41.0082, 28.9784),
              zoom: 7,
            ),
            markers: state.markers,
          );
        },
      ),
    );
  }
}
