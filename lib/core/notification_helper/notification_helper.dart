// import 'dart:convert';
// import 'dart:developer';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class NotificationHelper {
//   NotificationHelper._();

//   static final NotificationHelper _instance = NotificationHelper._();
//   static NotificationHelper get instance => _instance;

//   final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();
//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

//   Future<void> initialize() async {
//     const InitializationSettings settings = InitializationSettings(
//       android: AndroidInitializationSettings('@mipmap/ic_launcher'),
//       iOS: DarwinInitializationSettings(),
//     );
//     _flutterLocalNotificationsPlugin.initialize(
//       settings,
//       onDidReceiveNotificationResponse: _handleNotificationTap,
//       onDidReceiveBackgroundNotificationResponse: _handleNotificationTap,
//     );
//     await _requestPermission();
//     _initializeFirebaseMessaging();
//   }

//   void _initializeFirebaseMessaging() async {
//     //debugPrint("FCM Token: ${_firebaseMessaging.getToken()}");
//     // log("FCM Token: ${await _firebaseMessaging.getToken()}");
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       log("onMessage: $message");
//       // AppRouters.navigatorKey.currentContext!
//       //     .read<ProfileCubit>()
//       //     .updateUserData(
//       //       AppRouters.navigatorKey.currentContext!
//       //           .read<ProfileCubit>()
//       //           .state
//       //           .userData!
//       //           .copyWith(
//       //             unreadNotificationsCount: (AppRouters
//       //                         .navigatorKey.currentContext!
//       //                         .read<ProfileCubit>()
//       //                         .state
//       //                         .userData!
//       //                         .unreadNotificationsCount ??
//       //                     1) -
//       //                 1,
//       //           ),
//       //     );

//       display(message);
//     });

//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       log("onMessageOpenedApp: $message");

//       onNotificationTaped(message);
//     });

//     FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
//   }

//   void display(RemoteMessage message) async {
//     try {
//       var android = const AndroidNotificationDetails(
//         "dar",
//         "dar channel",
//         importance: Importance.max,
//         priority: Priority.high,
//         channelDescription: "dar description",
//         colorized: true,
//         color: Color(0xff469D8F),
//       );
//       var iOS = const DarwinNotificationDetails();
//       var platform = NotificationDetails(android: android, iOS: iOS);
//       _flutterLocalNotificationsPlugin.show(
//         0,
//         message.notification?.title ?? 'Notification',
//         message.notification?.body ?? 'New Notification',
//         platform,
//         payload: json.encode(message.data),
//       );
//     } catch (e) {
//       log(e.toString());
//     }
//   }

//   static void _handleNotificationTap(NotificationResponse notificationResponse) {
//     final String? payload = notificationResponse.payload;
//     if (payload != null) {
//       log("Notification tapped with payload: $payload");

//       final data = json.decode(payload);

//       onNotificationTaped(RemoteMessage(data: data));
//     }
//   }

//   Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//     log("Handling a background message: $message");
//     display(message);
//   }

//   Future<NotificationSettings> _requestPermission() async {
//     return await _firebaseMessaging.requestPermission(
//       alert: true,
//       announcement: false,
//       badge: true,
//       carPlay: false,
//       criticalAlert: false,
//       provisional: false,
//       sound: true,
//     );
//   }

//   void clearAllNotifications() {
//     _flutterLocalNotificationsPlugin.cancelAll();
//   }

//   void getInitialNotification() {
//     FirebaseMessaging.instance.getInitialMessage().then((message) {
//       if (message != null) {
//         onNotificationTaped(message);
//       }
//     });
//   }
// }

// void onNotificationTaped(RemoteMessage message) {
//   log("kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk");
//   final msg = json.encode(message.data);
//   // var body = json.decode(msg);
//   // log(body['recipient_type'].toString());
//   // final data = NotificationFromFirebaseModel.fromJson(body);
//   // log(data.type.toString());
//   // switch (data.type) {
//   //   case 'general':
//   //     log('general');
//   //     break;
//   //   case 'accepted' || 'paid' || 'onWay' || 'inProgress':
//   //     NavigatorMethods.pushNamed(AppRouters.navigatorKey.currentContext!,
//   //         CustomMyVisitingRequestDetailsScreen.routeName,
//   //         arguments:
//   //             CustomMyVisitingRequestDetailsArgs(int.parse(data.targetId!)));
//   //     break;
//   //   case 'completed':
//   //     NavigatorMethods.pushNamed(AppRouters.navigatorKey.currentContext!,
//   //         MyVisitingDetailsPreviousScreen.routeName,
//   //         arguments: MyVisitingDetailsPreviousArgs(
//   //             orderId: int.parse(data.targetId!)));
//   //     break;
//   //   case 'cancelled':
//   //     NavigatorMethods.pushNamed(AppRouters.navigatorKey.currentContext!,
//   //         MyVisitingDetailsFinishedScreen.routeName,
//   //         arguments: MyVisitingDetailsFinishedArgs(
//   //             orderId: int.parse(data.targetId!)));
//   //     break;
//   //   default:
//   // }
// }
