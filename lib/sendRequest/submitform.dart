import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:lostfoundapp/mics/packages.dart';

class RequestForm extends StatefulWidget {
  const RequestForm({
    super.key,
    required this.con1,
    required this.con2,
    required this.con3,
    required this.con4,
    required this.con5,
    required this.con6,
    required this.con7,
    required this.con8,
    required this.con9,
    required this.con10,
    required this.con12,
    required this.con13,
    required this.con14,
    required this.con15,
    required this.date,
  });
  final TextEditingController con1;
  final TextEditingController con2;
  final TextEditingController con3;
  final TextEditingController con4;
  final TextEditingController con5;
  final TextEditingController con6;
  final TextEditingController con7;
  final TextEditingController con8;
  final TextEditingController con9;
  final TextEditingController con10;
  final TextEditingController con12;
  final TextEditingController con13;
  final TextEditingController con14;
  final TextEditingController con15;
  final String date;

  @override
  State<RequestForm> createState() => _RequestFormState();
}

class _RequestFormState extends State<RequestForm> {
  @override
  void initState() {
    datetimeController.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final widthsize = MediaQuery.of(context).size.width;

    final size = MediaQuery.of(context).size.width;
    const sizeheight = SizedBox(height: 10);
    return Padding(
      padding: const EdgeInsets.only(left: 18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              TextViewInter(
                title: "PESONAL INFO",
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
          sizeheight,
          SizedBox(
            width: widthsize * 0.89,
            child: TextFormField(
              controller: widget.con1,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.person_outline,
                  color: primaryColor,
                ),
                labelText: 'Name ',
                labelStyle: GoogleFonts.inter(fontSize: 12, color: colorgrey),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(0)),
              ),
            ),
          ),
          sizeheight,
          SizedBox(
            width: widthsize * 0.89,
            child: TextFormField(
              controller: widget.con2,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.school_outlined,
                  color: primaryColor,
                ),
                labelText: 'School ID ',
                labelStyle: GoogleFonts.inter(fontSize: 12, color: colorgrey),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(0)),
              ),
            ),
          ),
          sizeheight,
          SizedBox(
            width: widthsize * 0.89,
            child: TextFormField(
              controller: widget.con3,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.school_outlined,
                  color: primaryColor,
                ),
                labelText: 'Deparment ',
                labelStyle: GoogleFonts.inter(fontSize: 12, color: colorgrey),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(0)),
              ),
            ),
          ),
          const SizedBox(
            height: 28.0,
          ),
          Row(
            children: const [
              TextViewInter(
                title: "ITEM DETIALS",
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
            height: 15.0,
          ),
          SizedBox(
            width: size * 0.89,
            child: TextFormField(
              controller: widget.con4,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.description_outlined,
                  color: primaryColor,
                ),
                labelText: 'Item ',
                labelStyle: GoogleFonts.inter(fontSize: 12, color: colorgrey),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(0)),
              ),
            ),
          ),
          sizeheight,
          SizedBox(
            width: widthsize * 0.89,
            child: TextFormField(
              style: GoogleFonts.inter(fontSize: 12, color: colorgrey),
              autofocus: false,
              controller: widget.con5,
              readOnly: true,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                if (pickedDate != null) {
                  String formattedDate =
                      DateFormat('MM-dd-yyyy').format(pickedDate);
                  setState(() {
                    widget.con5.text = formattedDate;
                  });
                }
              },
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                prefixIcon:
                    const Icon(Icons.calendar_month, color: primaryColor),
                contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                hintText: widget.date,
                hintStyle: GoogleFonts.inter(fontSize: 12, color: colorgrey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          sizeheight,
          SizedBox(
            width: size * 0.89,
            height: 5 * 25.0,
            child: TextFormField(
              controller: widget.con6,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              maxLength: 150,
              maxLines: 40,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              decoration: InputDecoration(
                hintText: 'Describe the item you found/loss ',
                hintStyle: GoogleFonts.inter(fontSize: 11, color: colorgrey),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(0)),
              ),
            ),
          ),
          sizeheight,
          Row(
            children: const [
              TextViewInter(
                title: "LOCATIONS",
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
              ),
            ],
          ),
          const SizedBox(
            height: 15.0,
          ),
          SizedBox(
            width: size * 0.89,
            child: TextFormField(
              controller: widget.con7,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.location_on_outlined,
                  color: primaryColor,
                ),
                labelText: 'Location ',
                labelStyle: GoogleFonts.inter(fontSize: 12, color: colorgrey),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(0)),
              ),
            ),
          ),
          sizeheight,
          SizedBox(
            width: size * 0.89,
            height: 5 * 25.0,
            child: TextFormField(
              controller: widget.con8,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              maxLength: 120,
              maxLines: 30,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              decoration: InputDecoration(
                hintText:
                    'Provide details about the location you found/loss the item ',
                hintStyle: GoogleFonts.inter(fontSize: 11, color: colorgrey),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(0)),
              ),
            ),
          ),
          sizeheight,
          Row(
            children: const [
              TextViewInter(
                title: "DESCRIPTIONS",
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
              ),
            ],
          ),
          const SizedBox(
            height: 15.0,
          ),
          SizedBox(
            width: size * 0.89,
            height: 5 * 25.0,
            child: TextFormField(
              controller: widget.con9,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              maxLength: 120,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              maxLines: 30,
              decoration: InputDecoration(
                hintText: "Provide description how you found/loss the Item",
                hintStyle: GoogleFonts.inter(fontSize: 11, color: colorgrey),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(0)),
              ),
            ),
          ),
          sizeheight,
          Row(
            children: const [
              TextViewInter(
                title: "CONTACTS",
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
              ),
            ],
          ),
          const SizedBox(
            height: 15.0,
          ),
          SizedBox(
            width: size * 0.89,
            child: TextFormField(
              controller: widget.con10,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.phone_outlined,
                  color: primaryColor,
                ),
                labelText: 'Mobile number ',
                labelStyle: GoogleFonts.inter(fontSize: 12, color: colorgrey),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(0)),
              ),
            ),
          ),
          sizeheight,
          const SizedBox(height: 29),
          Row(
            children: const [
              TextViewInter(
                title: "ITEMS",
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
              ),
            ],
          ),
          sizeheight,
          SizedBox(
            width: size * 0.89,
            child: TextFormField(
              controller: widget.con12,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.description_outlined,
                  color: primaryColor,
                ),
                labelText: 'Model(optional)',
                labelStyle: GoogleFonts.inter(fontSize: 12, color: colorgrey),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(0)),
              ),
            ),
          ),
          sizeheight,
          SizedBox(
            width: size * 0.89,
            child: TextFormField(
              controller: widget.con13,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.description_outlined,
                  color: primaryColor,
                ),
                labelText: 'Brand(Optional) ',
                labelStyle: GoogleFonts.inter(fontSize: 12, color: colorgrey),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(0)),
              ),
            ),
          ),
          const SizedBox(height: 29),
          Row(
            children: const [
              TextViewInter(
                title: "OTHERS",
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
              ),
            ],
          ),
          const SizedBox(
            height: 15.0,
          ),
          SizedBox(
            width: size * 0.89,
            child: TextFormField(
              controller: widget.con14,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.description_outlined,
                  color: primaryColor,
                ),
                labelText: 'Distinguishing markings ',
                labelStyle: GoogleFonts.inter(fontSize: 12, color: colorgrey),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(0)),
              ),
            ),
          ),
          sizeheight,
          SizedBox(
            width: size * 0.89,
            child: TextFormField(
              controller: widget.con15,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.done,
              maxLength: 150,
              maxLines: 8,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              decoration: InputDecoration(
                labelText: 'Leave a message ',
                labelStyle: GoogleFonts.inter(fontSize: 12, color: colorgrey),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(0)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
