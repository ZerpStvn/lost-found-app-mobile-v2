import 'package:intl/intl.dart';
import 'package:lostfoundapp/mics/packages.dart';
import 'dart:io';
import 'dart:io' as io;

class ClaimedPage extends StatefulWidget {
  final UserPostModel userpost;
  const ClaimedPage(this.userpost, {super.key});

  @override
  State<ClaimedPage> createState() => _ClaimedPageState();
}

class _ClaimedPageState extends State<ClaimedPage> {
  XFile? imagepathfile;
  final ImagePicker _picker = ImagePicker();
  String postID = const Uuid().v4();
  final TextEditingController ownername = TextEditingController();
  final TextEditingController ownerID = TextEditingController();
  final TextEditingController ownerDept = TextEditingController();
  final TextEditingController refID = TextEditingController();
  final TextEditingController datepick = TextEditingController();

  handlepickphotoGallery() async {
    XFile? imagepath = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    setState(() {
      imagepathfile = imagepath;
    });
  }

  @override
  void dispose() {
    ownername.dispose();
    ownerID.dispose();
    ownerDept.dispose();
    datepick.dispose();
    refID.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Timestamp timestamp = Timestamp.now();
    final DateTime timeDate = timestamp.toDate();
    final tiemformat = DateFormat('M/d/y KK:mm').format(timeDate);

    refID.text = "${widget.userpost.postID}";
    datepick.text = tiemformat;

    return Scaffold(
      backgroundColor: colorWhite,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 220,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    "${widget.userpost.phtoURL}",
                    fit: BoxFit.cover,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 19,
            ),
            Padding(
              padding: const EdgeInsets.all(11.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const TextViewInter(
                          title: "Ref ID: ",
                          fontsize: 14,
                          fontweight: FontWeight.bold,
                          fontcolor: colorblack),
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
                            controller: refID,
                            decoration: InputDecoration(
                              hintText: "Reference ID",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    controller: ownername,
                    decoration: InputDecoration(
                      hintText: "Owner's name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          textInputAction: TextInputAction.next,
                          controller: ownerID,
                          decoration: InputDecoration(
                            hintText: "School ID",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          textInputAction: TextInputAction.done,
                          controller: ownerDept,
                          decoration: InputDecoration(
                            hintText: "Department",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    style: GoogleFonts.inter(fontSize: 12, color: colorgrey),
                    autofocus: false,
                    controller: datepick,
                    readOnly: true,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      prefixIcon:
                          const Icon(Icons.calendar_month, color: primaryColor),
                      contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                      hintText: "Date claim",
                      hintStyle:
                          GoogleFonts.inter(fontSize: 12, color: colorgrey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 19,
                  ),
                  Row(
                    children: const [
                      TextViewInter(
                        title: "Image verification",
                        fontcolor: primaryColor,
                        fontsize: 15,
                        fontweight: FontWeight.bold,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5.0),
                        child: Icon(
                          Icons.help_outline,
                          color: primaryColor,
                          size: 18,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: handlepickphotoGallery,
                    child: Container(
                      height: 220,
                      width: MediaQuery.of(context).size.width,
                      decoration:
                          BoxDecoration(border: Border.all(color: colorblack)),
                      child: imagepathfile == null
                          ? const Center(
                              child: Icon(
                                Icons.add_a_photo_rounded,
                                size: 35,
                                color: primaryColor,
                              ),
                            )
                          : Image.file(File(imagepathfile!.path),
                              fit: BoxFit.cover),
                    ),
                  ),
                  const SizedBox(
                    height: 19,
                  ),
                  SizedBox(
                    height: 50,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                          ),
                          onPressed: () {
                            handlesubmitcontrol();
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
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }

  Future<String> uploadImage(imagepathfile) async {
    final metadata = SettableMetadata(
      contentType: 'image/jpeg',
      customMetadata: {'picked-file-path': imagepathfile.path},
    );
    UploadTask uploadTask = storageRef
        .child("verification_$postID.jpg")
        .putFile(io.File(imagepathfile.path), metadata);
    TaskSnapshot taskSnapshot = await uploadTask;
    String mediaURL = await taskSnapshot.ref.getDownloadURL();
    return mediaURL;
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

  ClaimedItemModel clm = ClaimedItemModel();
  Future deletedata() async {
    await FirebaseFirestore.instance
        .collection("found_items")
        .doc(userlogin!.useruid)
        .collection('fitems')
        .doc(widget.userpost.postID)
        .delete()
        .then((value) => debugPrint("data deleted"))
        .catchError((err) => debugPrint("Field to delete data"));
  }

  handlesubmit() async {
    final snack = snackBarScreen(context, "Loading please wait");
    final navigator = Navigator.of(context);
    String photoURL = await uploadImage(imagepathfile);
    clm.postID = widget.userpost.postID;
    clm.userID = widget.userpost.userID;
    clm.claimername = ownername.text;
    clm.claimerID = ownerID.text;
    clm.claimerdepartment = ownerDept.text;
    clm.claimerPhotoURL = photoURL;
    clm.itemname = widget.userpost.itemname;
    clm.itemcolor = widget.userpost.itemcolor;
    clm.usermobileNum = widget.userpost.usermobileNum;
    clm.userSocialMedia = widget.userpost.userSocialMedia;
    clm.location = widget.userpost.location;
    clm.locationDes = widget.userpost.locationDes;
    clm.itemDes = widget.userpost.itemDes;
    clm.foundlossDes = widget.userpost.foundlossDes;
    clm.itemmodel = widget.userpost.itemmodel;
    clm.datelossfound = widget.userpost.datelossfound;
    clm.itembrand = widget.userpost.itembrand;
    clm.itemMarks = widget.userpost.itemMarks;
    clm.itemserailNum = widget.userpost.itemserailNum;
    clm.phtoURL = widget.userpost.phtoURL;
    clm.itemstatus = "Claimed";
    clm.onwerprofileURl = userlogin!.profileURL;
    clm.ownersname = userlogin!.username;
    clm.itemtype = widget.userpost.itemtype;

    await FirebaseFirestore.instance
        .collection('Claimed_items')
        .doc(widget.userpost.postID)
        .set(clm.tomap());
    snack;

    Future.delayed(const Duration(milliseconds: 1000));
    deletedata();
    navigator
        .push(MaterialPageRoute(builder: (context) => const ArchivePage()));
  }

  handlesubmitcontrol() {
    if (ownername.text.isEmpty ||
        ownerID.text.isEmpty ||
        ownerDept.text.isEmpty ||
        refID.text.isEmpty) {
      snackBarScreen(context, "please fill out all the form");
    } else if (imagepathfile == null) {
      snackBarScreen(context, "please provide an image verification");
    } else {
      handlesubmit();
    }
  }
}
