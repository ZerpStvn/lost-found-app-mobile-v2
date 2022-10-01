class UserDataModel {
  String? username;
  String? schoolID;
  String? schoolDept;
  String? useremail;
  String? userpassword;
  String? useruid;
  String? useradd;
  String? userSchool;
  String? profileURL;

  UserDataModel({
    this.username,
    this.schoolID,
    this.schoolDept,
    this.useremail,
    this.userpassword,
    this.useruid,
    this.useradd,
    this.profileURL,
    this.userSchool,
  });

  factory UserDataModel.fromDocuments(map) {
    return UserDataModel(
      username: map['username'],
      schoolID: map['schoolID'],
      schoolDept: map['schoolDept'],
      useremail: map['useremail'],
      userpassword: map['userpassword'],
      useruid: map['useruid'],
      userSchool: map['userSchool'],
      profileURL: map['profileURL'],
      useradd: map['useradd'],
    );
  }
  Map<String, dynamic> tomap() {
    return {
      'username': username,
      'schoolID': schoolID,
      'profileURL': profileURL,
      'userSchool': userSchool,
      'schoolDept': schoolDept,
      'useremail': useremail,
      'userpassword': userpassword,
      'useruid': useruid,
      'useradd': useradd,
    };
  }
}
