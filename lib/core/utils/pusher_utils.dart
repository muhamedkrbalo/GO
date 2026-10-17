// import 'dart:convert';

// import 'package:crypto/crypto.dart';

// class PusherConstants {
//   static const String apiKey = '';
//   static const String appId = '';
//   static const String secret = '';
//   static const String cluster = '';
// }

// class PusherEvents {
//   static const String orderStatus = '';
// }

// class PusherChannels {
//   static String status(String userId) => 'private-user-channel.$userId';
// }

// String generateUserAuthSignature(String socketId, String userId, String secret) {
//   final userData = jsonEncode({'id': userId});
//   final authString = '$socketId::user::$userData';
//   final hmacSha256 = Hmac(sha256, utf8.encode(secret));
//   final digest = hmacSha256.convert(utf8.encode(authString));
//   return digest.toString();
// }

// String generatePrivateChannelSignature(String socketId, String channelName, String secret) {
//   final authString = '$socketId:$channelName';
//   final hmacSha256 = Hmac(sha256, utf8.encode(secret));
//   final digest = hmacSha256.convert(utf8.encode(authString));
//   return digest.toString();
// }
