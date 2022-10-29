import 'package:lostfoundapp/mics/packages.dart';

class ChatRoomModel {
  String? sentbyID;
  String? sentToID;
  String? sentbyname;
  String? sentToname;
  String? sentToprofileURL;
  String? sentbyprofileURL;
  String? itemname;
  String? itemphotoURL;
  String? itemID;
  Timestamp? datecreated;
  String? status;
  String? chatRoomID;
  String? devTokenby;
  String? devTokenTo;

  ChatRoomModel({
    this.chatRoomID,
    this.sentbyID,
    this.devTokenby,
    this.devTokenTo,
    this.sentToID,
    this.sentbyname,
    this.sentToname,
    this.sentToprofileURL,
    this.sentbyprofileURL,
    this.itemname,
    this.itemphotoURL,
    this.itemID,
    this.datecreated,
    this.status,
  });

  factory ChatRoomModel.fromDocument(map) {
    return ChatRoomModel(
      devTokenby: map['devTokenby'],
      devTokenTo: map['devTokenTo'],
      chatRoomID: map['chatRoomID'],
      sentbyID: map['sentbyID'],
      sentToID: map['sentToID'],
      sentbyname: map['sentbyname'],
      sentToname: map['sentToname'],
      sentToprofileURL: map['sentToprofileURL'],
      sentbyprofileURL: map['sentbyprofileURL'],
      itemname: map['itemname'],
      status: map['status'],
      itemphotoURL: map['itemphotoURL'],
      itemID: map['itemID'],
      datecreated: map['datecreated'],
    );
  }
  Map<String, dynamic> tomap() {
    return {
      'devTokenby': devTokenby,
      'devTokenTo': devTokenTo,
      'chatRoomID': chatRoomID,
      'sentbyID': sentbyID,
      'sentToID': sentToID,
      'sentbyname': sentbyname,
      'sentToname': sentToname,
      'status': status,
      'sentToprofileURL': sentToprofileURL,
      'sentbyprofileURL': sentbyprofileURL,
      'itemname': itemname,
      'itemphotoURL': itemphotoURL,
      'itemID': itemID,
      'datecreated': DateTime.now(),
    };
  }
}
