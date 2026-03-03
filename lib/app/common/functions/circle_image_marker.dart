import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class CircleImageMarker {
  static final Map<String, BitmapDescriptor> _cache = {};

  static Future<BitmapDescriptor> fromUrl(
    String imageUrl, {
    double size = 60,
    double borderWidth = 3,
    Color borderColor = Colors.white,
  }) async {
    if (_cache.containsKey(imageUrl)) {
      return _cache[imageUrl]!;
    }

    final response = await http.get(Uri.parse(imageUrl));
    final bytes = response.bodyBytes;

    final codec = await ui.instantiateImageCodec(
      bytes,
      targetWidth: size.toInt(),
      targetHeight: size.toInt(),
    );
    final frame = await codec.getNextFrame();
    final image = frame.image;

    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);

    final paint = Paint()..isAntiAlias = true;

    final radius = size / 2;

    canvas.save();
    canvas.translate(radius, radius);
    canvas.clipPath(
      Path()..addOval(Rect.fromCircle(center: Offset.zero, radius: radius)),
    );
    canvas.translate(-radius, -radius);

    canvas.drawImage(image, Offset.zero, paint);
    canvas.restore();

    paint
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth
      ..color = borderColor;

    canvas.drawCircle(Offset(radius, radius), radius - borderWidth / 2, paint);

    final picture = recorder.endRecording();
    final img = await picture.toImage(size.toInt(), size.toInt());
    final byteData = await img.toByteData(format: ui.ImageByteFormat.png);

    final descriptor = BitmapDescriptor.bytes(byteData!.buffer.asUint8List());

    _cache[imageUrl] = descriptor;
    return descriptor;
  }
}
