import 'dart:io';
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
  XFile? imagepathfile;
  final ImagePicker _picker = ImagePicker();
  List? _colorRecognation;
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

//

//

//

  //hanlde pick imagefrom gallery
  handlepickphotoGallery() async {
    XFile? imagepath = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    setState(() {
      imagepathfile = imagepath;
    });
    try {
      colordectection();
    } catch (err) {
      debugPrint("$err");
    }
  }

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
  Future colordectection() async {
    var colordetect = await Tflite.runModelOnImage(
        path: imagepathfile!.path,
        numResults: 8,
        threshold: 0.07,
        imageMean: 127.5,
        imageStd: 127.5,
        asynch: true);
    setState(() {
      debugPrint('$colordetect');
      _colorRecognation = colordetect;
      isloading = true;
    });
  }

  //load the models
  @override
  void initState() {
    super.initState();
    loadModel();
    isloading = true;
    setState(() {
      isloading = false;
    });
  }

  //classify the color based on the result
  Color colorhanlde() {
    if ("${_colorRecognation![0]['label']}" == "Black") {
      return Colors.black;
    } else if ("${_colorRecognation![0]['label']}" == "Yellow") {
      return Colors.yellow;
    } else if ("${_colorRecognation![0]['label']}" == "Blue") {
      return Colors.blue;
    } else if ("${_colorRecognation![0]['label']}" == "Green") {
      return Colors.green;
    } else if ("${_colorRecognation![0]['label']}" == "Orange") {
      return Colors.orange;
    } else if ("${_colorRecognation![0]['label']}" == "Brown") {
      return Colors.brown;
    } else if ("${_colorRecognation![0]['label']}" == "Violet") {
      return Colors.deepPurple;
    } else if ("${_colorRecognation![0]['label']}" == "Red") {
      return Colors.red;
    }
    return primaryColor;
  }

  //suggest a color based on a result
  Widget colorsuggestion(BuildContext contex) {
    return _colorRecognation == null
        ? Container()
        : Container(
            height: 30,
            width: 65,
            decoration: BoxDecoration(
                color: colorhanlde(), borderRadius: BorderRadius.circular(30)),
            child: Center(
              child: TextViewInter(
                title: "${_colorRecognation![0]['label']}",
                fontcolor: colorWhite,
                fontsize: 15,
                fontweight: FontWeight.normal,
              ),
            ),
          );
  }

  //return image pixel
  Widget hanldeimagepixelColor(BuildContext context) {
    if (imagepathfile == null) {
      return Container();
    }
    if (imagepathfile != null) {
      Image img = Image.file(File(imagepathfile!.path));
      return ImagePixels(
          imageProvider: img.image,
          builder: (context, img) {
            int? imgwidth = img.width;
            int? imghieght = img.height;
            double helfwidth = imgwidth! / 2;
            double halfhieght = imghieght! / 2;
            int xRelative = helfwidth.toInt();
            int yRelative = halfhieght.toInt();
            Color color = img.pixelColorAt!(xRelative, yRelative);
            debugPrint('$xRelative');
            debugPrint('$yRelative');
            return Container(
              height: 35,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30), color: color),
              child: TextViewInter(
                  title: color.toString(),
                  fontsize: 15,
                  fontweight: FontWeight.normal,
                  fontcolor: colorWhite),
            );
          });
    }
    return Container();
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
              EditTextFormField(
                  cont1: founditemtitlecon,
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

  Future<String> uploadImage(imagepathfile) async {
    final metadata = SettableMetadata(
      contentType: 'image/jpeg',
      customMetadata: {'picked-file-path': imagepathfile.path},
    );
    UploadTask uploadTask = storageRef
        .child("Foundpost_$postID.jpg")
        .putFile(io.File(imagepathfile.path), metadata);
    TaskSnapshot taskSnapshot = await uploadTask;
    String mediaURL = await taskSnapshot.ref.getDownloadURL();
    return mediaURL;
  }

  createposttoFirebase() async {
    final navigator = Navigator.of(context);
    final snack = snackBarScreen(context, "Done");
    String photoURL = await uploadImage(imagepathfile);
    userPostModel.postID = postID.toString();
    userPostModel.userID = user!.uid;
    userPostModel.itemname = founditemtitlecon.text;
    userPostModel.itemcolor = "";
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
    userPostModel.itemtype = "";
    userPostModel.itemsubtype = "";
    userPostModel.userposterPhourl = userlogin!.profileURL;
    userPostModel.userpostername = userlogin!.username;

    await FirebaseFirestore.instance
        .collection("found_items")
        .doc(user!.uid)
        .collection('fitems')
        .doc(postID)
        .set(userPostModel.tomap());

    navigator.pop();
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
