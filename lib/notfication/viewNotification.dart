// ignore_for_file: file_names
import 'dart:convert';

import 'package:lostfoundapp/mics/packages.dart';
import 'package:lostfoundapp/model/chatroommodel.dart';
import 'package:http/http.dart' as http;

class ViewNotification extends StatefulWidget {
  final Requesmodel requesmodel;
  const ViewNotification(this.requesmodel, {super.key});

  @override
  State<ViewNotification> createState() => _ViewNotificationState();
}

class _ViewNotificationState extends State<ViewNotification> {
  void sendPushMessage(String? token, String body, String title) async {
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              'key=AAAAewoqbb8:APA91bF2szMqr73_gPqYlRWGVBJDSGXuZGrdh0zWyO0E3SyaVxlKNbYieZygDtJ9Lj7whiXevnI9QaslYf_oFfTaGJN3tj2UO4F9aE2h-Yt1Sppfs6-Y4zgby0seAlqsa7nrqVJY3Bc4',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{'body': body, 'title': title},
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done'
            },
            "to": token,
          },
        ),
      );
    } catch (e) {
      debugPrint("error push notification");
    }
  }

  @override
  Widget build(BuildContext context) {
    final sizewidth = MediaQuery.of(context).size.width;
    final String colorValue = "${widget.requesmodel.reqitemcolor}";
    final int value = int.parse(colorValue);
    final Color colorval = Color(value);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 280,
              child: Stack(
                children: [
                  Container(
                    height: 280,
                    width: sizewidth,
                    decoration: widget.requesmodel.reqphtoURL == "empty"
                        ? const BoxDecoration(
                            image: DecorationImage(
                                image:
                                    AssetImage('assets/background_green.jpg'),
                                fit: BoxFit.cover),
                            color: colorblack,
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(30)))
                        : BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                    '${widget.requesmodel.reqphtoURL}'),
                                fit: BoxFit.cover),
                            color: colorblack,
                            borderRadius: const BorderRadius.only(
                                bottomRight: Radius.circular(30))),
                    child: widget.requesmodel.reqphtoURL == "empty"
                        ? const Center(
                            child: TextView(
                              title: "No image",
                              fontsize: 14,
                              fontcolor: colorWhite,
                              fontweight: FontWeight.bold,
                            ),
                          )
                        : Container(),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 90,
                            child: AutoSizeText(
                              "${widget.requesmodel.reqitemname}",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.montserrat(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: colorblack),
                            ),
                          ),
                          const TextView(
                            title: "Item name ",
                            fontcolor: colorgrey,
                            fontweight: FontWeight.bold,
                            fontsize: 14,
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 90,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: primaryColor,
                              image: DecorationImage(
                                  image: NetworkImage(
                                      "${widget.requesmodel.requserPhotourl}"),
                                  fit: BoxFit.cover),
                            ),
                          ),
                          SizedBox(
                            width: 140,
                            child: AutoSizeText(
                              "${widget.requesmodel.nmame}",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.montserrat(
                                  fontSize: 14, color: colorblack),
                            ),
                          ),
                          TextView(
                            title: widget.requesmodel.reqitemstatus == "Accept"
                                ? "Request accepted"
                                : widget.requesmodel.reqitemstatus == "Canceled"
                                    ? "Request Rejected"
                                    : "Sent you a Request ",
                            fontcolor: colorgrey,
                            fontweight: FontWeight.bold,
                            fontsize: 14,
                          ),
                        ],
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        height: 30,
                        width: 30,
                        color: colorval,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Container(
                        height: 30,
                        width: 30,
                        color: colorval,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Container(
                        height: 30,
                        width: 30,
                        color: colorval,
                      ),
                    ],
                  ),
                  const TextView(
                    title: "Item color ",
                    fontcolor: colorgrey,
                    fontweight: FontWeight.bold,
                    fontsize: 14,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: primaryColor,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      TextView(
                        title: "${widget.requesmodel.reqlocation} ",
                        fontcolor: colorblack,
                        fontweight: FontWeight.bold,
                        fontsize: 14,
                      ),
                    ],
                  ),
                  const TextView(
                    title: "Item location ",
                    fontcolor: colorgrey,
                    fontweight: FontWeight.bold,
                    fontsize: 14,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextView(
                    title: "${widget.requesmodel.reqdatelossfound} ",
                    fontcolor: colorgrey,
                    fontweight: FontWeight.normal,
                    fontsize: 14,
                  ),
                  const TextView(
                    title: "Date Time",
                    fontcolor: colorgrey,
                    fontweight: FontWeight.bold,
                    fontsize: 14,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const TextView(
                    title: "Item Description ",
                    fontcolor: colorgrey,
                    fontweight: FontWeight.bold,
                    fontsize: 14,
                  ),
                  SizedBox(
                    width: sizewidth * 0.86,
                    child: ReadMoreText(
                      "${widget.requesmodel.reqitemDes} ",
                      colorClickableText: primaryColor,
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.inter(fontSize: 15, color: colorblack),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const TextView(
                    title: "location Description ",
                    fontcolor: colorgrey,
                    fontweight: FontWeight.bold,
                    fontsize: 14,
                  ),
                  SizedBox(
                    width: sizewidth * 0.86,
                    child: ReadMoreText(
                      "${widget.requesmodel.reqlocationDes} ",
                      colorClickableText: primaryColor,
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.inter(fontSize: 15, color: colorblack),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const TextView(
                    title: "Description ",
                    fontcolor: colorgrey,
                    fontweight: FontWeight.bold,
                    fontsize: 14,
                  ),
                  SizedBox(
                    width: sizewidth * 0.86,
                    child: ReadMoreText(
                      "${widget.requesmodel.reqfoundlossDes} ",
                      colorClickableText: primaryColor,
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.inter(fontSize: 15, color: colorblack),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: sizewidth * 0.86,
                    child: ReadMoreText(
                      "${widget.requesmodel.reqitemMarks} ",
                      colorClickableText: primaryColor,
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.inter(fontSize: 15, color: colorblack),
                    ),
                  ),
                  const TextView(
                    title: "Distinguishing markings",
                    fontcolor: colorgrey,
                    fontweight: FontWeight.bold,
                    fontsize: 14,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const TextView(
                    title: "Message ",
                    fontcolor: colorgrey,
                    fontweight: FontWeight.bold,
                    fontsize: 14,
                  ),
                  SizedBox(
                    width: sizewidth * 0.86,
                    child: ReadMoreText(
                      "${widget.requesmodel.reqitemserailNum} ",
                      colorClickableText: primaryColor,
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.inter(fontSize: 15, color: colorblack),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            if (widget.requesmodel.reqitemmodel == "" ||
                widget.requesmodel.reqitembrand == "")
              Container()
            else
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        TextView(
                          title: "${widget.requesmodel.reqitemmodel}",
                          fontsize: 14,
                          fontcolor: colorblack,
                        ),
                        const SizedBox(
                          width: 13,
                        ),
                        TextView(
                          title: "${widget.requesmodel.reqitembrand}",
                          fontsize: 14,
                          fontcolor: colorblack,
                        ),
                      ],
                    ),
                    const TextView(
                      title: "Model/Brand ",
                      fontcolor: colorgrey,
                      fontweight: FontWeight.bold,
                      fontsize: 14,
                    ),
                  ],
                ),
              ),
            const SizedBox(
              height: 20,
            ),
            buildButton(context, sizewidth)
          ],
        ),
      ),
    );
  }

  Widget buildButton(BuildContext context, double sizewidth) {
    if (widget.requesmodel.reqitemstatus == "Send_Request") {
      return Center(
          child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: SizedBox(
                width: sizewidth,
                height: 50,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 28, 218, 44)),
                    onPressed: () {
                      handleRequestCancel();
                    },
                    child: const TextView(
                        title: "CANCEL",
                        fontsize: 14,
                        fontweight: FontWeight.bold,
                        fontcolor: colorWhite)),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 1,
              child: SizedBox(
                width: sizewidth,
                height: 50,
                child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: primaryColor),
                    onPressed: handleSubmit,
                    child: const TextView(
                        title: "ACCEPT",
                        fontsize: 14,
                        fontweight: FontWeight.bold,
                        fontcolor: colorWhite)),
              ),
            ),
          ],
        ),
      ));
    } else {
      return Padding(
        padding: const EdgeInsets.only(bottom: 12.0),
        child: Center(
          child: SizedBox(
            width: sizewidth * 0.88,
            height: 50,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 28, 218, 44)),
                onPressed: () {},
                child: TextView(
                    title: widget.requesmodel.reqitemstatus == "Accept"
                        ? "ACCEPTED"
                        : "CANCELED",
                    fontsize: 14,
                    fontweight: FontWeight.bold,
                    fontcolor: colorWhite)),
          ),
        ),
      );
    }
  }

  final user = FirebaseAuth.instance.currentUser;
  Requesmodel reqmodel = Requesmodel();
  ChatRoomModel chat = ChatRoomModel();

  handleAcceptRequest() async {
    reqmodel.reqpostID = widget.requesmodel.reqpostID;
    reqmodel.requserID = widget.requesmodel.requserID;
    reqmodel.reqitemname = widget.requesmodel.itemname;
    reqmodel.reqitemcolor = "";
    reqmodel.requsermobileNum = widget.requesmodel.requsermobileNum;
    reqmodel.reqlocation = widget.requesmodel.reqlocation;
    reqmodel.reqlocationDes = widget.requesmodel.reqlocationDes;
    reqmodel.reqitemDes = widget.requesmodel.reqitemDes;
    reqmodel.reqfoundlossDes = widget.requesmodel.reqfoundlossDes;
    reqmodel.reqitemmodel = widget.requesmodel.reqitemmodel;
    reqmodel.reqdatelossfound = widget.requesmodel.reqdatelossfound;
    reqmodel.reqitembrand = widget.requesmodel.reqitembrand;
    reqmodel.reqitemMarks = widget.requesmodel.reqitemMarks;
    reqmodel.reqitemserailNum = widget.requesmodel.reqitemserailNum;
    reqmodel.reqphtoURL = widget.requesmodel.reqphtoURL;
    reqmodel.reqitemstatus = "Accept";
    reqmodel.reqType = "Request accepted";
    reqmodel.reqitemtype = "";
    reqmodel.reqitemsubtype = "";
    reqmodel.requserPhotourl = widget.requesmodel.requserPhotourl;
    reqmodel.requserpostername = widget.requesmodel.requserpostername;
    reqmodel.posteruserID = widget.requesmodel.posteruserID;
    reqmodel.nmame = widget.requesmodel.nmame;
    reqmodel.ndept = widget.requesmodel.ndept;
    reqmodel.scholid = widget.requesmodel.scholid;
    reqmodel.useronwerphotopostUrl = widget.requesmodel.useronwerphotopostUrl;

    await FirebaseFirestore.instance
        .collection('Request_Accept')
        .doc(user!.uid)
        .collection('Request')
        .add(reqmodel.tomap())
        .then((value) => debugPrint("request Accepted"));
  }

  handleUpdate() async {
    await FirebaseFirestore.instance
        .collection('request_feeds')
        .doc(widget.requesmodel.requserID)
        .collection('Activityfeed')
        .doc(widget.requesmodel.reqpostID)
        .update({
      "reqType": "Request accepted",
      "reqitemstatus": "Accept"
    }).then((value) => debugPrint("Accepted"));
  }

  handleChatRoom() async {
    final navigator = Navigator.of(context);
    chat.chatRoomID =
        "${widget.requesmodel.posteruserID}_${widget.requesmodel.requserID}";
    chat.sentbyID = user!.uid;
    chat.devTokenby = userlogin!.divToken;
    chat.devTokenTo = widget.requesmodel.divToken;
    chat.sentToID = widget.requesmodel.requserID;
    chat.sentToname = widget.requesmodel.nmame;
    chat.sentbyname = widget.requesmodel.requserpostername;
    chat.sentToprofileURL = widget.requesmodel.requserPhotourl;
    chat.sentbyprofileURL = widget.requesmodel.useronwerphotopostUrl;
    chat.itemID = widget.requesmodel.reqpostID;
    chat.itemname = widget.requesmodel.itemname;
    chat.itemphotoURL = widget.requesmodel.reqphtoURL;
    chat.status = "Unclaimed";

    await FirebaseFirestore.instance
        .collection("ChatRooms")
        .doc('${user!.uid}_${widget.requesmodel.requserID}')
        .set(chat.tomap())
        .then((value) => debugPrint("chatRoom created"));

    navigator
        .push(MaterialPageRoute(builder: (context) => const ChatRoomPage()));
  }

  handleRequestCancel() async {
    final navigator = Navigator.of(context);
    await FirebaseFirestore.instance
        .collection('request_feeds')
        .doc(widget.requesmodel.requserID)
        .collection('Activityfeed')
        .doc(widget.requesmodel.reqpostID)
        .update({"reqitemstatus": "Canceled"}).then(
            (value) => debugPrint("Request Canceled"));

    navigator.push(
        MaterialPageRoute(builder: (context) => const NotificationFeed()));
  }

  handleSubmit() {
    sendPushMessage(widget.requesmodel.divToken.toString(),
        "Accepted your request", userlogin!.username.toString());
    handleAcceptRequest();
    handleUpdate();
    handleChatRoom();
  }
}
