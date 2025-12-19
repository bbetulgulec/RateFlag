import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rate_flag/features/RateFlag/presentaions/home/cubit/home_cubit.dart';
import 'package:rate_flag/features/RateFlag/presentaions/home/functions/createImageMarker.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Set<Marker> _markers = {};
  Createimagemarker createimagemarker = Createimagemarker();

  @override
  void initState() {
    super.initState();
    _loadMarkers();
  }

  Future<void> _loadMarkers() async {
    final posts = context.read<HomeCubit>().state.posts;

    // marker oluşturma future'larını paralel hazırlıyoruz
    final futures = posts.where((p) => p.imageUrl != null).map((post) async {
      final icon = await getMarkerIcon(post.imageUrl!); // Önbellekli
      return Marker(
        markerId: MarkerId(post.postId),
        position: LatLng(post.latitude, post.longitude),
        icon: icon,
        onTap: () {
          print(post.description);
        },
      );
    }).toList();

    final markersList = await Future.wait(futures);

    setState(() {
      _markers.addAll(markersList);
    });
  }

  // Önbellekli icon fonksiyonu
  final Map<String, BitmapDescriptor> _iconCache = {};

  Future<BitmapDescriptor> getMarkerIcon(String url) async {
    if (_iconCache.containsKey(url)) return _iconCache[url]!;

    final icon = await createimagemarker.createImageMarker(url);
    _iconCache[url] = icon;
    return icon;
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
