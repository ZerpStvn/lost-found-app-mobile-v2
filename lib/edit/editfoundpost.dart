// ignore_for_file: no_logic_in_create_state

import 'package:flutter/scheduler.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:lostfoundapp/mics/packages.dart';

class EditTextPost extends StatefulWidget {
  final UserPostModel usermodel;
  const EditTextPost(this.usermodel, {super.key});

  @override
  State<EditTextPost> createState() => _EditTextPostState(usermodel);
}

class _EditTextPostState extends State<EditTextPost> {
  Color sqcolor = primaryColor;
  String? itemcolorval;
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
  Color prime = primaryColor;
  Color current = primaryColor;
  handleuserdatevalue() {
    final String colorValue = "${widget.usermodel.itemcolor}";
    final int value = int.parse(colorValue);
    final Color colorval = Color(value);
    SchedulerBinding.instance.addPostFrameCallback((timestamp) {
      edititemtitlecon.text = "${usermodel.itemname}";
      editfounddescriptionrcon.text = "${usermodel.foundlossDes}";
      edititemcolorcon.text = "#${colorval.value.toRadixString(16)}";
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

      setState(() {
        sqcolor = colorval;
        itemcolorval = value.toString();
        itemvalue = "${usermodel.itemtype}";
      });
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
    usermodel.itemcolor = itemcolorval;
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
    usermodel.itemtype = itemvalue;

    await FirebaseFirestore.instance
        .collection("found_items")
        .doc(user!.uid)
        .collection('fitems')
        .doc(usermodel.postID)
        .update(usermodel.tomap());

    await FirebaseFirestore.instance
        .collection('users_Post')
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

  //BuildColorpicker
  Widget buildcolorpicker() => ColorPicker(
      pickerColor: current,
      enableAlpha: false,
      labelTypes: const [],
      onColorChanged: (color) => setState(() {
            sqcolor = color;
            edititemcolorcon.text = "#${color.value.toRadixString(16)}";
            itemcolorval = color.value.toString();
          }));
  //pickedcolor
  pickedColor(BuildContext context) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                buildcolorpicker(),
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("SELECT")),
              ],
            ),
          ));
  @override
  void initState() {
    handleuserdatevalue();
    super.initState();
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
            height: 19.0,
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    width: widthsize * 0.89,
                    child: TextFormField(
                      controller: edititemtitlecon,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.description_outlined,
                          color: primaryColor,
                        ),
                        labelText: 'Item name ',
                        labelStyle:
                            GoogleFonts.inter(fontSize: 12, color: colorgrey),
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
                        controller: edititemcolorcon,
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
                              color: sqcolor,
                            ),
                          ),
                          labelText: 'Color ',
                          labelStyle:
                              GoogleFonts.inter(fontSize: 12, color: colorgrey),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(0)),
                        ),
                      ),
                    ),
                    const Expanded(flex: 1, child: ItemTypeCategory())
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          EditTextFormField(
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
            date: "Date",
          ),
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
                      onPressed: handlesumbit,
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
