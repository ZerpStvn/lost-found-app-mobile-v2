import 'dart:io';
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
  XFile? imagepathfile;
  final ImagePicker _picker = ImagePicker();
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
  String pixelcolor = "";
  Color squarecolor = Colors.white;
  List _result = [];
  String imageclass = "";

  //
  //
  //
  //
  //

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
    showmodalloading();
  }
  //===========================================

  Future showmodalloading() async {
    AlertDialog alert = AlertDialog(
      backgroundColor: colorWhite,
      content: SizedBox(
        height: 65,
        width: 50,
        child: Column(
          children: const [
            CircularProgressIndicator(
              color: primaryColor,
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              "Image is beign process...",
            )
          ],
        ),
      ),
    );
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return alert;
        });
    await Future.delayed(const Duration(milliseconds: 5000));
    setState(() {
      Navigator.pop(context);
      imageClassification();
    });
  }

//

  //load the tflite model from folder assets
  Future loadModel() async {
    Tflite.close();
    await Tflite.loadModel(
      model: 'assets/model_unquant.tflite',
      labels: 'assets/labels.txt',
      isAsset: true,
      useGpuDelegate: false,
    );
  }

  //color image detection function
  Future imageClassification() async {
    var imgClassification = await Tflite.runModelOnImage(
        path: imagepathfile!.path,
        numResults: 14,
        threshold: 0.03,
        imageMean: 127.5,
        imageStd: 127.5,
        asynch: true);
    setState(() {
      _result = imgClassification!;
    });
  }

  //return image pixel
  Widget hanldeimagepixelColor(BuildContext context) {
    if (isloading = true) {
      Image img = Image.file(File(imagepathfile!.path));
      return ImagePixels(
          imageProvider: img.image,
          builder: (context, img) {
            try {
              int? imgwidth = img.width;
              int? imghieght = img.height;
              double helfwidth = imgwidth! / 2;
              double halfhieght = imghieght! / 2;
              double helfwidth2 = imgwidth / 3;
              double halfhieght2 = imghieght / 2;
              int xRelative = helfwidth.toInt();
              int yRelative = halfhieght.toInt();
              int xRelative2 = helfwidth2.toInt();
              int yRelative2 = halfhieght2.toInt();
              Color color = img.pixelColorAt!(xRelative, yRelative);
              Color color2 = img.pixelColorAt!(xRelative2, yRelative2);
              var colorhex = "#${color.value.toRadixString(16)}";
              var colorhex2 = "#${color2.value.toRadixString(16)}";
              return Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        lostitemcolorcon.text = colorhex2;
                        squarecolor = color2;
                      });
                    },
                    child: Container(
                      height: 35,
                      width: 110,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: color2),
                      child: Center(
                        child: TextViewInter(
                            title: colorhex2,
                            fontsize: 15,
                            fontweight: FontWeight.normal,
                            fontcolor: colorhex2.toString() == "#ffffffff"
                                ? colorblack
                                : colorWhite),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        pixelcolor = colorhex;
                        lostitemcolorcon.text = pixelcolor;
                        squarecolor = color;
                      });
                    },
                    child: Container(
                      height: 35,
                      width: 110,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: color),
                      child: Center(
                        child: TextViewInter(
                            title: colorhex,
                            fontsize: 15,
                            fontweight: FontWeight.normal,
                            fontcolor: colorhex2.toString() == "#ffffffff"
                                ? colorblack
                                : colorWhite),
                      ),
                    ),
                  ),
                ],
              );
            } catch (error) {
              debugPrint("$error");
            }
            return Container();
          });
    } else {
      return Container();
    }
  }

  @override
  void initState() {
    loadModel();
    super.initState();
  }
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
                        onTap: () {
                          handlepickphotoGallery();
                          setState(() {
                            isloading = true;
                          });
                        },
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
                    const SizedBox(
                      height: 10,
                    ),
                    imagepathfile == null
                        ? Container()
                        : const TextViewPoppins(
                            title: "Suggested item name",
                            fontsize: 14,
                            fontcolor: colorblack),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: imagepathfile == null
                          ? Container()
                          : Row(
                              mainAxisSize: MainAxisSize.min,
                              children: (isloading = true)
                                  ? _result.map((result) {
                                      return GestureDetector(
                                        onTap: () {
                                          imageclass = "${result['label']}";
                                          lostitemtitlecon.text = imageclass;
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Container(
                                              height: 35,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  color: primaryColor),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  "${result['label']}",
                                                  style: const TextStyle(
                                                      color: colorWhite),
                                                ),
                                              )),
                                        ),
                                      );
                                    }).toList()
                                  : [],
                            ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                        width: widthsize * 0.50,
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
                            suffixIcon: Icon(
                              Icons.square,
                              color: squarecolor,
                            ),
                            labelText: 'Color ',
                            labelStyle: GoogleFonts.inter(
                                fontSize: 12, color: colorgrey),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(0)),
                          ),
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    imagepathfile == null
                        ? Container()
                        : const TextViewPoppins(
                            title: "Suggested colors",
                            fontsize: 14,
                            fontcolor: colorblack),
                    imagepathfile == null
                        ? Container()
                        : hanldeimagepixelColor(context),
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
    userPostModel.phtoURL = photoURL;
    userPostModel.datelossfound = lostdatetimeController.text;
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

    navigator.pop();
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
