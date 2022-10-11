import 'package:lostfoundapp/mics/packages.dart';

class ClaimedItemModel {
  String? claimerID;
  String? claimername;
  String? claimerdepartment;
  String? postID;
  Timestamp? claimedDate;
  String? onwerprofileURl;
  String? claimerPhotoURL;
  String? phtoURL;
  String? userID;
  String? itemname;
  String? itemcolor;
  String? usermobileNum;
  String? userSocialMedia;
  String? location;
  String? locationDes;
  String? itemDes;
  String? foundlossDes;
  String? itemmodel;
  String? itembrand;
  String? itemMarks;
  String? itemserailNum;
  String? datelossfound;
  String? itemstatus;
  String? itemtype;
  String? itemsubtype;

  ClaimedItemModel({
    this.userID,
    this.itemname,
    this.itemcolor,
    this.usermobileNum,
    this.userSocialMedia,
    this.location,
    this.locationDes,
    this.itemDes,
    this.foundlossDes,
    this.itemmodel,
    this.itembrand,
    this.itemMarks,
    this.itemserailNum,
    this.datelossfound,
    this.itemstatus,
    this.itemtype,
    this.itemsubtype,
    this.claimerID,
    this.claimername,
    this.claimerdepartment,
    this.postID,
    this.claimedDate,
    this.onwerprofileURl,
    this.claimerPhotoURL,
    this.phtoURL,
  });

  factory ClaimedItemModel.fromDocument(map) {
    return ClaimedItemModel(
      userID: map['userID'],
      itemname: map['itemname'],
      itemcolor: map['itemcolor'],
      usermobileNum: map['usermobileNum'],
      userSocialMedia: map['userSocialMedia'],
      location: map['location'],
      locationDes: map['locationDes'],
      itemDes: map['itemDes'],
      foundlossDes: map['foundlossDes'],
      itemmodel: map['itemmodel'],
      itembrand: map['itembrand'],
      itemMarks: map['itemMarks'],
      itemserailNum: map['itemserailNum'],
      datelossfound: map['datelossfound'],
      itemstatus: map['itemstatus'],
      itemtype: map['itemtype'],
      itemsubtype: map['itemsubtype'],
      claimerID: map['claimerID'],
      claimername: map['claimername'],
      claimerdepartment: map['claimerdepartment'],
      postID: map['postID'],
      claimedDate: map['claimedDate'],
      onwerprofileURl: map['onwerprofileURl'],
      claimerPhotoURL: map['claimerPhotoURL'],
      phtoURL: map['phtoURL'],
    );
  }

  Map<String, dynamic> tomap() {
    return {
      'userID': userID,
      'itemname': itemname,
      'itemcolor': itemcolor,
      'usermobileNum': usermobileNum,
      'userSocialMedia': userSocialMedia,
      'location': location,
      'locationDes': locationDes,
      'itemDes': itemDes,
      'foundlossDes': foundlossDes,
      'itemmodel': itemmodel,
      'itembrand': itembrand,
      'itemMarks': itemMarks,
      'itemserailNum': itemserailNum,
      'datelossfound': datelossfound,
      'itemstatus': itemstatus,
      'itemtype': itemtype,
      'itemsubtype': itemsubtype,
      'claimerID': claimerID,
      'claimername': claimername,
      'claimerdepartment': claimerdepartment,
      'postID': postID,
      'claimedDate': DateTime.now(),
      'onwerprofileURl': onwerprofileURl,
      'claimerPhotoURL': claimerPhotoURL,
      'phtoURL': phtoURL,
    };
  }
}
