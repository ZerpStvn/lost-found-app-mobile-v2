import 'package:flutter/services.dart';
import 'package:lostfoundapp/mics/packages.dart';

class EditPostFound extends StatelessWidget {
  final String inititle;
  const EditPostFound(this.inititle, {super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;
    const sizeheight = SizedBox(height: 10);
    return Padding(
      padding: const EdgeInsets.only(left: 14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
              initialValue: inititle,
              controller: itemtitlecon,
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
            width: size * 0.89,
            height: 5 * 25.0,
            child: TextFormField(
              controller: itemdescriptioncon,
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
              controller: locationcon,
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
              controller: locationDescriptioncon,
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
              controller: founddescriptionrcon,
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
              controller: mobilenumbercon,
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
            width: size * 0.89,
            child: TextFormField(
              controller: socialmediacon,
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
              controller: modelcon,
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
              controller: brandcon,
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
              controller: markingscon,
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
              controller: seiralnumcon,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.description_outlined,
                  color: primaryColor,
                ),
                labelText: 'Serialnumber(Optional) ',
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
