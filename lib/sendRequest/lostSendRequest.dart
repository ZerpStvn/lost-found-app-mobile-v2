// ignore_for_file: file_names

import 'package:flutter/scheduler.dart';
import 'package:lostfoundapp/mics/packages.dart';

class LostItemRequestSender extends StatefulWidget {
  final UserPostModel userPostModel;
  const LostItemRequestSender(this.userPostModel, {super.key});

  @override
  State<LostItemRequestSender> createState() => _LostItemRequestSenderState();
}

class _LostItemRequestSenderState extends State<LostItemRequestSender> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    final String colorValue = "${widget.userPostModel.itemcolor}";
    final int value = int.parse(colorValue);
    final Color colorval = Color(value);
    final sizewidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                      decoration: widget.userPostModel.phtoURL == "empty"
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
                                      '${widget.userPostModel.phtoURL}'),
                                  fit: BoxFit.cover),
                              color: colorblack,
                              borderRadius: const BorderRadius.only(
                                  bottomRight: Radius.circular(30))),
                      child: widget.userPostModel.phtoURL == "empty"
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
                    TextView(
                      title: "${widget.userPostModel.itemname}",
                      fontsize: 23,
                      fontcolor: colorblack,
                      fontweight: FontWeight.bold,
                    ),
                    const TextView(
                      title: "Item name ",
                      fontcolor: colorgrey,
                      fontweight: FontWeight.bold,
                      fontsize: 14,
                    ),
                    const SizedBox(
                      height: 20,
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
                          title: "${widget.userPostModel.location} ",
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
                      height: 30,
                    ),
                    const TextView(
                      title: "Description ",
                      fontcolor: colorgrey,
                      fontweight: FontWeight.bold,
                      fontsize: 14,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: sizewidth * 0.86,
                      child: ReadMoreText(
                        "${widget.userPostModel.foundlossDes} ",
                        colorClickableText: primaryColor,
                        textAlign: TextAlign.justify,
                        style:
                            GoogleFonts.inter(fontSize: 15, color: colorblack),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 55,
              ),
              buildButton(context, sizewidth)
            ],
          ),
        ),
      ),
    );
  }

  Widget buildButton(BuildContext context, double sizewidth) {
    if (widget.userPostModel.userID == user!.uid) {
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
                      SchedulerBinding.instance
                          .addPostFrameCallback((timeStamp) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    EditTextPostLost(widget.userPostModel)));
                      });
                    },
                    child: const TextViewInter(
                        title: "EDIT",
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
                    onPressed: () {
                      deletedata();
                    },
                    child: const TextViewInter(
                        title: "DELETE",
                        fontsize: 14,
                        fontweight: FontWeight.bold,
                        fontcolor: colorWhite)),
              ),
            ),
          ],
        ),
      ));
    } else {
      return Center(
        child: SizedBox(
          width: sizewidth * 0.88,
          height: 50,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 28, 218, 44)),
              onPressed: () {
                onuserReq == false
                    ? SchedulerBinding.instance
                        .scheduleFrameCallback((timeStamp) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    SendRequest(widget.userPostModel)));
                      })
                    : snackBarScreen(
                        context, "You can only send a request once");
              },
              child: const TextViewInter(
                  title: "SEND REQUEST",
                  fontsize: 14,
                  fontweight: FontWeight.bold,
                  fontcolor: colorWhite)),
        ),
      );
    }
  }

  //using snackbar show the data message==//
  //using snackbar also to show on message update
  snackBarScreen(BuildContext context, String title) {
    final snack = SnackBar(
      content: Text(
        title,
        style: GoogleFonts.inter(fontSize: 14, color: colorWhite),
      ),
      backgroundColor: colorblack,
    );
    ScaffoldMessenger.of(context).showSnackBar(snack);
  }
  //====================================//

  //
  //==========deleting a userpost()=========//
  Future deletedata() async {
    final snack = snackBarScreen(context, "Deleting");
    final snackdone = snackBarScreen(context, "Post deleted");
    final navigator = Navigator.of(context);
    await FirebaseFirestore.instance
        .collection('lost_items')
        .doc(user!.uid)
        .collection('litems')
        .doc(widget.userPostModel.postID)
        .delete()
        .then((value) => debugPrint("data deleted"))
        .catchError((err) => debugPrint("Field to delete data"));
    await FirebaseFirestore.instance
        .collection('users_Post')
        .doc(widget.userPostModel.postID)
        .delete();
    snack;
    navigator.pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const SliverHomePage()),
        (route) => false);
    snackdone;
  }

  bool onuserReq = false;
  Requesmodel reqmodel = Requesmodel();
  Future getdatarequest() async {
    DocumentSnapshot data = await FirebaseFirestore.instance
        .collection('request_feeds')
        .doc(userlogin!.useruid)
        .collection('Activityfeed')
        .doc(widget.userPostModel.postID)
        .get();
    if (!data.exists) {
      return null;
    }
    reqmodel = Requesmodel.fromDocuments(data);
    if (reqmodel.reqpostID == widget.userPostModel.postID) {
      setState(() {
        onuserReq = true;
      });
      debugPrint("$onuserReq");
    }
  }

  @override
  void initState() {
    getdatarequest();
    super.initState();
  }
}
