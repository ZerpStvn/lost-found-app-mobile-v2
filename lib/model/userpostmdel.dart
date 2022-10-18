import 'package:lostfoundapp/mics/packages.dart';

class UserPostModel {
  String? postID;
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
  String? phtoURL;
  String? datelossfound;
  String? itemstatus;
  String? itemtype;
  Timestamp? dateposted;
  String? userpostername;
  String? userposterPhourl;

  UserPostModel({
    this.postID,
    this.userID,
    this.itemname,
    this.itemcolor,
    this.datelossfound,
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
    this.phtoURL,
    this.itemstatus,
    this.itemtype,
    this.dateposted,
    this.userposterPhourl,
    this.userpostername,
  });

  factory UserPostModel.fromDocuments(map) {
    return UserPostModel(
      postID: map['postID'],
      userID: map['userID'],
      itemname: map['itemname'],
      datelossfound: map['datelossfound'],
      userposterPhourl: map['userposterPhourl'],
      userpostername: map['userpostername'],
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
      itemtype: map['itemtype'],
      itemserailNum: map['itemserailNum'],
      phtoURL: map['phtoURL'],
      itemstatus: map['itemstatus'],
      dateposted: map['dateposted'],
    );
  }

  Map<String, dynamic> tomap() {
    return {
      'postID': postID,
      'userID': userID,
      'itemname': itemname,
      'userpostername': userpostername,
      'userposterPhourl': userposterPhourl,
      'itemcolor': itemcolor,
      'datelossfound': datelossfound,
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
      'phtoURL': phtoURL,
      'itemstatus': itemstatus,
      'itemtype': itemtype,
      'dateposted': DateTime.now(),
    };
  }
}
