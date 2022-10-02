import 'dart:io';

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
    return Scaffold(
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
                        onPressed: () {},
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
    );
  }
}
