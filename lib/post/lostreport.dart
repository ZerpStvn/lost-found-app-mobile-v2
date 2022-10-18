import 'dart:io' as io;
import 'package:lostfoundapp/mics/packages.dart';
import 'package:flutter/scheduler.dart';

class LostReportPage extends StatefulWidget {
  const LostReportPage({super.key});

  @override
  State<LostReportPage> createState() => _LostReportPageState();
}

class _LostReportPageState extends State<LostReportPage> {
  bool isloading = false;
  final user = FirebaseAuth.instance.currentUser;
  String postID = const Uuid().v4();
  UserPostModel userPostModel = UserPostModel();

  final TextEditingController lostitemtitlecon = TextEditingController();
  final TextEditingController lostfounddescriptionrcon =
      TextEditingController();
  final TextEditingController lostitemcolorcon = TextEditingController();
  final TextEditingController lostlocationcon = TextEditingController();
  final TextEditingController lostlocationDescriptioncon =
      TextEditingController();
  final TextEditingController lostitemdescriptioncon = TextEditingController();
  final TextEditingController lostmobilenumbercon = TextEditingController();
  final TextEditingController lostsocialmediacon = TextEditingController();
  final TextEditingController lostmodelcon = TextEditingController();
  final TextEditingController lostbrandcon = TextEditingController();
  final TextEditingController lostmarkingscon = TextEditingController();
  final TextEditingController lostseirlostalnumcon = TextEditingController();
  final TextEditingController lostdatetimeController = TextEditingController();

  //===========================================

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
                    itemcolorcon: lostitemcolorcon,
                    itemtitlecon: lostitemtitlecon),
                // IconButton(
                //   onPressed: () {
                //     debugPrint(squarecolor.toString());
                //     debugPrint(lostitemtitlecon.text);
                //     debugPrint(lostitemcolorcon.text);
                //   },
                //   icon: const Icon(Icons.camera),
                //),
                const SizedBox(
                  height: 30,
                ),
                const SizedBox(
                  height: 20,
                ),
                EditTextFormField(
                    cont2: lostfounddescriptionrcon,
                    cont3: lostlocationcon,
                    cont4: lostlocationDescriptioncon,
                    cont5: lostitemdescriptioncon,
                    cont6: lostmobilenumbercon,
                    cont7: lostsocialmediacon,
                    cont8: lostmodelcon,
                    cont9: lostbrandcon,
                    cont10: lostmarkingscon,
                    cont11: lostseirlostalnumcon,
                    cont12: lostdatetimeController,
                    date: "Date of loss"),
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

  //handle the message useing snackbar
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
  //===========================================
  //===========================================

  //get the PhotoUrl from uploaded phto
  Future<String> uploadImage() async {
    final metadata = SettableMetadata(
      contentType: 'image/jpeg',
      customMetadata: {'picked-file-path': imagepathfile!.path},
    );
    UploadTask uploadTask = storageRef
        .child("Lostpost_$postID.jpg")
        .putFile(io.File(imagepathfile!.path), metadata);
    TaskSnapshot taskSnapshot = await uploadTask;
    String mediaURL = await taskSnapshot.ref.getDownloadURL();
    return mediaURL;
  }
  //===========================================
  //===========================================

  //after getting the photo url
  //create a post the will upload the user data to
  //firebase
  createposttoFirebase() async {
    final navigator = Navigator.of(context);
    final snack = snackBarScreen(context, "Done");
    String photoURL = await uploadImage();
    userPostModel.postID = postID.toString();
    userPostModel.userID = user!.uid;
    userPostModel.itemname = lostitemtitlecon.text;
    userPostModel.itemcolor = squarecolor.toString();
    userPostModel.usermobileNum = lostmobilenumbercon.text;
    userPostModel.userSocialMedia = lostsocialmediacon.text;
    userPostModel.location = lostlocationcon.text;
    userPostModel.locationDes = lostlocationDescriptioncon.text;
    userPostModel.itemDes = lostitemdescriptioncon.text;
    userPostModel.foundlossDes = lostfounddescriptionrcon.text;
    userPostModel.itemmodel = lostmodelcon.text;
    userPostModel.itembrand = lostbrandcon.text;
    userPostModel.itemMarks = lostmarkingscon.text;
    userPostModel.itemserailNum = lostseirlostalnumcon.text;
    userPostModel.phtoURL = photoURL;
    userPostModel.datelossfound = lostdatetimeController.text;
    userPostModel.itemstatus = "Lost";
    userPostModel.itemtype = itemvalue;
    userPostModel.userposterPhourl = userlogin!.profileURL;
    userPostModel.userpostername = userlogin!.username;

    await FirebaseFirestore.instance
        .collection('lost_items')
        .doc(user!.uid)
        .collection('litems')
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
  //===========================================
  //===========================================

  //create function for handling the user data
  //===========================================
  handlesubmit(BuildContext context) {
    if (lostitemtitlecon.text.isEmpty ||
        lostdatetimeController.text.isEmpty ||
        lostfounddescriptionrcon.text.isEmpty ||
        lostlocationcon.text.isEmpty ||
        lostlocationDescriptioncon.text.isEmpty ||
        lostitemdescriptioncon.text.isEmpty ||
        lostmarkingscon.text.isEmpty) {
      snackBarScreen(context, "Please fill out all the important form");
    } else if (imagepathfile == null) {
      snackBarScreen(context, "Please select an image");
    } else {
      snackBarScreen(context, "Submitting please wait");
      createposttoFirebase();
    }
  }
  //===========================================
  //===========================================

  //after the data is upoaded clear all the form
  //===========================================
  handleformclear() {
    lostitemtitlecon.clear();
    lostmobilenumbercon.clear();
    lostsocialmediacon.clear();
    lostlocationcon.clear();
    lostlocationDescriptioncon.clear();
    lostitemdescriptioncon.clear();
    lostfounddescriptionrcon.clear();
    lostmodelcon.clear();
    lostbrandcon.clear();
    lostmarkingscon.clear();
    lostseirlostalnumcon.clear();
    lostdatetimeController.clear();
    imagepathfile = null;
    lostitemcolorcon.clear();
  }

  //show option dialod after triggering the callback event
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
                  SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SliverHomePage()));
                    handleformclear();
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
    lostitemtitlecon.dispose();
    lostmobilenumbercon.dispose();
    lostitemcolorcon.dispose();
    lostsocialmediacon.dispose();
    lostlocationcon.dispose();
    lostlocationDescriptioncon.dispose();
    lostitemdescriptioncon.dispose();
    lostfounddescriptionrcon.dispose();
    lostmodelcon.dispose();
    lostbrandcon.dispose();
    lostmarkingscon.dispose();
    lostseirlostalnumcon.dispose();
    lostdatetimeController.dispose();
    super.dispose();
  }
}
