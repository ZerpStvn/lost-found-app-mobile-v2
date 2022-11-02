// ignore_for_file: file_names

import 'package:lostfoundapp/cardpost/fPost.dart';
import 'package:lostfoundapp/cardpost/lPost.dart';
import 'package:lostfoundapp/mics/packages.dart';
import 'package:lostfoundapp/model/userdata.dart';

class GetUserProfile extends StatelessWidget {
  const GetUserProfile(
      {super.key,
      required this.userID,
      required this.postModel,
      required this.tiemformat});
  final String userID;
  final UserPostModel postModel;
  final String tiemformat;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
        future:
            FirebaseFirestore.instance.collection('users').doc(userID).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return loadingScreen();
          } else {
            UserDataModel users =
                UserDataModel.fromDocuments(snapshot.data!.data());
            return PostCardViewScreen(
                postModel: postModel, tiemformat: tiemformat, users: users);
          }
        });
  }
}

Widget loadingScreen() {
  return Card(
    elevation: 10,
    child: Stack(fit: StackFit.expand, children: [
      Image.asset(
        "assets/banner.png",
        fit: BoxFit.cover,
        color: const Color.fromARGB(141, 66, 73, 69),
        colorBlendMode: BlendMode.multiply,
      ),
      Positioned(
          top: 10,
          left: 15,
          child: Container(
            height: 40,
            width: 40,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromARGB(255, 90, 87, 87),
            ),
          )),
      Positioned(
          top: 15,
          left: 65,
          child: Container(
            height: 30,
            width: 130,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: const Color.fromARGB(255, 90, 87, 87),
              borderRadius: BorderRadius.circular(30),
            ),
          )),
    ]),
  );
}

class GetUserProfileLost extends StatelessWidget {
  const GetUserProfileLost(
      {super.key,
      required this.userID,
      required this.postModel,
      required this.tiemformat});
  final String userID;
  final UserPostModel postModel;
  final String tiemformat;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
        future:
            FirebaseFirestore.instance.collection('users').doc(userID).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return loadingScreen();
          } else {
            UserDataModel users =
                UserDataModel.fromDocuments(snapshot.data!.data());
            return LostPostScreenView(
                postModel: postModel, tiemformat: tiemformat, users: users);
          }
        });
  }
}
