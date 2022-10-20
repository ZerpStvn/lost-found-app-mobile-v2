import 'dart:io' as io;

import 'package:flutter/scheduler.dart';
import 'package:lostfoundapp/mics/packages.dart';

class FoundReportPage extends StatefulWidget {
  const FoundReportPage({super.key});

  @override
  State<FoundReportPage> createState() => _FoundReportPageState();
}

class _FoundReportPageState extends State<FoundReportPage> {
  bool isloading = false;
  String postID = const Uuid().v4();
  UserPostModel userPostModel = UserPostModel();
  final user = FirebaseAuth.instance.currentUser;
  final TextEditingController founditemtitlecon = TextEditingController();
  final TextEditingController foundfounddescriptionrcon =
      TextEditingController();
  final TextEditingController founditemcolorcon = TextEditingController();
  final TextEditingController foundlocationcon = TextEditingController();
  final TextEditingController foundlocationDescriptioncon =
      TextEditingController();
  final TextEditingController founditemdescriptioncon = TextEditingController();
  final TextEditingController foundmobilenumbercon = TextEditingController();
  final TextEditingController foundsocialmediacon = TextEditingController();
  final TextEditingController foundmodelcon = TextEditingController();
  final TextEditingController foundbrandcon = TextEditingController();
  final TextEditingController foundmarkingscon = TextEditingController();
  final TextEditingController foundseiralnumcon = TextEditingController();
  final TextEditingController founddatetimeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final widthsize = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: onwillPop,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ImageClassification(
                    itemcolorcon: founditemcolorcon,
                    itemtitlecon: founditemtitlecon),
                const SizedBox(
                  height: 20,
                ),
                // IconButton(
                //     onPressed: () {
                //       debugPrint(itemcolorValue);
                //     },
                //     icon: const Icon(Icons.camera)),
                EditTextFormField(
                    cont2: foundfounddescriptionrcon,
                    cont3: foundlocationcon,
                    cont4: foundlocationDescriptioncon,
                    cont5: founditemdescriptioncon,
                    cont6: foundmobilenumbercon,
                    cont7: foundsocialmediacon,
                    cont8: foundmodelcon,
                    cont9: foundbrandcon,
                    cont10: foundmarkingscon,
                    cont11: foundseiralnumcon,
                    cont12: founddatetimeController,
                    date: "Date of the Item found"),
                const SizedBox(
                  height: 18,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 18.0),
                  child: Center(
                    child: SizedBox(
                      width: widthsize * 0.89,
                      height: 50,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                            ),
                            onPressed: () {
                              handlesubmit(context);
                            },
                            child: const Center(
                              child: TextViewInter(
                                title: "SUBMIT",
                                fontsize: 14,
                                fontcolor: colorWhite,
                                fontweight: FontWeight.bold,
                              ),
                            )),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  //chekc if the formpage is still building in other wigets//

  snackBarScreen(BuildContext context, String title) {
    final snack = SnackBar(
      content: Text(
        title,
        style: GoogleFonts.inter(fontSize: 14, color: colorWhite),
      ),
      backgroundColor: colorblack,
    );
    ScaffoldMessenger.of(context).showSnackBar(snack);
  }

  Future<String> uploadImage() async {
    final metadata = SettableMetadata(
      contentType: 'image/jpeg',
      customMetadata: {'picked-file-path': imagepathfile!.path},
    );
    UploadTask uploadTask = storageRef
        .child("Foundpost_$postID.jpg")
        .putFile(io.File(imagepathfile!.path), metadata);
    TaskSnapshot taskSnapshot = await uploadTask;
    String mediaURL = await taskSnapshot.ref.getDownloadURL();
    return mediaURL;
  }

  createposttoFirebase() async {
    final navigator = Navigator.of(context);
    final snack = snackBarScreen(context, "Done");
    String photoURL = await uploadImage();
    userPostModel.postID = postID.toString();
    userPostModel.userID = user!.uid;
    userPostModel.itemname = founditemtitlecon.text;
    userPostModel.itemcolor = itemcolorValue.toString();
    userPostModel.usermobileNum = foundmobilenumbercon.text;
    userPostModel.userSocialMedia = foundsocialmediacon.text;
    userPostModel.location = foundlocationcon.text;
    userPostModel.locationDes = foundlocationDescriptioncon.text;
    userPostModel.itemDes = founditemdescriptioncon.text;
    userPostModel.foundlossDes = foundfounddescriptionrcon.text;
    userPostModel.itemmodel = foundmodelcon.text;
    userPostModel.datelossfound = founddatetimeController.text;
    userPostModel.itembrand = foundbrandcon.text;
    userPostModel.itemMarks = foundmarkingscon.text;
    userPostModel.itemserailNum = foundseiralnumcon.text;
    userPostModel.phtoURL = photoURL;
    userPostModel.itemstatus = "Unclaimed";
    userPostModel.itemtype = itemvalue;
    userPostModel.userposterPhourl = userlogin!.profileURL;
    userPostModel.userpostername = userlogin!.username;

    await FirebaseFirestore.instance
        .collection("found_items")
        .doc(user!.uid)
        .collection('fitems')
        .doc(postID)
        .set(userPostModel.tomap());

    navigator.pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const SliverHomePage()),
        (route) => false);
    snack;
    handleformclear();
    setState(() {
      postID;
    });
  }

  handlesubmit(BuildContext context) {
    if (founditemtitlecon.text.isEmpty ||
        founddatetimeController.text.isEmpty ||
        foundfounddescriptionrcon.text.isEmpty ||
        foundlocationcon.text.isEmpty ||
        foundlocationDescriptioncon.text.isEmpty ||
        founditemdescriptioncon.text.isEmpty ||
        foundmarkingscon.text.isEmpty) {
      snackBarScreen(context, "Please fill out all the important form");
    } else if (imagepathfile == null) {
      snackBarScreen(context, "Please select an image");
    } else {
      snackBarScreen(context, "Submitting please wait");
      createposttoFirebase();
    }
  }

  handleformclear() {
    founditemtitlecon.clear();
    foundmobilenumbercon.clear();
    foundsocialmediacon.clear();
    foundlocationcon.clear();
    foundlocationDescriptioncon.clear();
    founditemdescriptioncon.clear();
    foundfounddescriptionrcon.clear();
    foundmodelcon.clear();
    foundbrandcon.clear();
    foundmarkingscon.clear();
    foundseiralnumcon.clear();
    imagepathfile = null;
    founditemcolorcon.clear();
  }

  Future<bool> onwillPop() async {
    return (await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const TextView(
              title: "Exit",
              fontsize: 18,
              fontcolor: primaryColor,
              fontweight: FontWeight.bold,
            ),
            content: const TextView(
              title: "Are you sure you want to exit this page? ",
              fontsize: 15,
              fontcolor: primaryColor,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
                child: const TextView(
                  title: "No",
                  fontsize: 18,
                  fontcolor: primaryColor,
                  fontweight: FontWeight.w500,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                  handleformclear();
                  SchedulerBinding.instance.scheduleFrameCallback((timeStamp) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SliverHomePage()));
                  });
                },
                child: const TextView(
                  title: "Yes",
                  fontsize: 18,
                  fontcolor: primaryColor,
                  fontweight: FontWeight.w500,
                ),
              ),
            ],
          );
        }));
  }

  @override
  void dispose() {
    founditemtitlecon.dispose();
    foundfounddescriptionrcon.dispose();
    founditemcolorcon.dispose();
    foundlocationcon.dispose();
    foundlocationDescriptioncon.dispose();
    founditemdescriptioncon.dispose();
    foundmobilenumbercon.dispose();
    foundsocialmediacon.dispose();
    foundmodelcon.dispose();
    foundbrandcon.dispose();
    foundmarkingscon.dispose();
    foundseiralnumcon.dispose();
    founddatetimeController.dispose();
    super.dispose();
  }
}
