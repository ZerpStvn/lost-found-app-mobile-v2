import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:lostfoundapp/firebase_options.dart';
import 'package:lostfoundapp/mainscreen/onboarding.dart';
import 'package:lostfoundapp/mics/packages.dart';
import 'package:lostfoundapp/model/userdata.dart';
import 'package:shared_preferences/shared_preferences.dart';

CollectionReference userDataRef =
    FirebaseFirestore.instance.collection('users');
final storageRef = FirebaseStorage.instance.ref();
UserDataModel? userlogin;
//==
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.

  await Firebase.initializeApp();
  debugPrint('Handling a background message ${message.messageId}');
}

//==
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final prefs = await SharedPreferences.getInstance();
  final showHome = prefs.getBool('showHome') ?? false;
  //===
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  //===
  runApp(MyApp(showHome: showHome));
}

class MyApp extends StatelessWidget {
  final bool showHome;
  const MyApp({super.key, required this.showHome});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        splashColor: Colors.transparent,
        primarySwatch: Colors.green,
      ),
      home: showHome ? const LoginPage() : const OnBoardingScreen(),
    );
  }
}
