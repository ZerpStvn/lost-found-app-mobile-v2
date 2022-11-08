// ignore_for_file: file_names

import 'package:flutter/scheduler.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:lostfoundapp/mics/packages.dart';

class LostReportOption2 extends StatefulWidget {
  const LostReportOption2({super.key});

  @override
  State<LostReportOption2> createState() => _LostReportOption2State();
}

class _LostReportOption2State extends State<LostReportOption2> {
  bool isloading = false;
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
  final _formKey = GlobalKey<FormState>();
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
    userPostModel.postID = postID.toString();
    userPostModel.userID = user!.uid;
    userPostModel.itemname = lostitemtitlecon.text;
    userPostModel.itemcolor = lostcolorValue;
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
    userPostModel.divToken = userlogin!.divToken;
    userPostModel.itemtype = itemvalue;
    userPostModel.userposterPhourl = userlogin!.profileURL;
    userPostModel.userpostername = userlogin!.username;
    userPostModel.imageListURL = [];
    await FirebaseFirestore.instance
        .collection('lost_items')
        .doc(user!.uid)
        .collection('litems')
        .doc(postID)
        .set(userPostModel.tomap());

    await FirebaseFirestore.instance
        .collection('users_Post')
        .doc(postID)
        .set(userPostModel.tomap());

    handleformclear();

    navigator.pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const SliverHomePage()),
        (route) => false);

    setState(() {
      postID;
      isloading = false;
    });
  }

  handlesubmit() {
    if (lostitemtitlecon.text.isEmpty ||
        lostdatetimeController.text.isEmpty ||
        lostfounddescriptionrcon.text.isEmpty ||
        lostlocationcon.text.isEmpty ||
        lostlocationDescriptioncon.text.isEmpty ||
        lostitemdescriptioncon.text.isEmpty ||
        lostmarkingscon.text.isEmpty ||
        lostcolorValue == null) {
      snackBarScreen(context, "Please fill out all the important form");
    } else {
      setState(() {
        isloading = true;
      });
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

  Color current = primaryColor;
  Color onchange = primaryColor;
  String? lostcolorValue;
  //BuildColorpicker
  Widget buildcolorpicker() => ColorPicker(
      pickerColor: current,
      enableAlpha: false,
      labelTypes: const [],
      onColorChanged: (color) => setState(() {
            onchange = color;
            lostitemcolorcon.text = "#${color.value.toRadixString(16)}";
            lostcolorValue = color.value.toString();
            debugPrint("$lostcolorValue");
          }));
  //pickedcolor
  pickedColor(BuildContext context) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  buildcolorpicker(),
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("SELECT")),
                ],
              ),
            ),
          ));
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
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          width: widthsize * 0.89,
                          child: TextFormField(
                            controller: lostitemtitlecon,
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.description_outlined,
                                color: primaryColor,
                              ),
                              labelText: 'Item name ',
                              labelStyle: GoogleFonts.inter(
                                  fontSize: 12, color: colorgrey),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(0)),
                            ),
                          )),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: TextFormField(
                              readOnly: true,
                              controller: lostitemcolorcon,
                              keyboardType: TextInputType.name,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.color_lens_outlined,
                                  color: primaryColor,
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    pickedColor(context);
                                  },
                                  icon: Icon(
                                    Icons.square,
                                    color: onchange,
                                  ),
                                ),
                                labelText: 'Color ',
                                labelStyle: GoogleFonts.inter(
                                    fontSize: 12, color: colorgrey),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(0)),
                              ),
                            ),
                          ),
                          const Expanded(flex: 1, child: ItemTypeCategory()),
                        ],
                      ),
                    ],
                  ),
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
                  date: "Date of loss",
                  keyform: _formKey,
                ),
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
                              if (_formKey.currentState!.validate()) {
                                isloading == false ? handlesubmit() : null;
                              }
                            },
                            child: Center(
                                child: isloading == false
                                    ? const TextViewInter(
                                        title: "SUBMIT",
                                        fontsize: 14,
                                        fontcolor: colorWhite,
                                        fontweight: FontWeight.bold,
                                      )
                                    : const CircularProgressIndicator(
                                        backgroundColor: colorWhite,
                                      ))),
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

  Future<bool> onwillPop() async {
    return (await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const TextViewPoppins(
              title: "Exit",
              fontsize: 18,
              fontcolor: primaryColor,
              fontweight: FontWeight.bold,
            ),
            content: const TextViewPoppins(
              title: "Are you sure you want to exit this page? ",
              fontsize: 15,
              fontcolor: colorblack,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
                child: const TextViewPoppins(
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
                child: const TextViewPoppins(
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
  void initState() {
    SchedulerBinding.instance.scheduleFrameCallback((timeStamp) {
      showdescriptionModal(context);
    });
    super.initState();
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
