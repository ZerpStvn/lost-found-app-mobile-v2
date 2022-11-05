// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:lostfoundapp/mics/packages.dart';
// import 'package:http/http.dart' as http;
// import 'dart:io' as io;

// class WidgetView extends StatefulWidget {
//   const WidgetView({super.key});

//   @override
//   State<WidgetView> createState() => _WidgetViewState();
// }

// class _WidgetViewState extends State<WidgetView> {
//   String postID = const Uuid().v4();
//   String str = "hello world";
//   String str1 = "hello";
//   late AndroidNotificationChannel channel;
//   late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

//   @override
//   void initState() {
//     super.initState();
//   }

//   void sendPushMessage(String? token, String body, String title) async {
//     try {
//       await http.post(
//         Uri.parse('https://fcm.googleapis.com/fcm/send'),
//         headers: <String, String>{
//           'Content-Type': 'application/json',
//           'Authorization':
//               'key=AAAAewoqbb8:APA91bF2szMqr73_gPqYlRWGVBJDSGXuZGrdh0zWyO0E3SyaVxlKNbYieZygDtJ9Lj7whiXevnI9QaslYf_oFfTaGJN3tj2UO4F9aE2h-Yt1Sppfs6-Y4zgby0seAlqsa7nrqVJY3Bc4',
//         },
//         body: jsonEncode(
//           <String, dynamic>{
//             'notification': <String, dynamic>{'body': body, 'title': title},
//             'priority': 'high',
//             'data': <String, dynamic>{
//               'click_action': 'FLUTTER_NOTIFICATION_CLICK',
//               'id': '1',
//               'status': 'done'
//             },
//             "to": token,
//           },
//         ),
//       );
//     } catch (e) {
//       debugPrint("error push notification");
//     }
//   }

//   // void requestPermission() async {
//   //   FirebaseMessaging messaging = FirebaseMessaging.instance;

//   //   NotificationSettings settings = await messaging.requestPermission(
//   //     alert: true,
//   //     announcement: false,
//   //     badge: true,
//   //     carPlay: false,
//   //     criticalAlert: false,
//   //     provisional: false,
//   //     sound: true,
//   //   );

//   //   if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//   //     debugPrint('User granted permission');
//   //   } else if (settings.authorizationStatus ==
//   //       AuthorizationStatus.provisional) {
//   //     debugPrint('User granted provisional permission');
//   //   } else {
//   //     debugPrint('User declined or has not accepted permission');
//   //   }
//   // }

//   // void listenFCM() async {
//   //   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//   //     RemoteNotification? notification = message.notification;
//   //     AndroidNotification? android = message.notification?.android;
//   //     if (notification != null && android != null && !kIsWeb) {
//   //       flutterLocalNotificationsPlugin.show(
//   //         notification.hashCode,
//   //         notification.title,
//   //         notification.body,
//   //         NotificationDetails(
//   //           android: AndroidNotificationDetails(
//   //             channel.id,
//   //             channel.name,
//   // ignore: todo
//   //             // TODO add a proper drawable resource to android, for now using
//   //             //      one that already exists in example app.
//   //             icon: 'launch_background',
//   //           ),
//   //         ),
//   //       );
//   //     }
//   //   });
//   // }

//   // void loadFCM() async {
//   //   if (!kIsWeb) {
//   //     channel = const AndroidNotificationChannel(
//   //       'high_importance_channel', // id
//   //       'High Importance Notifications', // title
//   //       importance: Importance.high,
//   //       enableVibration: true,
//   //     );

//   //     flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

//   //     /// Create an Android Notification Channel.
//   //     ///
//   //     /// We use this channel in the `AndroidManifest.xml` file to override the
//   //     /// default FCM channel to enable heads up notifications.
//   //     await flutterLocalNotificationsPlugin
//   //         .resolvePlatformSpecificImplementation<
//   //             AndroidFlutterLocalNotificationsPlugin>()
//   //         ?.createNotificationChannel(channel);

//   //     /// Update the iOS foreground notification presentation options to allow
//   //     /// heads up notifications.
//   //     await FirebaseMessaging.instance
//   //         .setForegroundNotificationPresentationOptions(
//   //       alert: true,
//   //       badge: true,
//   //       sound: true,
//   //     );
//   //   }
//   // }
//   bool isselect = false;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           // Center(
//           //   child: SizedBox(
//           //     width: 120,
//           //     height: 40,
//           //     child: ElevatedButton(
//           //       onPressed: () {
//           //         sendPushMessage(userlogin!.divToken.toString(),
//           //             "sent you a request", userlogin!.username.toString());
//           //         debugPrint('${userlogin!.divToken}');
//           //       },
//           //       child: const Text("Click"),
//           //     ),
//           //   ),
//           // ),
//           // const SizedBox(
//           //   height: 15,
//           // ),
//           // Center(
//           //   child: SizedBox(
//           //     width: 120,
//           //     height: 40,
//           //     child: ElevatedButton(
//           //       onPressed: () {
//           //         sendPushMessage(
//           //             'c4wtk9zUQ867dqm1XfDWGc:APA91bHO5LwMIk_kSFX52DAUTgidYpwsJIjrCBIrjO5gjQfezgpmcKKQ2uvxcPwSrXrivrSOatjWR8HdaaPTmYTY-lBszFqWCOb8AAsH4GLRNjtJMTGb-FGywemSzNmVIabF1addWnQG',
//           //             "sent you a request",
//           //             'Sample');
//           //       },
//           //       child: const Text("Test"),
//           //     ),
//           //   ),
//           // )

//           SizedBox(
//             height: 35,
//             child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
//                 onPressed: () {
//                   setState(() {
//                     isselect = !isselect;
//                   });
//                 },
//                 child: const TextViewPoppins(
//                   title: "Select another imgae",
//                   fontcolor: colorWhite,
//                   fontsize: 14,
//                 )),
//           ),

//           const SizedBox(
//             height: 20,
//           ),
//           isselect == false
//               ? Container()
//               : Flexible(
//                   fit: FlexFit.loose,
//                   child: GridView(
//                     shrinkWrap: true,
//                     gridDelegate:
//                         const SliverGridDelegateWithFixedCrossAxisCount(
//                             mainAxisSpacing: 5,
//                             crossAxisSpacing: 5,
//                             crossAxisCount: 3),
//                     children: [
//                       GestureDetector(
//                         onTap: getMultiImage,
//                         child: Container(
//                           height: 50,
//                           width: 50,
//                           decoration: listImage != null
//                               ? BoxDecoration(
//                                   image: DecorationImage(
//                                       image: FileImage(File(listImage!.path))),
//                                   border: Border.all(color: colorblack))
//                               : BoxDecoration(
//                                   border: Border.all(color: colorblack)),
//                           child: const Center(
//                               child: Icon(
//                             Icons.add,
//                             size: 45,
//                           )),
//                         ),
//                       ),
//                       Container(
//                         height: 50,
//                         width: 50,
//                         decoration: BoxDecoration(
//                             border: Border.all(color: colorblack)),
//                         child: const Center(
//                             child: Icon(
//                           Icons.add,
//                           size: 45,
//                         )),
//                       ),
//                       Container(
//                         height: 50,
//                         width: 50,
//                         decoration: BoxDecoration(
//                             border: Border.all(color: colorblack)),
//                         child: const Center(
//                             child: Icon(
//                           Icons.add,
//                           size: 45,
//                         )),
//                       ),
//                     ],
//                   )),
//           const SizedBox(
//             height: 20,
//           ),
//           SizedBox(
//             height: 35,
//             child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
//                 onPressed: () {},
//                 child: const TextViewPoppins(
//                   title: "upload",
//                   fontcolor: colorWhite,
//                   fontsize: 14,
//                 )),
//           ),
//         ],
//       ),
//     );
//   }

//   XFile? listImage;
//   final ImagePicker imagepicker = ImagePicker();

//   void getMultiImage() async {
//     final XFile? limage =
//         await imagepicker.pickImage(source: ImageSource.gallery);

//     if (limage == null) {
//       setState(() {
//         listImage = limage;
//       });
//     }
//   }
// }
