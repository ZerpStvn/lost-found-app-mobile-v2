// ignore_for_file: no_logic_in_create_state

import 'package:flutter/scheduler.dart';
import 'package:lostfoundapp/mics/packages.dart';

class EditTextPost extends StatefulWidget {
  final UserPostModel usermodel;
  const EditTextPost(this.usermodel, {super.key});

  @override
  State<EditTextPost> createState() => _EditTextPostState(usermodel);
}

class _EditTextPostState extends State<EditTextPost> {
  final UserPostModel usermodel;
  _EditTextPostState(this.usermodel);
  final user = FirebaseAuth.instance.currentUser;
  final TextEditingController edititemtitlecon = TextEditingController();
  final TextEditingController editfounddescriptionrcon =
      TextEditingController();
  final TextEditingController edititemcolorcon = TextEditingController();
  final TextEditingController editlocationcon = TextEditingController();
  final TextEditingController editlocationDescriptioncon =
      TextEditingController();
  final TextEditingController edititemdescriptioncon = TextEditingController();
  final TextEditingController editmobilenumbercon = TextEditingController();
  final TextEditingController editsocialmediacon = TextEditingController();
  final TextEditingController editmodelcon = TextEditingController();
  final TextEditingController editbrandcon = TextEditingController();
  final TextEditingController editmarkingscon = TextEditingController();
  final TextEditingController editseiralnumcon = TextEditingController();

  final TextEditingController editdatetimeController = TextEditingController();

  handleuserdatevalue() async {
    SchedulerBinding.instance.addPostFrameCallback((timestamp) {
      edititemtitlecon.text = "${usermodel.itemname}";
      editfounddescriptionrcon.text = "${usermodel.foundlossDes}";
      //itemcolorcon.teeditxt = "${usermodel.itemcolor}";
      editlocationcon.text = "${usermodel.location}";
      editlocationDescriptioncon.text = "${usermodel.locationDes}";
      edititemdescriptioncon.text = "${usermodel.itemDes}";
      editmobilenumbercon.text = "${usermodel.usermobileNum}";
      editsocialmediacon.text = "${usermodel.userSocialMedia}";
      editmodelcon.text = "${usermodel.itemmodel}";
      editdatetimeController.text = "${usermodel.datelossfound}";
      editbrandcon.text = "${usermodel.itembrand}";
      editmarkingscon.text = "${usermodel.itemMarks}";
      editseiralnumcon.text = "${usermodel.itemserailNum}";
    });
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timestamp) {
      handleuserdatevalue();
    });
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
    usermodel.itemname = edititemtitlecon.text;
    usermodel.itemcolor = "";
    usermodel.usermobileNum = editmobilenumbercon.text;
    usermodel.userSocialMedia = editsocialmediacon.text;
    usermodel.location = editlocationcon.text;
    usermodel.locationDes = editlocationDescriptioncon.text;
    usermodel.itemDes = edititemdescriptioncon.text;
    usermodel.foundlossDes = editfounddescriptionrcon.text;
    usermodel.itemmodel = editmodelcon.text;
    usermodel.datelossfound = editdatetimeController.text;
    usermodel.itembrand = editbrandcon.text;
    usermodel.itemMarks = editmarkingscon.text;
    usermodel.itemserailNum = editseiralnumcon.text;
    usermodel.itemstatus = "Unclaimed";
    usermodel.itemtype = "";
    usermodel.itemsubtype = "";

    await FirebaseFirestore.instance
        .collection("found_items")
        .doc(user!.uid)
        .collection('fitems')
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
    if (edititemtitlecon.text.isEmpty ||
        editdatetimeController.text.isEmpty ||
        editfounddescriptionrcon.text.isEmpty ||
        editlocationcon.text.isEmpty ||
        editlocationDescriptioncon.text.isEmpty ||
        edititemdescriptioncon.text.isEmpty ||
        editmarkingscon.text.isEmpty) {
      snackBarScreen(context, "Please fill out all the important form");
    } else {
      snack1;
      handlepostEdit();
    }
  }

  @override
  Widget build(BuildContext context) {
    //const sizeheight = SizedBox(height: 10);
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
          EditTextFormField(
              cont1: edititemtitlecon,
              cont2: editfounddescriptionrcon,
              cont3: editlocationcon,
              cont4: editlocationDescriptioncon,
              cont5: edititemdescriptioncon,
              cont6: editmobilenumbercon,
              cont7: editsocialmediacon,
              cont8: editmodelcon,
              cont9: editbrandcon,
              cont10: editmarkingscon,
              cont11: editseiralnumcon,
              cont12: editdatetimeController,
              date: "Date"),
          const SizedBox(
            height: 18.0,
          ),
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
      )),
    );
  }

  handleformclear() {
    edititemtitlecon.clear();
    editmobilenumbercon.clear();
    editsocialmediacon.clear();
    editlocationcon.clear();
    editlocationDescriptioncon.clear();
    edititemdescriptioncon.clear();
    editfounddescriptionrcon.clear();
    editmodelcon.clear();
    editbrandcon.clear();
    editmarkingscon.clear();
    editseiralnumcon.clear();
    edititemcolorcon.clear();
  }

  @override
  void dispose() {
    editdatetimeController.dispose();
    edititemtitlecon.dispose();
    editfounddescriptionrcon.dispose();
    edititemcolorcon.dispose();
    editlocationcon.dispose();
    editlocationDescriptioncon.dispose();
    edititemdescriptioncon.dispose();
    editmobilenumbercon.dispose();
    editsocialmediacon.dispose();
    editmodelcon.dispose();
    editbrandcon.dispose();
    editmarkingscon.dispose();
    editseiralnumcon.dispose();
    super.dispose();
  }
}
