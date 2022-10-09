import 'package:flutter/services.dart';
import 'package:lostfoundapp/firebase_options.dart';
import 'package:lostfoundapp/mics/packages.dart';
import 'package:lostfoundapp/model/userdata.dart';

CollectionReference userDataRef =
    FirebaseFirestore.instance.collection('users');
final storageRef = FirebaseStorage.instance.ref();
UserDataModel? userlogin;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
      home: const LoginPage(),
    );
  }
}
