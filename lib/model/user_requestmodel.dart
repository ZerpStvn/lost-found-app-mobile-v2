import 'package:lostfoundapp/mics/packages.dart';

class Requesmodel {
  String? reqpostID;
  String? requserID;
  String? reqitemname;
  String? reqitemcolor;
  String? requsermobileNum;
  String? reqlocation;
  String? reqlocationDes;
  String? reqitemDes;
  String? reqfoundlossDes;
  String? reqitemmodel;
  String? reqitembrand;
  String? reqitemMarks;
  String? reqitemserailNum;
  String? reqphtoURL;
  String? reqdatelossfound;
  String? reqitemstatus;
  String? reqitemtype;
  String? reqitemsubtype;
  Timestamp? reqdateposted;
  String? requserpostername;
  String? requserPhotourl;
  String? userreqID;
  String? nmame;
  String? scholid;
  String? ndept;
  String? reqType;

  Requesmodel({
    this.reqType,
    this.nmame,
    this.scholid,
    this.ndept,
    this.userreqID,
    this.reqpostID,
    this.requserID,
    this.reqitemname,
    this.reqitemcolor,
    this.reqdatelossfound,
    this.requsermobileNum,
    this.reqlocation,
    this.reqlocationDes,
    this.reqitemDes,
    this.reqfoundlossDes,
    this.reqitemmodel,
    this.reqitembrand,
    this.reqitemMarks,
    this.reqitemserailNum,
    this.reqphtoURL,
    this.reqitemstatus,
    this.reqitemtype,
    this.reqitemsubtype,
    this.reqdateposted,
    this.requserPhotourl,
    this.requserpostername,
  });

  factory Requesmodel.fromDocuments(map) {
    return Requesmodel(
      nmame: map['nmame'],
      reqType:map['reqType'],
      scholid: map['scholid'],
      ndept: map['ndept'],
      userreqID: map['userreqID'],
      reqpostID: map['reqpostID'],
      requserID: map['requserID'],
      reqitemname: map['reqitemname'],
      reqdatelossfound: map['reqdatelossfound'],
      requserPhotourl: map['requserPhotourl'],
      requserpostername: map['requserpostername'],
      reqitemcolor: map['reqitemcolor'],
      requsermobileNum: map['requsermobileNum'],
      reqlocation: map['reqlocation'],
      reqlocationDes: map['reqlocationDes'],
      reqitemDes: map['reqitemDes'],
      reqfoundlossDes: map['reqfoundlossDes'],
      reqitemmodel: map['reqitemmodel'],
      reqitembrand: map['reqitembrand'],
      reqitemMarks: map['reqitemMarks'],
      reqitemtype: map['reqitemtype'],
      reqitemsubtype: map['reqitemsubtype'],
      reqitemserailNum: map['reqitemserailNum'],
      reqphtoURL: map['reqphtoURL'],
      reqitemstatus: map['reqitemstatus'],
      reqdateposted: map['reqdateposted'],
    );
  }

  Map<String, dynamic> tomap() {
    return {
      'nmame': nmame,
      'scholid': scholid,
      'ndept': ndept,
      'userreqID': userreqID,
      'reqpostID': reqpostID,
      'reqType':reqType,
      'requserID': requserID,
      'reqitemname': reqitemname,
      'requserpostername': requserpostername,
      'requserPhotourl': requserPhotourl,
      'reqitemcolor': reqitemcolor,
      'reqdatelossfound': reqdatelossfound,
      'requsermobileNum': requsermobileNum,
      'reqlocation': reqlocation,
      'reqlocationDes': reqlocationDes,
      'reqitemDes': reqitemDes,
      'reqfoundlossDes': reqfoundlossDes,
      'reqitemmodel': reqitemmodel,
      'reqitembrand': reqitembrand,
      'reqitemMarks': reqitemMarks,
      'reqitemserailNum': reqitemserailNum,
      'reqphtoURL': reqphtoURL,
      'reqitemstatus': reqitemstatus,
      'reqitemtype': reqitemtype,
      'reqitemsubtype': reqitemsubtype,
      'reqdateposted': DateTime.now(),
    };
  }
}
