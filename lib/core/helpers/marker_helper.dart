import 'dart:ui' as ui;
import 'package:flutter_hr_erb/core/images/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MarkerHelper {
  // Cache for better performance
  static final Map<String, BitmapDescriptor> _markerCache = {};

  /// Create custom asset location marker with blue circle background
  static Future<BitmapDescriptor> createAssetLocationMarker({
    double size = 60,
    Color backgroundColor = const Color(0xFF1976D2), // Blue color
    String? cacheKey,
  }) async {
    final String key = cacheKey ?? 'asset_marker_$size';

    // Return cached marker if available
    if (_markerCache.containsKey(key)) {
      return _markerCache[key]!;
    }

    try {
      final ui.PictureRecorder recorder = ui.PictureRecorder();
      final Canvas canvas = Canvas(recorder);
      final double radius = size / 2;

      // Draw outer shadow
      final Paint shadowPaint = Paint()
        ..color = Colors.black.withOpacity(0.3)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);
      canvas.drawCircle(Offset(radius + 2, radius + 4), radius, shadowPaint);

      // Draw background circle (blue)
      final Paint backgroundPaint = Paint()
        ..color = backgroundColor
        ..style = PaintingStyle.fill;
      canvas.drawCircle(Offset(radius, radius), radius, backgroundPaint);

      // Draw white inner circle for better contrast
      final Paint innerPaint = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.fill;
      canvas.drawCircle(Offset(radius, radius), radius - 4, innerPaint);

      // Use a simple PNG icon instead of SVG for better compatibility
      try {
        // Use the existing logo PNG
        final ByteData iconData = await rootBundle.load(AppImages.assetsImagesLogoPng);
        final ui.Codec iconCodec = await ui.instantiateImageCodec(
          iconData.buffer.asUint8List(),
          targetWidth: (size * 0.4).round(),
          targetHeight: (size * 0.4).round(),
        );
        final ui.FrameInfo iconFrame = await iconCodec.getNextFrame();
        final ui.Image iconImage = iconFrame.image;

        // Calculate icon position (centered)
        final double iconSize = size * 0.4;
        final double iconOffset = (size - iconSize) / 2;

        // Draw icon in center
        canvas.drawImageRect(
          iconImage,
          Rect.fromLTWH(0, 0, iconImage.width.toDouble(), iconImage.height.toDouble()),
          Rect.fromLTWH(iconOffset, iconOffset, iconSize, iconSize),
          Paint()..filterQuality = FilterQuality.high,
        );
      } catch (e) {
        // Fallback: draw a simple location pin shape
        final Paint pinPaint = Paint()
          ..color = Colors.white
          ..style = PaintingStyle.fill;

        final double pinSize = size * 0.3;
        final double pinOffset = (size - pinSize) / 2;

        // Draw simple pin shape
        canvas.drawOval(
          Rect.fromLTWH(pinOffset + pinSize * 0.25, pinOffset, pinSize * 0.5, pinSize * 0.7),
          pinPaint,
        );
        // Draw inner dot
        canvas.drawOval(
          Rect.fromLTWH(
            pinOffset + pinSize * 0.35,
            pinOffset + pinSize * 0.1,
            pinSize * 0.3,
            pinSize * 0.3,
          ),
          Paint()..color = backgroundColor,
        );
      }

      // Convert to bitmap
      final ui.Picture picture = recorder.endRecording();
      final ui.Image image = await picture.toImage((size + 4).round(), (size + 6).round());
      final ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      final Uint8List bytes = byteData!.buffer.asUint8List();

      final BitmapDescriptor marker = BitmapDescriptor.fromBytes(bytes);

      // Cache the marker for better performance
      _markerCache[key] = marker;

      return marker;
    } catch (e) {
      // Fallback to default marker if anything goes wrong
      return BitmapDescriptor.defaultMarker;
    }
  }

  /// Create marker for user location
  static Future<BitmapDescriptor> createUserLocationMarker({
    double size = 50,
    Color backgroundColor = const Color(0xFF4CAF50), // Green color for user
  }) async {
    final String key = 'user_marker_$size';

    if (_markerCache.containsKey(key)) {
      return _markerCache[key]!;
    }

    try {
      final ui.PictureRecorder recorder = ui.PictureRecorder();
      final Canvas canvas = Canvas(recorder);
      final double radius = size / 2;

      // Draw outer glow
      final Paint glowPaint = Paint()
        ..color = backgroundColor.withOpacity(0.3)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);
      canvas.drawCircle(Offset(radius, radius), radius + 3, glowPaint);

      // Draw main circle
      final Paint mainPaint = Paint()
        ..color = backgroundColor
        ..style = PaintingStyle.fill;
      canvas.drawCircle(Offset(radius, radius), radius, mainPaint);

      // Draw white border
      final Paint borderPaint = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3;
      canvas.drawCircle(Offset(radius, radius), radius - 1.5, borderPaint);

      // Draw inner dot
      final Paint dotPaint = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.fill;
      canvas.drawCircle(Offset(radius, radius), radius * 0.3, dotPaint);

      final ui.Picture picture = recorder.endRecording();
      final ui.Image image = await picture.toImage(size.round(), size.round());
      final ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      final Uint8List bytes = byteData!.buffer.asUint8List();

      final BitmapDescriptor marker = BitmapDescriptor.fromBytes(bytes);
      _markerCache[key] = marker;

      return marker;
    } catch (e) {
      return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen);
    }
  }

  /// Clear marker cache (call when memory is low)
  static void clearCache() {
    _markerCache.clear();
  }

  /// Preload markers for better performance
  static Future<void> preloadMarkers() async {
    await Future.wait([createAssetLocationMarker(), createUserLocationMarker()]);
  }

  /// Convert asset image to BitmapDescriptor for map marker
  static Future<BitmapDescriptor> getBitmapDescriptorFromAsset({
    required String assetPath,
    double width = 60,
    double height = 60,
  }) async {
    try {
      final ByteData data = await rootBundle.load(assetPath);
      final ui.Codec codec = await ui.instantiateImageCodec(
        data.buffer.asUint8List(),
        targetWidth: width.round(),
        targetHeight: height.round(),
      );
      final ui.FrameInfo frameInfo = await codec.getNextFrame();
      final ByteData? byteData = await frameInfo.image.toByteData(format: ui.ImageByteFormat.png);
      final Uint8List bytes = byteData!.buffer.asUint8List();

      return BitmapDescriptor.fromBytes(bytes);
    } catch (e) {
      // Fallback to default marker
      return BitmapDescriptor.defaultMarker;
    }
  }

  /// Create custom marker with logo and background
  static Future<BitmapDescriptor> createCustomLogoMarker({
    required String logoAssetPath,
    double size = 80,
    Color backgroundColor = Colors.white,
    Color borderColor = Colors.blue,
    double borderWidth = 3,
  }) async {
    try {
      final ui.PictureRecorder recorder = ui.PictureRecorder();
      final Canvas canvas = Canvas(recorder);
      final double radius = size / 2;

      // Draw background circle
      final Paint backgroundPaint = Paint()
        ..color = backgroundColor
        ..style = PaintingStyle.fill;
      canvas.drawCircle(Offset(radius, radius), radius - borderWidth, backgroundPaint);

      // Draw border
      final Paint borderPaint = Paint()
        ..color = borderColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = borderWidth;
      canvas.drawCircle(Offset(radius, radius), radius - borderWidth / 2, borderPaint);

      // Load and draw logo
      final ByteData logoData = await rootBundle.load(logoAssetPath);
      final ui.Codec logoCodec = await ui.instantiateImageCodec(
        logoData.buffer.asUint8List(),
        targetWidth: (size * 0.6).round(),
        targetHeight: (size * 0.6).round(),
      );
      final ui.FrameInfo logoFrame = await logoCodec.getNextFrame();
      final ui.Image logoImage = logoFrame.image;

      // Calculate logo position (centered)
      final double logoSize = size * 0.6;
      final double logoOffset = (size - logoSize) / 2;

      canvas.drawImageRect(
        logoImage,
        Rect.fromLTWH(0, 0, logoImage.width.toDouble(), logoImage.height.toDouble()),
        Rect.fromLTWH(logoOffset, logoOffset, logoSize, logoSize),
        Paint(),
      );

      // Convert to image
      final ui.Picture picture = recorder.endRecording();
      final ui.Image image = await picture.toImage(size.round(), size.round());
      final ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      final Uint8List bytes = byteData!.buffer.asUint8List();

      return BitmapDescriptor.fromBytes(bytes);
    } catch (e) {
      // Fallback to default marker
      return BitmapDescriptor.defaultMarker;
    }
  }
}
