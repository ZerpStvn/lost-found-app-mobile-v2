import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:lostfoundapp/mics/packages.dart';

class EditTextFormField extends StatefulWidget {
  const EditTextFormField({
    super.key,
    required this.cont2,
    required this.cont3,
    required this.cont4,
    required this.cont5,
    required this.cont6,
    required this.cont7,
    required this.cont8,
    required this.cont9,
    required this.cont10,
    required this.cont11,
    required this.cont12,
    required this.date,
    required this.locationtitle,
  });
  final TextEditingController cont2;
  final TextEditingController cont3;
  final TextEditingController cont4;
  final TextEditingController cont5;
  final TextEditingController cont6;
  final TextEditingController cont7;
  final TextEditingController cont8;
  final TextEditingController cont9;
  final TextEditingController cont10;
  final TextEditingController cont11;
  final TextEditingController cont12;
  final String date;
  final String locationtitle;

  @override
  State<EditTextFormField> createState() => _EditTextFormFieldState();
}

class _EditTextFormFieldState extends State<EditTextFormField> {
  String? datetimepicked;

  @override
  Widget build(BuildContext context) {
    const sizeheight = SizedBox(height: 10);
    final widthsize = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(left: 18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const TextViewInter(
                title: "ITEM DETAILS",
                fontcolor: primaryColor,
                fontsize: 15,
                fontweight: FontWeight.bold,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: GestureDetector(
                  onTap: () {
                    notifyUserText(context,
                        "Provide more details about how you found/lost the item (100 character)");
                  },
                  child: const Icon(
                    Icons.help_outline,
                    color: primaryColor,
                    size: 18,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 15.0,
          ),
          SizedBox(
            width: widthsize * 0.89,
            child: TextFormField(
              style: GoogleFonts.inter(fontSize: 12, color: colorgrey),
              autofocus: false,
              controller: widget.cont12,
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
                    widget.cont12.text = formattedDate;
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
            width: widthsize * 0.89,
            height: 5 * 25.0,
            child: TextFormField(
              controller: widget.cont2,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              maxLength: 320,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              maxLines: 30,
              decoration: InputDecoration(
                hintText: "Provide description how you found/lost the Item",
                hintStyle: GoogleFonts.inter(fontSize: 11, color: colorgrey),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(0)),
              ),
            ),
          ),
          sizeheight,
          Row(
            children: [
              const TextViewInter(
                title: "LOCATIONS",
                fontcolor: primaryColor,
                fontsize: 15,
                fontweight: FontWeight.bold,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: GestureDetector(
                  onTap: () {
                    notifyUserText(context,
                        "Provide more description about the location (120 character)\n\nLocation details should be exact.");
                  },
                  child: const Icon(
                    Icons.help_outline,
                    color: primaryColor,
                    size: 18,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15.0,
          ),
          SizedBox(
            width: widthsize * 0.89,
            child: TextFormField(
              controller: widget.cont3,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.location_on_outlined,
                  color: primaryColor,
                ),
                labelText: widget.locationtitle,
                labelStyle: GoogleFonts.inter(fontSize: 12, color: colorgrey),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(0)),
              ),
            ),
          ),
          sizeheight,
          SizedBox(
            width: widthsize * 0.89,
            height: 5 * 25.0,
            child: TextFormField(
              controller: widget.cont4,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              maxLength: 220,
              maxLines: 30,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              decoration: InputDecoration(
                hintText:
                    'Provide details about the location you found/lost the item ',
                hintStyle: GoogleFonts.inter(fontSize: 11, color: colorgrey),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(0)),
              ),
            ),
          ),
          sizeheight,
          Row(
            children: [
              const TextViewInter(
                title: "DESCRIPTIONS",
                fontcolor: primaryColor,
                fontsize: 15,
                fontweight: FontWeight.bold,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: GestureDetector(
                  onTap: () {
                    notifyUserText(context,
                        "Provide more details about the item (120 character)\n\nMake sure to describe the item exactly what it looks like.");
                  },
                  child: const Icon(
                    Icons.help_outline,
                    color: primaryColor,
                    size: 18,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15.0,
          ),
          SizedBox(
            width: widthsize * 0.89,
            height: 5 * 25.0,
            child: TextFormField(
              controller: widget.cont5,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              maxLength: 550,
              maxLines: 40,
              onSaved: (newValue) => widget.cont5.text = newValue!,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              decoration: InputDecoration(
                hintText: 'Describe the item you found/lost ',
                hintStyle: GoogleFonts.inter(fontSize: 11, color: colorgrey),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(0)),
              ),
            ),
          ),
          sizeheight,
          Row(
            children: [
              const TextViewInter(
                title: "CONTACTS",
                fontcolor: primaryColor,
                fontsize: 15,
                fontweight: FontWeight.bold,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: GestureDetector(
                  onTap: () {
                    notifyUserText(context,
                        "You can provide your contact number or social media account.");
                  },
                  child: const Icon(
                    Icons.help_outline,
                    color: primaryColor,
                    size: 18,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15.0,
          ),
          SizedBox(
            width: widthsize * 0.89,
            child: TextFormField(
              controller: widget.cont6,
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
          SizedBox(
            width: widthsize * 0.89,
            child: TextFormField(
              controller: widget.cont7,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.link_outlined,
                  color: primaryColor,
                ),
                labelText: 'Social media ',
                labelStyle: GoogleFonts.inter(fontSize: 12, color: colorgrey),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(0)),
              ),
            ),
          ),
          const SizedBox(height: 29),
          Row(
            children: [
              const TextViewInter(
                title: "ITEMS",
                fontcolor: primaryColor,
                fontsize: 15,
                fontweight: FontWeight.bold,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: GestureDetector(
                  onTap: () {
                    showdescriptionModal(context);
                  },
                  child: const Icon(
                    Icons.help_outline,
                    color: primaryColor,
                    size: 18,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15.0,
          ),
          SizedBox(
            width: widthsize * 0.89,
            child: TextFormField(
              controller: widget.cont8,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.description_outlined,
                  color: primaryColor,
                ),
                labelText: 'Model (optional)',
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
              controller: widget.cont9,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.description_outlined,
                  color: primaryColor,
                ),
                labelText: 'Brand (Optional) ',
                labelStyle: GoogleFonts.inter(fontSize: 12, color: colorgrey),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(0)),
              ),
            ),
          ),
          const SizedBox(height: 29),
          Row(
            children: [
              const TextViewInter(
                title: "OTHERS",
                fontcolor: primaryColor,
                fontsize: 15,
                fontweight: FontWeight.bold,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: GestureDetector(
                  onTap: () {
                    showdescriptionModal(context);
                  },
                  child: const Icon(
                    Icons.help_outline,
                    color: primaryColor,
                    size: 18,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15.0,
          ),
          SizedBox(
              width: widthsize * 0.89,
              child: TextFormField(
                controller: widget.cont10,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.description_outlined,
                    color: primaryColor,
                  ),
                  labelText: 'Distinguishing marks ',
                  labelStyle: GoogleFonts.inter(fontSize: 12, color: colorgrey),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0)),
                ),
              )),
          sizeheight,
          SizedBox(
            width: widthsize * 0.89,
            child: TextFormField(
              controller: widget.cont11,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.description_outlined,
                  color: primaryColor,
                ),
                labelText: 'Serial number (Optional) ',
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
