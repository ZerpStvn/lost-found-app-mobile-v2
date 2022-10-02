import 'dart:io';
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

  //hanlde pick imagefrom gallery
  handlepickphotoGallery() async {
    XFile? imagepath = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    setState(() {
      imagepathfile = imagepath;
    });
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
