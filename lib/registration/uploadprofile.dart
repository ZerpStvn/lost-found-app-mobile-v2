import 'dart:io';
import 'dart:io' as io;

import 'package:lostfoundapp/mics/packages.dart';

class UploadProgilePage extends StatefulWidget {
  const UploadProgilePage({super.key});

  @override
  State<UploadProgilePage> createState() => _UploadProgilePageState();
}

class _UploadProgilePageState extends State<UploadProgilePage> {
  XFile? image;
  String? postId = const Uuid().v4();
  ImagePicker imagepic = ImagePicker();
  bool isloading = false;
  final userAuth = FirebaseAuth.instance;

  snacbarmessage(BuildContext context, String title) {
    final snack = SnackBar(
      content: TextView(
        title: title,
        fontcolor: colorWhite,
        fontsize: 12,
        fontweight: FontWeight.normal,
      ),
      backgroundColor: colorblack,
    );
    ScaffoldMessenger.of(context).showSnackBar(snack);
  }

  hanldephoto() async {
    XFile? image =
        await imagepic.pickImage(source: ImageSource.gallery, imageQuality: 85);
    setState(() {
      this.image = image;
    });
  }

  Future<String> uploadImage(image) async {
    final metadata = SettableMetadata(
      contentType: 'image/jpeg',
      customMetadata: {'picked-file-path': image.path},
    );
    UploadTask uploadTask = storageRef
        .child("userprofile_$postId.jpg")
        .putFile(io.File(image.path), metadata);
    TaskSnapshot taskSnapshot = await uploadTask;
    String mediaURL = await taskSnapshot.ref.getDownloadURL();
    return mediaURL;
  }

  updatefield() async {
    final navigator = Navigator.of(context);
    User? user = userAuth.currentUser;
    if (image == null) {
      snacbarmessage(context, "plese select an image");
    }
    if (image != null) {
      setState(() {
        isloading = true;
      });
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const Center(
                child: CircularProgressIndicator(),
              ));
      String? mediaURL = await uploadImage(image);
      userDataRef.doc(user!.uid).update({'profileURL': mediaURL});
      navigator.popUntil((route) => route.isFirst);
      setState(() {
        postId;
        isloading = false;
        navigator.pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const LoginPage()),
            (route) => false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Stack(
              children: [
                image == null
                    ? Container(
                        height: 200,
                        width: 200,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/avatar.png'),
                              fit: BoxFit.cover),
                          shape: BoxShape.circle,
                        ),
                      )
                    : Container(
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: FileImage(File(image!.path)),
                              fit: BoxFit.cover),
                          shape: BoxShape.circle,
                        ),
                      ),
                Positioned(
                  right: 11.0,
                  top: 145.0,
                  child: SizedBox(
                    height: 50,
                    width: 50,
                    child: Material(
                        elevation: 0,
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(50),
                        child: Center(
                            child: IconButton(
                          onPressed: hanldephoto,
                          icon: const Icon(
                            Icons.add_a_photo_sharp,
                            color: colorWhite,
                          ),
                        ))),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10.0),
          Text(
            "Upload your Profile Photo",
            style: GoogleFonts.inter(
                fontSize: 14, fontWeight: FontWeight.normal, color: colorblack),
          ),
          const SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(
              child: Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(20),
                color: primaryColor,
                child: MaterialButton(
                  padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                  minWidth: MediaQuery.of(context).size.width,
                  onPressed: () {
                    isloading ? null : updatefield();
                  },
                  child: Text(
                    "UPLOAD",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: colorWhite),
                  ),
                ),
              ),
            ),
          )
        ],
      )),
    );
  }
}
