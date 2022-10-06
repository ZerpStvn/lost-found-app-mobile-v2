import 'package:flutter/services.dart';
import 'package:lostfoundapp/mics/packages.dart';

final TextEditingController reqitemtitlecon = TextEditingController();
final TextEditingController reqfounddescriptionrcon = TextEditingController();
final TextEditingController reqitemcolorcon = TextEditingController();
final TextEditingController reqlocationcon = TextEditingController();
final TextEditingController reqlocationDescriptioncon = TextEditingController();
final TextEditingController reqitemdescriptioncon = TextEditingController();
final TextEditingController reqmobilenumbercon = TextEditingController();
final TextEditingController reqsocialmediacon = TextEditingController();
final TextEditingController reqmodelcon = TextEditingController();
final TextEditingController reqbrandcon = TextEditingController();
final TextEditingController reqmarkingscon = TextEditingController();
final TextEditingController messagecon = TextEditingController();
final TextEditingController requsermamecon = TextEditingController();
final TextEditingController requserIDcon = TextEditingController();
final TextEditingController requserDeptcon = TextEditingController();

//
final requsername = TextFormField(
  controller: requsermamecon,
  keyboardType: TextInputType.name,
  textInputAction: TextInputAction.next,
  decoration: InputDecoration(
    prefixIcon: const Icon(
      Icons.person_outline,
      color: primaryColor,
    ),
    labelText: 'Name ',
    labelStyle: GoogleFonts.inter(fontSize: 12, color: colorgrey),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(0)),
  ),
);
//
final reqDept = TextFormField(
  controller: requserDeptcon,
  keyboardType: TextInputType.name,
  textInputAction: TextInputAction.next,
  decoration: InputDecoration(
    prefixIcon: const Icon(
      Icons.school_outlined,
      color: primaryColor,
    ),
    labelText: 'Deparment ',
    labelStyle: GoogleFonts.inter(fontSize: 12, color: colorgrey),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(0)),
  ),
);
final requserID = TextFormField(
  controller: requserIDcon,
  keyboardType: TextInputType.number,
  textInputAction: TextInputAction.next,
  decoration: InputDecoration(
    prefixIcon: const Icon(
      Icons.school_outlined,
      color: primaryColor,
    ),
    labelText: 'School ID ',
    labelStyle: GoogleFonts.inter(fontSize: 12, color: colorgrey),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(0)),
  ),
);

final reqitemtitle = TextFormField(
  controller: reqitemtitlecon,
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
final reqfounlossdDescription = TextFormField(
  controller: reqfounddescriptionrcon,
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
final reqitemcolor = TextFormField(
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
final reqitemlocation = TextFormField(
  controller: reqlocationcon,
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
final reqitemlocationDescription = TextFormField(
  controller: reqlocationDescriptioncon,
  keyboardType: TextInputType.name,
  textInputAction: TextInputAction.next,
  maxLength: 120,
  maxLines: 30,
  maxLengthEnforcement: MaxLengthEnforcement.enforced,
  decoration: InputDecoration(
    hintText: 'Provide details about the location you found/loss the item ',
    hintStyle: GoogleFonts.inter(fontSize: 11, color: colorgrey),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(0)),
  ),
);

//itemDescription
final reqitemdescription = TextFormField(
  controller: reqitemdescriptioncon,
  keyboardType: TextInputType.name,
  textInputAction: TextInputAction.next,
  maxLength: 150,
  maxLines: 40,
  maxLengthEnforcement: MaxLengthEnforcement.enforced,
  decoration: InputDecoration(
    hintText: 'Describe the item you found/loss ',
    hintStyle: GoogleFonts.inter(fontSize: 11, color: colorgrey),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(0)),
  ),
);

//modelnumber
final reqmobilenumber = TextFormField(
  controller: reqmobilenumbercon,
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
final reqsocialmedia = TextFormField(
  controller: reqsocialmediacon,
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
final reqitemmodel = TextFormField(
  controller: reqmodelcon,
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
final reqitembrand = TextFormField(
  controller: reqbrandcon,
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
final reqmarkings = TextFormField(
  controller: reqmarkingscon,
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
final messagefield = TextFormField(
  controller: messagecon,
  keyboardType: TextInputType.name,
  textInputAction: TextInputAction.done,
  maxLength: 150,
  maxLines: 8,
  maxLengthEnforcement: MaxLengthEnforcement.enforced,
  decoration: InputDecoration(
    labelText: 'Leave a message ',
    labelStyle: GoogleFonts.inter(fontSize: 12, color: colorgrey),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(0)),
  ),
);
