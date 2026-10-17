import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hr_erb/core/locale/app_locale_key.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:easy_localization/easy_localization.dart';

class DownloadService {
  static final Dio _dio = Dio();

  /// Download file with permission check to public Downloads folder
  static Future<bool> downloadFile({
    required String url,
    required BuildContext context,
    String? customFileName,
    Function(int received, int total)? onProgress,
  }) async {
    try {
      // Check and request storage permission based on Android version
      if (Platform.isAndroid) {
        bool hasPermission = await _checkAndRequestStoragePermission();
        if (!hasPermission) {
          _showMessage(context, 'مطلوب إذن التخزين لتحميل الملفات', isError: true);
          return false;
        }
      }

      // Get the external storage directory (Downloads folder)
      final directory = Directory('/storage/emulated/0/Download');
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }

      final fileName = customFileName ?? url.split('/').last;
      final filePath = '${directory.path}/$fileName';

      log('Downloading to: $filePath');

      // Notify user about download start
      _showMessage(context, AppLocaleKey.download.tr(), isError: false);

      // Start file download
      await _dio.download(
        url,
        filePath,
        onReceiveProgress:
            onProgress ??
            (received, total) {
              if (total != -1) {
                log('Download progress: ${(received / total * 100).toStringAsFixed(0)}%');
              }
            },
        // options: Options(headers: {'User-Agent': 'Mozilla/5.0 (compatible; FlutterApp)'}),
      );

      log('Download completed successfully at: $filePath');

      // Notify user about success
      //  _showMessage(context, 'تم تحميل الملف بنجاح', isError: false);

      return true;
    } catch (e) {
      log('Download error: $e');
      // Handle errors
      _showMessage(context, 'Error downloading file: $e', isError: true);
      return false;
    }
  }

  /// Download PDF specifically
  static Future<bool> downloadPDF({
    required String url,
    required String fileName,
    required BuildContext context,
    Function(int received, int total)? onProgress,
  }) async {
    final String pdfFileName = fileName.endsWith('.pdf') ? fileName : '$fileName.pdf';
    return await downloadFile(
      url: url,
      context: context,
      customFileName: pdfFileName,
      onProgress: onProgress,
    );
  }

  /// Download Excel specifically
  static Future<bool> downloadExcel({
    required String url,
    required String fileName,
    required BuildContext context,
    Function(int received, int total)? onProgress,
  }) async {
    final String excelFileName = fileName.endsWith('.xlsx') || fileName.endsWith('.xls')
        ? fileName
        : '$fileName.xlsx';
    return await downloadFile(
      url: url,
      context: context,
      customFileName: excelFileName,
      onProgress: onProgress,
    );
  }

  /// Check and request storage permission based on Android version
  static Future<bool> _checkAndRequestStoragePermission() async {
    try {
      // For Android 11+ (API 30+), we use manageExternalStorage
      // For Android 10 and below, we use storage permission
      if (Platform.isAndroid) {
        // Check Android version
        bool isAndroid11Plus = await _isAndroid11OrHigher();

        if (isAndroid11Plus) {
          // Android 11+: Check if we can write to external storage
          PermissionStatus status = await Permission.manageExternalStorage.request();
          if (status.isGranted) {
            return true;
          }
          // If manage external storage is denied, try regular storage
          status = await Permission.storage.request();
          return status.isGranted;
        } else {
          // Android 10 and below
          PermissionStatus status = await Permission.storage.request();
          return status.isGranted;
        }
      }
      return true; // Non-Android platforms
    } catch (e) {
      log('Permission check error: $e');
      return false;
    }
  }

  /// Check if device is running Android 11 or higher
  static Future<bool> _isAndroid11OrHigher() async {
    if (!Platform.isAndroid) return false;

    try {
      // This is a simple check - in production you might want to use
      // device_info_plus package for more accurate version detection
      return true; // Assume newer Android for now
    } catch (e) {
      log('Android version check error: $e');
      return false;
    }
  }

  /// Show message to user
  static void _showMessage(BuildContext context, String message, {required bool isError}) {
    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: isError ? 4 : 2),
      ),
    );
  }
}
