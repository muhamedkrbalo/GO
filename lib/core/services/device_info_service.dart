import 'dart:io';

/// Service to get device and platform information
class DeviceInfoService {
  /// Gets current platform (android/ios/mobile)
  static String getPlatform() {
    if (Platform.isAndroid) {
      return 'android';
    } else if (Platform.isIOS) {
      return 'ios';
    } else {
      return 'mobile';
    }
  }
}