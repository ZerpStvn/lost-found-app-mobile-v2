// ignore_for_file: file_names

import 'package:flutter/scheduler.dart';
import 'package:lostfoundapp/mics/packages.dart';

class LostReportOption2 extends StatefulWidget {
  const LostReportOption2({super.key});

  @override
  State<LostReportOption2> createState() => _LostReportOption2State();
}

class _LostReportOption2State extends State<LostReportOption2> {
  String postID = const Uuid().v4();
  UserPostModel userPostModel = UserPostModel();
  final user = FirebaseAuth.instance.currentUser;
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

  //
  //
  //
  //
  //
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

  createposttoFirebase() async {
    final navigator = Navigator.of(context);
    final snack = snackBarScreen(context, "Done");
    userPostModel.postID = postID.toString();
    userPostModel.userID = user!.uid;
    userPostModel.itemname = lostitemtitlecon.text;
    userPostModel.itemcolor = "";
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
    userPostModel.datelossfound = lostdatetimeController.text;
    userPostModel.phtoURL = "empty";
    userPostModel.itemstatus = "Lost";
    userPostModel.itemtype = "";
    userPostModel.itemsubtype = "";
    userPostModel.userposterPhourl = userlogin!.profileURL;
    userPostModel.userpostername = userlogin!.username;

    await FirebaseFirestore.instance
        .collection('lost_items')
        .doc(user!.uid)
        .collection('litems')
        .doc(postID)
        .set(userPostModel.tomap());
    snack;
    navigator.pop();
    handleformclear();
    setState(() {
      postID;
    });
  }

  handlesubmit(BuildContext context) {
    if (lostitemtitlecon.text.isEmpty ||
        lostdatetimeController.text.isEmpty ||
        lostfounddescriptionrcon.text.isEmpty ||
        lostlocationcon.text.isEmpty ||
        lostlocationDescriptioncon.text.isEmpty ||
        lostitemdescriptioncon.text.isEmpty ||
        lostmarkingscon.text.isEmpty) {
      snackBarScreen(context, "Please fill out all the important form");
    } else {
      snackBarScreen(context, "Submitting please wait");
      createposttoFirebase();
    }
  }

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
    lostitemcolorcon.clear();
  }

  @override
  Widget build(BuildContext context) {
    final widthsize = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: onwillPop,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              EditTextFormField(
                  cont1: lostitemtitlecon,
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
    );
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
                  SchedulerBinding.instance.scheduleFrameCallback((timeStamp) {
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
    lostsocialmediacon.dispose();
    lostlocationcon.dispose();
    lostlocationDescriptioncon.dispose();
    lostitemdescriptioncon.dispose();
    lostfounddescriptionrcon.dispose();
    lostmodelcon.dispose();
    lostbrandcon.dispose();
    lostmarkingscon.dispose();
    lostseirlostalnumcon.dispose();
    lostitemcolorcon.dispose();
    super.dispose();
  }
}
