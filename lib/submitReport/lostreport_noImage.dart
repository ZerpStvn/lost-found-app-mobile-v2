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
    userPostModel.itemname = itemtitlecon.text;
    userPostModel.itemcolor = "";
    userPostModel.usermobileNum = mobilenumbercon.text;
    userPostModel.userSocialMedia = socialmediacon.text;
    userPostModel.location = locationcon.text;
    userPostModel.locationDes = locationDescriptioncon.text;
    userPostModel.itemDes = itemdescriptioncon.text;
    userPostModel.foundlossDes = founddescriptionrcon.text;
    userPostModel.itemmodel = modelcon.text;
    userPostModel.itembrand = brandcon.text;
    userPostModel.itemMarks = markingscon.text;
    userPostModel.itemserailNum = seiralnumcon.text;
    userPostModel.datelossfound = datetimepicked;
    userPostModel.phtoURL = "empty";
    userPostModel.itemstatus = "Lost";
    userPostModel.itemtype = "";
    userPostModel.itemsubtype = "";
    userPostModel.userposterPhourl = userlogin!.profileURL;
    userPostModel.userpostername = userlogin!.username;

    await FirebaseFirestore.instance
        .collection("lost_items")
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
    if (itemtitlecon.text.isEmpty ||
        founddescriptionrcon.text.isEmpty ||
        locationcon.text.isEmpty ||
        locationDescriptioncon.text.isEmpty ||
        itemdescriptioncon.text.isEmpty ||
        markingscon.text.isEmpty) {
      snackBarScreen(context, "Please fill out all the important form");
    } else {
      snackBarScreen(context, "Submitting please wait");
      createposttoFirebase();
    }
  }

  handleformclear() {
    itemtitlecon.clear();
    mobilenumbercon.clear();
    socialmediacon.clear();
    locationcon.clear();
    locationDescriptioncon.clear();
    itemdescriptioncon.clear();
    founddescriptionrcon.clear();
    modelcon.clear();
    brandcon.clear();
    markingscon.clear();
    seiralnumcon.clear();
    itemcolorcon.clear();
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
              const SubmitReportForm(),
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
}
