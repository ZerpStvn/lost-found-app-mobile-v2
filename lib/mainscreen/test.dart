// import 'dart:io';

// import 'package:lostfoundapp/mics/packages.dart';

// class TestAlgo extends StatefulWidget {
//   const TestAlgo({super.key});

//   @override
//   State<TestAlgo> createState() => _TestAlgoState();
// }

// class _TestAlgoState extends State<TestAlgo> {
//   final TextEditingController _value = TextEditingController();
//   XFile? imagepath;
//   ImagePicker pickimage = ImagePicker();
//   String pixelcolor = "";
//   Color squarecolor = Colors.white;
//   List? _result;
//   String imageclass = "";

//   handlepickimage() async {
//     XFile? imagefile = await pickimage.pickImage(source: ImageSource.gallery);
//     setState(() {
//       imagepath = imagefile;
//     });
//     imageClassification();
//   }

//   //load the tflite model from folder assets
//   Future loadModel() async {
//     Tflite.close();
//     await Tflite.loadModel(
//       model: 'assets/model_unquant.tflite',
//       labels: 'assets/labels.txt',
//       isAsset: true,
//       useGpuDelegate: false,
//     );
//   }

//   //color image detection function
//   Future imageClassification() async {
//     var imgClassification = await Tflite.runModelOnImage(
//         path: imagepath!.path,
//         numResults: 14,
//         threshold: 0.03,
//         imageMean: 127.5,
//         imageStd: 127.5,
//         asynch: true);
//     setState(() {
//       _result = imgClassification;
//       debugPrint('Result of classification  $_result');
//     });
//   }

//   timerdelay() async {
//     await Future.delayed(const Duration(milliseconds: 1900));
//   }

//   Future showmodalloading() async {
//     AlertDialog alert = AlertDialog(
//       backgroundColor: Colors.transparent,
//       content: SizedBox(
//         height: 65,
//         width: 50,
//         child: Column(
//           children: const [
//             CircularProgressIndicator(
//               color: Colors.white,
//             ),
//             SizedBox(
//               height: 5.0,
//             ),
//             Text(
//               "Loading",
//             )
//           ],
//         ),
//       ),
//     );
//     showDialog(
//         barrierDismissible: false,
//         context: context,
//         builder: (context) {
//           return alert;
//         });
//     await Future.delayed(const Duration(milliseconds: 1900));
//     setState(() {
//       Navigator.pop(context);
//     });
//   }

//   //return image pixel
//   Widget hanldeimagepixelColor(BuildContext context) {
//     Image img = Image.file(File(imagepath!.path));
//     if (imagepath == null) {
//     } else {
//       return ImagePixels(
//           imageProvider: img.image,
//           builder: (context, img) {
//             int? imgwidth = img.width;
//             int? imghieght = img.height;
//             double helfwidth = imgwidth! / 2;
//             double halfhieght = imghieght! / 2;
//             double helfwidth2 = imgwidth / 3;
//             double halfhieght2 = imghieght / 2;
//             double helfwidth3 = imgwidth / 2;
//             double halfhieght3 = imghieght / 3;
//             int xRelative = helfwidth.toInt();
//             int yRelative = halfhieght.toInt();
//             int xRelative2 = helfwidth2.toInt();
//             int yRelative2 = halfhieght2.toInt();
//             int xRelative3 = helfwidth3.toInt();
//             int yRelative3 = halfhieght3.toInt();
//             Color color = img.pixelColorAt!(xRelative, yRelative);
//             Color color2 = img.pixelColorAt!(xRelative2, yRelative2);
//             Color color3 = img.pixelColorAt!(xRelative3, yRelative3);
//             var colorhex = "#${color.value.toRadixString(16)}";
//             var colorhex2 = "#${color2.value.toRadixString(16)}";
//             var colorhex3 = "#${color3.value.toRadixString(16)}";
//             List colorvalue = [colorhex, colorhex2, colorhex3];
//             debugPrint('$xRelative');
//             debugPrint('$yRelative');
//             debugPrint('$colorvalue');
//             return Row(
//               children: [
//                 GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       debugPrint(colorhex2);
//                       _value.text = colorhex2;
//                       squarecolor = color2;
//                     });
//                   },
//                   child: Container(
//                     height: 35,
//                     width: 110,
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(30), color: color2),
//                     child: Center(
//                       child: TextViewInter(
//                           title: colorhex2,
//                           fontsize: 15,
//                           fontweight: FontWeight.normal,
//                           fontcolor: colorhex2.toString() == "#ffffffff"
//                               ? colorblack
//                               : colorWhite),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   width: 10,
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       pixelcolor = colorhex;
//                       debugPrint(colorhex);
//                       _value.text = pixelcolor;
//                       squarecolor = color;
//                     });
//                   },
//                   child: Container(
//                     height: 35,
//                     width: 110,
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(30), color: color),
//                     child: Center(
//                       child: TextViewInter(
//                           title: colorhex,
//                           fontsize: 15,
//                           fontweight: FontWeight.normal,
//                           fontcolor: colorhex2.toString() == "#ffffffff"
//                               ? colorblack
//                               : colorWhite),
//                     ),
//                   ),
//                 ),
//               ],
//             );
//           });
//     }
//     return Container();
//   }

//   @override
//   void initState() {
//     loadModel();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _value.dispose();
//     super.dispose();
//   }

//   Widget handleImageClass() {
//     (imagepath != null)
//         ? _result!.map((result) {
//             return GestureDetector(
//               onTap: () {
//                 imageclass = "${result['label']}";
//               },
//               child: Padding(
//                 padding: const EdgeInsets.all(12.0),
//                 child: Container(
//                   color: colorblack,
//                   child: Text(
//                     "${result['label']}",
//                     style: const TextStyle(color: colorWhite),
//                   ),
//                 ),
//               ),
//             );
//           }).toList()
//         : [];
//     return Container();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size.width;
//     return Scaffold(
//       body: SafeArea(
//           child: SingleChildScrollView(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Stack(
//               children: [
//                 SizedBox(
//                   height: 230,
//                   width: size,
//                   child: imagepath == null
//                       ? Image.asset("assets/background_green.jpg")
//                       : Image.file(File(imagepath!.path)),
//                 ),
//               ],
//             ),
//             Padding(
//               padding: const EdgeInsets.all(18.0),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   IconButton(
//                       onPressed: handlepickimage,
//                       icon: const Icon(
//                         Icons.add_a_photo_outlined,
//                         size: 25,
//                         color: primaryColor,
//                       )),
//                 ],
//               ),
//             ),
//             Center(
//               child: SizedBox(
//                 width: size * 0.50,
//                 child: TextFormField(
//                   readOnly: true,
//                   controller: _value,
//                   textInputAction: TextInputAction.done,
//                   decoration: InputDecoration(
//                       suffixIcon: Icon(Icons.square, color: squarecolor),
//                       border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(30))),
//                 ),
//               ),
//             ),
//             Column(
//               children: (imagepath != null)
//                   ? _result!.map((result) {
//                       return GestureDetector(
//                         onTap: () {
//                           imageclass = "${result['label']}";
//                           debugPrint(imageclass);
//                         },
//                         child: Padding(
//                           padding: const EdgeInsets.all(12.0),
//                           child: Container(
//                               color: colorblack,
//                               child: Text(
//                                 "${result['label']}",
//                                 style: const TextStyle(color: colorWhite),
//                               )),
//                         ),
//                       );
//                     }).toList()
//                   : [],
//             ),
//             const SizedBox(
//               height: 24,
//             ),
//             const Text("Suggested color"),
//             const SizedBox(
//               height: 24,
//             ),
//             if (imagepath == null)
//               Container()
//             else
//               hanldeimagepixelColor(context),
//             const SizedBox(
//               height: 24,
//             ),
//           ],
//         ),
//       )),
//     );
//   }
// }
import 'package:lostfoundapp/mics/packages.dart';

class WidgetView extends StatefulWidget {
  const WidgetView({super.key});

  @override
  State<WidgetView> createState() => _WidgetViewState();
}

class _WidgetViewState extends State<WidgetView> {
  String str = "hello world";
  String str1 = "hello";
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
