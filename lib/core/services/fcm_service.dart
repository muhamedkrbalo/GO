import 'package:firebase_messaging/firebase_messaging.dart';

/// Service to handle FCM token operations
class FcmService {
  /// Gets FCM token for push notifications
  static Future<String> getToken() async {
    try {
      final fcmToken = await FirebaseMessaging.instance.getToken();
      return fcmToken ?? '';
    } catch (e) {
      // Return empty string if FCM token retrieval fails
      return '';
    }
  }
}