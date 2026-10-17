import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MarkerHelper {
  /// Cache for the custom marker to avoid regenerating
  static BitmapDescriptor? _cachedMarker;

  /// Creates a custom marker with SVG icon inside a CircleAvatar
  /// Uses caching for better performance
  static Future<BitmapDescriptor> getCustomMarker({
    required String svgAsset,
    double size = 35,
    Color backgroundColor = const Color(0xff2F54EB),
    Color? iconColor,
  }) async {
    // Return cached marker if available
    if (_cachedMarker != null) return _cachedMarker!;

    // Create the custom marker
    _cachedMarker = await _createMarkerFromSvg(
      svgAsset: svgAsset,
      size: size,
      backgroundColor: backgroundColor,
      iconColor: iconColor,
    );

    return _cachedMarker!;
  }

  /// Creates a BitmapDescriptor from an SVG asset with CircleAvatar background
  static Future<BitmapDescriptor> _createMarkerFromSvg({
    required String svgAsset,
    required double size,
    required Color backgroundColor,
    Color? iconColor,
  }) async {
    final pictureRecorder = ui.PictureRecorder();
    final canvas = Canvas(pictureRecorder);
    final paint = Paint();

    // Draw shadow
    final shadowPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.3)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);
    canvas.drawCircle(Offset(size / 2, size / 2 + 2), size / 2 - 4, shadowPaint);

    // Draw white circle background
    paint.color = backgroundColor;
    canvas.drawCircle(Offset(size / 2, size / 2), size / 2 - 4, paint);

    // // Draw border
    final borderPaint = Paint()
      ..color = Colors.transparent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0;
    canvas.drawCircle(Offset(size / 2, size / 2), size / 2 - 4, borderPaint);

    // Load and draw SVG
    try {
      final svgString = await rootBundle.loadString(svgAsset);
      final pictureInfo = await vg.loadPicture(SvgStringLoader(svgString), null);

      final svgSize = size * 0.35; // Reduced from 0.5 to 0.35 for smaller icon
      final offset = (size - svgSize) / 2;

      canvas.save();
      canvas.translate(offset, offset);
      canvas.scale(svgSize / pictureInfo.size.width);
      canvas.drawPicture(pictureInfo.picture);
      canvas.restore();

      pictureInfo.picture.dispose();
    } catch (e) {
      // If SVG loading fails, draw a simple icon
      final iconPaint = Paint()..color = iconColor ?? const Color(0xFF4CAF50);
      canvas.drawCircle(
        Offset(size / 2, size / 2),
        size * 0.1,
        iconPaint,
      ); // Also reduced fallback icon size
    }

    final picture = pictureRecorder.endRecording();
    final image = await picture.toImage(size.toInt(), size.toInt());
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);

    if (byteData == null) {
      return BitmapDescriptor.defaultMarker;
    }

    return BitmapDescriptor.bytes(byteData.buffer.asUint8List());
  }

  /// Clear the cached marker (useful when changing theme/colors)
  static void clearCache() {
    _cachedMarker = null;
  }
}
