// ignore_for_file: file_names

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:lostfoundapp/mics/packages.dart';
import 'package:lostfoundapp/model/userdata.dart';

class LoadLoginScreen extends StatefulWidget {
  const LoadLoginScreen({super.key});

  @override
  State<LoadLoginScreen> createState() => _LoadLoginScreenState();
}

class _LoadLoginScreenState extends State<LoadLoginScreen> {
  String? mtoken;

  final userAuth = FirebaseAuth.instance;
  //
  void gettotekon() async {
    final token = await FirebaseMessaging.instance.getToken();
    setState(() {
      mtoken = token;
    });
  }

  void checktoken() async {
    if (userlogin!.divToken != mtoken) {
      await userDataRef.doc(userlogin!.useruid).update({"divToken": mtoken});

      debugPrint("Token Updated");
    } else {
      debugPrint("Token is the same");
      return null;
    }
  }

  @override
  void initState() {
    gettotekon();
    super.initState();
    loadWidget();
  }

  bool loading = false;
  loadWidget() async {
    await Future.delayed(const Duration(seconds: 4));
    setState(() {
      loading = true;
    });
  }

  //handleuserdata
  Future handleuserdate() async {
    setState(() {
      loading = false;
    });
    final navigate = Navigator.of(context);
    User? users = userAuth.currentUser;
    DocumentSnapshot docs = await userDataRef.doc(users!.uid).get();
    if (docs.exists) {
      userlogin = UserDataModel.fromDocuments(docs);
    }
    userlogin = UserDataModel.fromDocuments(docs);

    await Future.delayed(const Duration(seconds: 3));
    navigate.pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const SliverHomePage()),
        (route) => false);
    setState(() {
      loading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final widthsize = MediaQuery.of(context).size.width;
    return Scaffold(
      body: loading == false
          ? const Center(child: CircularProgressIndicator())
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                    child: SizedBox(
                  width: widthsize * 0.80,
                  height: 150,
                  child: CircleAvatar(
                      backgroundImage:
                          NetworkImage("${userlogin!.profileURL}")),
                )),
                const SizedBox(
                  height: 8,
                ),
                Center(
                    child: TextViewPoppins(
                        title: "You login as ${userlogin!.username}",
                        fontsize: 14,
                        fontcolor: colorblack)),
                const SizedBox(
                  height: 15,
                ),
                Center(
                    child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SizedBox(
                      width: widthsize * 0.80,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                        ),
                        onPressed: () {
                          checktoken();
                          handleuserdate();
                        },
                        child: const Text("CONTINUE"),
                      )),
                )),
              ],
            ),
    );
  }
}
