import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rate_flag/features/RateFlag/presentaions/home/cubit/home_cubit.dart';
import 'package:rate_flag/features/RateFlag/presentaions/home/widget/marker_icon_helper.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _loadMarkers();
  }

  Future<void> _loadMarkers() async {
    final posts = context.read<HomeCubit>().state.posts;

    for (final post in posts) {
      if (post.imageUrl == null) continue;

      final icon = await createImageMarker(post.imageUrl!);

      final marker = Marker(
        markerId: MarkerId(post.postId),
        position: LatLng(post.latitude, post.longitude),
        icon: icon,
        onTap: () {
          print(post.description);
        },
      );

      _markers.add(marker);
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: LatLng(39.0, 35.0),
          zoom: 5,
        ),
        markers: _markers,
        myLocationEnabled: false,
        myLocationButtonEnabled: false,
        compassEnabled: false,
      ),
    );
  }
}
