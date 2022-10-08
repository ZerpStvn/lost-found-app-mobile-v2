import 'package:lostfoundapp/mics/packages.dart';

class ChatConvo {
  String? userID;
  String? message;
  Timestamp? timesent;

  ChatConvo({
    this.userID,
    this.message,
    this.timesent,
  });
  factory ChatConvo.fromDoCument(map) {
    return ChatConvo(
      userID: map['userID'],
      message: map['message'],
      timesent: map['timesent'],
    );
  }
  Map<String, dynamic> tomap() {
    return {
      'userID': userID,
      'message': message,
      'timesent': DateTime.now(),
    };
  }
}
