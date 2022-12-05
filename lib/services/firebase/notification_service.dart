// import 'dart:convert';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:http/http.dart' as http;


// late AndroidNotificationChannel channel;
// late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;


// void sendPushMessage(String token) async {
//   try {
//     await http.post(
//       Uri.parse('https://fcm.googleapis.com/fcm/send'),
//       headers: <String, String>{
//         'Content-Type': 'application/json',
//         'Authorization': 'key=AAAA4iepPvw:APA91bHN7r9FzygUt5xBvxIBjPunUMt37ZyLJvTu46UGm5regxBJnTKg67KWzu54deMj-g2b5tb3cUAjxiFGOCWgJzJGYxwS4cALg5woKDnV-LhFlRrIpc1F34ejbKVORjkMZgZPfjWR',
//       },
//       body: jsonEncode(
//         <String, dynamic>{
//           'notification': <String, dynamic>{
//             'body': "body",
//             'title': "title"
//           },
//           'priority': 'high',
//           'data': <String, dynamic>{
//             'click_action': 'FLUTTER_NOTIFICATION_CLICK',
//             'id': '1',
//             'status': 'done'
//           },
//           "to": token,
//         },
//       ),
//     );
//   } catch (e) {
//     print("error push notification");
//   }
// }


// void requestPermission() async {
//   FirebaseMessaging messaging = FirebaseMessaging.instance;

//   NotificationSettings settings = await messaging.requestPermission(
//     alert: true,
//     announcement: false,
//     badge: true,
//     carPlay: false,
//     criticalAlert: false,
//     provisional: false,
//     sound: true,
//   );

//   if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//     print('User granted permission');
//   } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
//     print('User granted provisional permission');
//   } else {
//     print('User declined or has not accepted permission');
//   }
// }

// void listenFCM() async {
//   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//     RemoteNotification? notification = message.notification;
//     AndroidNotification? android = message.notification?.android;
//     if (notification != null && android != null && !kIsWeb) {
//       flutterLocalNotificationsPlugin.show(
//         notification.hashCode,
//         notification.title,
//         notification.body,
//         NotificationDetails(
//           android: AndroidNotificationDetails(
//             channel.id,
//             channel.name,
//             //      one that already exists in example app.
//             icon: 'launch_background',
//           ),
//         ),
//       );
//     }
//   });
// }

// void loadFCM() async {
//   if (!kIsWeb) {
//     channel = const AndroidNotificationChannel(
//       'high_importance_channel', // id
//       'High Importance Notifications', // title
//       importance: Importance.high,
//       enableVibration: true,
//     );

//     flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

//     /// Create an Android Notification Channel.
//     ///
//     /// We use this channel in the `AndroidManifest.xml` file to override the
//     /// default FCM channel to enable heads up ui.screens.Tabs.notifications.
//     await flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//         AndroidFlutterLocalNotificationsPlugin>()
//         ?.createNotificationChannel(channel);

//     /// Update the iOS foreground notification presentation options to allow
//     /// heads up ui.screens.Tabs.notifications.
//     await FirebaseMessaging.instance
//         .setForegroundNotificationPresentationOptions(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//   }
// }

