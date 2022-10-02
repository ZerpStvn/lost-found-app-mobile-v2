import 'package:flutter/services.dart';
import 'package:lostfoundapp/mics/packages.dart';

final TextEditingController itemtitlecon = TextEditingController();
final TextEditingController founddescriptionrcon = TextEditingController();
final TextEditingController itemcolorcon = TextEditingController();
final TextEditingController locationcon = TextEditingController();
final TextEditingController locationDescriptioncon = TextEditingController();
final TextEditingController itemdescriptioncon = TextEditingController();
final TextEditingController mobilenumbercon = TextEditingController();
final TextEditingController socialmediacon = TextEditingController();
final TextEditingController modelcon = TextEditingController();
final TextEditingController brandcon = TextEditingController();
final TextEditingController markingscon = TextEditingController();
final TextEditingController seiralnumcon = TextEditingController();

final itemtitle = TextFormField(
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
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(0)),
  ),
);
//foundDes
final founlossdDescription = TextFormField(
  controller: founddescriptionrcon,
  keyboardType: TextInputType.name,
  textInputAction: TextInputAction.next,
  maxLength: 120,
  maxLengthEnforcement: MaxLengthEnforcement.enforced,
  maxLines: 30,
  decoration: InputDecoration(
    hintText: "Provide description how you found/loss the Item",
    hintStyle: GoogleFonts.inter(fontSize: 11, color: colorgrey),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(0)),
  ),
);
//color
final itemcolor = TextFormField(
  controller: itemcolorcon,
  keyboardType: TextInputType.name,
  textInputAction: TextInputAction.next,
  decoration: InputDecoration(
    prefixIcon: const Icon(
      Icons.color_lens_outlined,
      color: primaryColor,
    ),
    hintText: "item Color",
    hintStyle: GoogleFonts.inter(fontSize: 12, color: colorgrey),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(0)),
  ),
);

//location
final itemlocation = TextFormField(
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
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(0)),
  ),
);

//location
final itemlocationDescription = TextFormField(
  controller: locationDescriptioncon,
  keyboardType: TextInputType.name,
  textInputAction: TextInputAction.next,
  maxLength: 120,
  maxLines: 30,
  maxLengthEnforcement: MaxLengthEnforcement.enforced,
  decoration: InputDecoration(
    hintText: 'Provide details about the location you found/loss the item ',
    labelStyle: GoogleFonts.inter(fontSize: 11, color: colorgrey),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(0)),
  ),
);

//itemDescription
final itemdescription = TextFormField(
  controller: itemdescriptioncon,
  keyboardType: TextInputType.name,
  textInputAction: TextInputAction.next,
  maxLength: 150,
  maxLines: 40,
  maxLengthEnforcement: MaxLengthEnforcement.enforced,
  decoration: InputDecoration(
    hintText: 'Describe the item you found/loss ',
    labelStyle: GoogleFonts.inter(fontSize: 11, color: colorgrey),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(0)),
  ),
);

//modelnumber
final mobilenumber = TextFormField(
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
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(0)),
  ),
);

//socialmedia
final socialmedia = TextFormField(
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
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(0)),
  ),
);

//model
final itemmodel = TextFormField(
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
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(0)),
  ),
);

//brand
final itembrand = TextFormField(
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
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(0)),
  ),
);

//markinds
final markings = TextFormField(
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
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(0)),
  ),
);
//seria;
final serial = TextFormField(
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
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(0)),
  ),
);
