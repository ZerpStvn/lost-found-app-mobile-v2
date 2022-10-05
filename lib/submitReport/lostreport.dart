import 'dart:io';
import 'dart:io' as io;
import 'package:flutter/scheduler.dart';
import 'package:lostfoundapp/mics/packages.dart';

class LostReportPage extends StatefulWidget {
  const LostReportPage({super.key});

  @override
  State<LostReportPage> createState() => _LostReportPageState();
}

class _LostReportPageState extends State<LostReportPage> {
  bool isloading = false;
  XFile? imagepathfile;
  final ImagePicker _picker = ImagePicker();
  final user = FirebaseAuth.instance.currentUser;
  String postID = const Uuid().v4();
  UserPostModel userPostModel = UserPostModel();

  //
  //this area will handle the user image privider
  //hanlde pick imagefrom gallery
  handlepickphotoGallery() async {
    XFile? imagepath = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    setState(() {
      imagepathfile = imagepath;
    });
  }
  //===========================================
  //===========================================

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
                    child: imagepathfile == null
                        ? const Center(
                            child: Text("no image selected"),
                          )
                        : Image.file(
                            File(imagepathfile!.path),
                            fit: BoxFit.cover,
                          ),
                  ),
                  Positioned(
                      top: 160.0,
                      right: 15.0,
                      child: GestureDetector(
                        onTap: handlepickphotoGallery,
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: primaryColor),
                          child: const Icon(
                            Icons.camera_outlined,
                            color: colorWhite,
                          ),
                        ),
                      )),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              formpage(context),
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

  Widget formpage(BuildContext context) {
    if (mounted) {
      return const SubmitReportForm();
    } else {
      dispose();
      return Container();
    }
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
  Future<String> uploadImage(imagepathfile) async {
    final metadata = SettableMetadata(
      contentType: 'image/jpeg',
      customMetadata: {'picked-file-path': imagepathfile.path},
    );
    UploadTask uploadTask = storageRef
        .child("Lostpost_$postID.jpg")
        .putFile(io.File(imagepathfile.path), metadata);
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
    String photoURL = await uploadImage(imagepathfile);
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
    userPostModel.phtoURL = photoURL;
    userPostModel.datelossfound = datetimepicked;
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
  //===========================================
  //===========================================

  //create function for handling the user data
  //===========================================
  handlesubmit(BuildContext context) {
    if (itemtitlecon.text.isEmpty ||
        founddescriptionrcon.text.isEmpty ||
        locationcon.text.isEmpty ||
        locationDescriptioncon.text.isEmpty ||
        itemdescriptioncon.text.isEmpty ||
        markingscon.text.isEmpty) {
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
    imagepathfile = null;
    itemcolorcon.clear();
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
}
