// ignore_for_file: file_names

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lostfoundapp/mics/packages.dart';
import 'package:lostfoundapp/searchpage/itemsearch.dart';

class SliverHomePage extends StatefulWidget {
  const SliverHomePage({super.key});

  @override
  State<SliverHomePage> createState() => _SliverHomePageState();
}

class _SliverHomePageState extends State<SliverHomePage>
    with TickerProviderStateMixin {
  late AndroidNotificationChannel channel;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  late TabController tabController;
  List<Widget> list = const [
    Tab(
      child: Text(
        "Found Items",
      ),
    ),
    Tab(
      child: Text(
        "Lost Items",
      ),
    ),
    Tab(
      child: Text(
        "Suggestions",
      ),
    ),
  ];

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
    requestPermission();

    loadFCM();

    listenFCM();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      debugPrint('User granted provisional permission');
    } else {
      debugPrint('User declined or has not accepted permission');
    }
  }

  int onNotifCounter = 0;

  void listenFCM() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      setState(() {
        onNotifCounter++;
      });
      debugPrint("$onNotifCounter");
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              // ignore: todo
              // TODO add a proper drawable resource to android, for now using
              //      one that already exists in example app.
              icon: '@mipmap/ic_launcher',
            ),
          ),
        );
      }
    });
  }

  void loadFCM() async {
    if (!kIsWeb) {
      channel = const AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        importance: Importance.high,
        enableVibration: true,
      );

      flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

      /// Create an Android Notification Channel.
      ///
      /// We use this channel in the `AndroidManifest.xml` file to override the
      /// default FCM channel to enable heads up notifications.
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      /// Update the iOS foreground notification presentation options to allow
      /// heads up notifications.
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        backgroundColor: colorWhite,
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Builder(
              builder: (context) => IconButton(
                  splashRadius: 1,
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  icon: const Icon(
                    Icons.dehaze_rounded,
                    size: 25,
                    color: colorblack45,
                  )),
            ),
          ),
          elevation: 0,
          backgroundColor: colorWhite,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Row(
                children: [
                  IconButton(
                      splashRadius: 1,
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ItemSearchPage())),
                      icon: const Icon(
                        Icons.search_outlined,
                        color: colorblack45,
                        size: 25,
                      )),
                  Stack(
                    children: [
                      IconButton(
                          splashRadius: 1.9,
                          onPressed: () {
                            setState(() {
                              onNotifCounter = 0;
                            });
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const NotificationFeed()));
                          },
                          icon: const Icon(
                            Icons.notifications_outlined,
                            color: colorblack45,
                            size: 25,
                          )),
                      Positioned(
                          top: 10,
                          right: 10,
                          child: Icon(
                            Icons.circle,
                            color: onNotifCounter >= 1
                                ? Colors.red
                                : Colors.transparent,
                            size: 10,
                          ))
                    ],
                  ),
                  IconButton(
                      splashRadius: 1.9,
                      onPressed: () {
                        handleButtonModalOption(context);
                      },
                      icon: const Icon(
                        Icons.more_vert,
                        color: colorblack45,
                        size: 25,
                      )),
                ],
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10),
          child: NestedScrollView(
            headerSliverBuilder: ((context, innerBoxIsScrolled) {
              return [
                SliverToBoxAdapter(
                  child: ListTile(
                    title: const TextViewInter(
                        title: 'Hello,',
                        fontsize: 19,
                        fontweight: FontWeight.bold,
                        fontcolor: colorblack),
                    subtitle: TextViewInter(
                        title: '${userlogin!.username}',
                        fontsize: 23,
                        fontweight: FontWeight.bold,
                        fontcolor: colorblack),
                    trailing: GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ProfilePage())),
                      child: Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          color: colorgrey,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage('${userlogin!.profileURL}'),
                              fit: BoxFit.cover),
                        ),
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Cardpost(widthsize: size),
                ),
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: colorWhite,
                  elevation: 0,
                  toolbarHeight: 45.0,
                  pinned: true,
                  floating: false,
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(20.0),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: SizedBox(
                        width: size * 0.89,
                        child: TabBar(
                          controller: tabController,
                          unselectedLabelColor: colorblack,
                          tabs: list,
                          labelStyle: GoogleFonts.inter(
                              fontSize: size < 360.0 ? 10 : 12,
                              fontWeight: FontWeight.w600),
                          labelColor: colorWhite,
                          indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: colorgreenHue),
                        ),
                      ),
                    ),
                  ),
                ),
              ];
            }),
            body: TabBarView(controller: tabController, children: const [
              FoundItems(),
              LostItemTabs(),
              SuggestionItems(),
            ]),
          ),
        ),
        drawer: DrawerPropety(widthsize: size),
      ),
    );
  }

  snacbarmessage(BuildContext context, String title) {
    final snack = SnackBar(
      content: TextView(
        title: title,
        fontcolor: colorWhite,
        fontsize: 12,
        fontweight: FontWeight.normal,
      ),
      backgroundColor: colorblack,
    );
    ScaffoldMessenger.of(context).showSnackBar(snack);
  }

  DateTime currentBackPressTime = DateTime.now();

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (now.difference(currentBackPressTime) > const Duration(seconds: 1)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: "Press 1 more time to exit");
      return Future.value(false);
    }
    return Future.value(true);
  }
}
