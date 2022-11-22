// ignore_for_file: no_logic_in_create_state

import 'package:flutter/scheduler.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:lostfoundapp/mics/packages.dart';

class EditTextPostLost extends StatefulWidget {
  final UserPostModel usermodel;
  const EditTextPostLost(this.usermodel, {super.key});

  @override
  State<EditTextPostLost> createState() => _EditTextPostLostState();
}

class _EditTextPostLostState extends State<EditTextPostLost> {
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
    final String colorValue = "${widget.usermodel.itemcolor}";
    final int value = int.parse(colorValue);
    final Color colorval = Color(value);
    SchedulerBinding.instance.addPostFrameCallback((timestamp) {
      edititemtitlecon.text = "${widget.usermodel.itemname}";
      editfounddescriptionrcon.text = "${widget.usermodel.foundlossDes}";
      editlocationcon.text = "${widget.usermodel.location}";
      editlocationDescriptioncon.text = "${widget.usermodel.locationDes}";
      edititemdescriptioncon.text = "${widget.usermodel.itemDes}";
      editmobilenumbercon.text = "${widget.usermodel.usermobileNum}";
      editsocialmediacon.text = "${widget.usermodel.userSocialMedia}";
      editmodelcon.text = "${widget.usermodel.itemmodel}";
      editdatetimeController.text = "${widget.usermodel.datelossfound}";
      editbrandcon.text = "${widget.usermodel.itembrand}";
      editmarkingscon.text = "${widget.usermodel.itemMarks}";
      editseiralnumcon.text = "${widget.usermodel.itemserailNum}";
      edititemcolorcon.text = "#${colorval.value.toRadixString(16)}";
      setState(() {
        colorvalue = colorval;
        itemcolorpresent = value.toString();
        itemvalue = "${widget.usermodel.itemtype}";
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
    widget.usermodel.itemname = edititemtitlecon.text;
    widget.usermodel.itemcolor = itemcolorpresent.toString();
    widget.usermodel.usermobileNum = editmobilenumbercon.text;
    widget.usermodel.userSocialMedia = editsocialmediacon.text;
    widget.usermodel.location = editlocationcon.text;
    widget.usermodel.locationDes = editlocationDescriptioncon.text;
    widget.usermodel.itemDes = edititemdescriptioncon.text;
    widget.usermodel.foundlossDes = editfounddescriptionrcon.text;
    widget.usermodel.itemmodel = editmodelcon.text;
    widget.usermodel.datelossfound = editdatetimeController.text;
    widget.usermodel.itembrand = editbrandcon.text;
    widget.usermodel.itemMarks = editmarkingscon.text;
    widget.usermodel.itemserailNum = editseiralnumcon.text;
    widget.usermodel.itemtype = itemvalue;

    await FirebaseFirestore.instance
        .collection("lost_items")
        .doc(user!.uid)
        .collection('litems')
        .doc(widget.usermodel.postID)
        .update(widget.usermodel.tomap());

    await FirebaseFirestore.instance
        .collection('users_Post')
        .doc(widget.usermodel.postID)
        .update(widget.usermodel.tomap());

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
  void initState() {
    handleuserdatevalue();
    super.initState();
  }

//BuildColorpicker
  Color colorvalue = primaryColor;
  String? itemcolorpresent;
  Color current = primaryColor;
  Widget buildcolorpicker() => ColorPicker(
      pickerColor: current,
      enableAlpha: false,
      labelTypes: const [],
      onColorChanged: (color) => setState(() {
            colorvalue = color;
            edititemcolorcon.text = "#${color.value.toRadixString(16)}";
            itemcolorpresent = color.value.toString();
          }));
  //pickedcolor
  pickedColor(BuildContext context) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  buildcolorpicker(),
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("SELECT")),
                ],
              ),
            ),
          ));
  //==
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
                                color: colorvalue,
                              ),
                            ),
                            labelText: 'Color ',
                            labelStyle: GoogleFonts.inter(
                                fontSize: 12, color: colorgrey),
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
              height: 15.0,
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
              date: "Date the item lost",
              locationtitle: 'Location the item last seen',
            ),
            const SizedBox(
              height: 18.0,
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
        ),
      ),
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
    edititemtitlecon.dispose();
    editmobilenumbercon.dispose();
    editsocialmediacon.dispose();
    editlocationcon.dispose();
    editlocationDescriptioncon.dispose();
    edititemdescriptioncon.dispose();
    editfounddescriptionrcon.dispose();
    editmodelcon.dispose();
    editbrandcon.dispose();
    editmarkingscon.dispose();
    editseiralnumcon.dispose();
    edititemcolorcon.dispose();
    super.dispose();
  }
}
