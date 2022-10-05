// ignore_for_file: no_logic_in_create_state

import 'package:flutter/scheduler.dart';
import 'package:lostfoundapp/mics/packages.dart';

class EditTextPostLost extends StatefulWidget {
  final UserPostModel usermodel;
  const EditTextPostLost(this.usermodel, {super.key});

  @override
  State<EditTextPostLost> createState() => _EditTextPostLostState(usermodel);
}

class _EditTextPostLostState extends State<EditTextPostLost> {
  final UserPostModel usermodel;

  _EditTextPostLostState(this.usermodel);
  final user = FirebaseAuth.instance.currentUser;

  handleuserdatevalue() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        itemtitlecon.text = "${usermodel.itemname}";
        founddescriptionrcon.text = "${usermodel.foundlossDes}";
        //itemcolorcon.text = "${usermodel.itemcolor}";
        locationcon.text = "${usermodel.location}";
        locationDescriptioncon.text = "${usermodel.locationDes}";
        itemdescriptioncon.text = "${usermodel.itemDes}";
        mobilenumbercon.text = "${usermodel.usermobileNum}";
        socialmediacon.text = "${usermodel.userSocialMedia}";
        modelcon.text = "${usermodel.itemmodel}";
        datetimeController.text = "${usermodel.datelossfound}";
        brandcon.text = "${usermodel.itembrand}";
        markingscon.text = "${usermodel.itemMarks}";
        seiralnumcon.text = "${usermodel.itemserailNum}";
      });
    });
  }

  @override
  void initState() {
    super.initState();
    handleuserdatevalue();
  }

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

  Future handlepostEdit() async {
    final navigator = Navigator.of(context);
    final snack = snackBarScreen(context, "Done");
    usermodel.itemname = itemtitlecon.text;
    usermodel.itemcolor = "";
    usermodel.usermobileNum = mobilenumbercon.text;
    usermodel.userSocialMedia = socialmediacon.text;
    usermodel.location = locationcon.text;
    usermodel.locationDes = locationDescriptioncon.text;
    usermodel.itemDes = itemdescriptioncon.text;
    usermodel.foundlossDes = founddescriptionrcon.text;
    usermodel.itemmodel = modelcon.text;
    usermodel.datelossfound = datetimepicked;
    usermodel.itembrand = brandcon.text;
    usermodel.itemMarks = markingscon.text;
    usermodel.itemserailNum = seiralnumcon.text;

    await FirebaseFirestore.instance
        .collection("lost_items")
        .doc(user!.uid)
        .collection('litems')
        .doc(usermodel.postID)
        .update(usermodel.tomap());

    snack;
    navigator.pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const SliverHomePage()),
        (route) => false);
    handleformclear();
  }

  handlesumbit() {
    final snack1 = snackBarScreen(context, "Updating please wait");
    if (itemtitlecon.text.isEmpty ||
        founddescriptionrcon.text.isEmpty ||
        locationcon.text.isEmpty ||
        locationDescriptioncon.text.isEmpty ||
        itemdescriptioncon.text.isEmpty ||
        markingscon.text.isEmpty) {
      snackBarScreen(context, "Please fill out all the important form");
    } else {
      snack1;
      handlepostEdit();
    }
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
              Stack(
                children: [
                  Container(
                    width: widthsize,
                    height: 230.0,
                    color: seconprimaryColor,
                    child: widget.usermodel.phtoURL == "empty"
                        ? const Center(
                            child: Text("no image selected"),
                          )
                        : Image.network(
                            '${widget.usermodel.phtoURL}',
                            fit: BoxFit.cover,
                          ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15.0,
              ),
              formpage(context),
              Padding(
                padding: const EdgeInsets.only(bottom: 13.0),
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
                            handlesumbit();
                          },
                          child: const Center(
                            child: TextViewInter(
                              title: "EDIT",
                              fontsize: 14,
                              fontcolor: colorWhite,
                              fontweight: FontWeight.bold,
                            ),
                          )),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
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

  Widget formpage(BuildContext context) {
    if (mounted) {
      return const SubmitReportForm();
    } else {
      dispose();
      return Container();
    }
  }
}
