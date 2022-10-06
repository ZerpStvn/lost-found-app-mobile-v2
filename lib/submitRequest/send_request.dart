import 'package:flutter/scheduler.dart';
import 'package:lostfoundapp/mics/packages.dart';
import 'package:lostfoundapp/model/user_requestmodel.dart';
import 'package:lostfoundapp/submitRequest/submitform.dart';

class SendRequest extends StatefulWidget {
  final UserPostModel postmodel;
  const SendRequest(this.postmodel, {super.key});

  @override
  State<SendRequest> createState() => _SendRequestState();
}

class _SendRequestState extends State<SendRequest> {
  getuser() {
    SchedulerBinding.instance.scheduleFrameCallback((timeStamp) {
      requsermamecon.text = "${userlogin!.username}";
      requserDeptcon.text = "${userlogin!.schoolDept}";
      requserIDcon.text = "${userlogin!.schoolID}";
    });
  }

  @override
  void initState() {
    getuser();
    super.initState();
  }

  @override
  void dispose() {
    getuser();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final widthsize = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: onwillPop,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      width: widthsize,
                      height: 230.0,
                      decoration: widget.postmodel.phtoURL == "empty"
                          ? const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("assets/background_green"),
                                  fit: BoxFit.cover),
                            )
                          : BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                      "${widget.postmodel.phtoURL}"),
                                  fit: BoxFit.cover),
                            ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      TextView(
                        title: "${widget.postmodel.itemname}",
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
                      SizedBox(
                        width: 90,
                        child: AutoSizeText(
                          "${widget.postmodel.postID}",
                          maxLines: 1,
                          style: GoogleFonts.montserrat(
                              fontSize: 14, color: colorblack),
                        ),
                      ),
                      const TextView(
                        title: "Reference ID",
                        fontcolor: colorgrey,
                        fontweight: FontWeight.bold,
                        fontsize: 14,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
                formpage(context),
                const SizedBox(
                  height: 23,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 18.0),
                  child: Center(
                    child: SizedBox(
                      width: widthsize * 0.89,
                      height: 50,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                            ),
                            onPressed: () {
                              handlesubmission();
                            },
                            child: const Center(
                              child: TextViewInter(
                                title: "SEND REQUEST",
                                fontsize: 14,
                                fontcolor: colorWhite,
                                fontweight: FontWeight.bold,
                              ),
                            )),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget formpage(BuildContext context) {
    if (mounted) {
      return const RequestForm();
    } else {
      dispose();
      debugPrint("$dispose()");
      return Container();
    }
  }

  //using snackbar show the data message==//
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

  Future handlesendRequest() async {
    final snack = snackBarScreen(context, "Request sent");
    //final navigator = Navigator.of(context);
    final user = FirebaseAuth.instance.currentUser;
    Requesmodel reqmodel = Requesmodel();

    reqmodel.reqpostID = widget.postmodel.postID;
    reqmodel.requserID = user!.uid;
    reqmodel.reqitemname = reqitemtitlecon.text;
    reqmodel.reqitemcolor = "";
    reqmodel.requsermobileNum = reqmobilenumbercon.text;
    reqmodel.reqlocation = reqlocationcon.text;
    reqmodel.reqlocationDes = reqlocationDescriptioncon.text;
    reqmodel.reqitemDes = reqitemdescriptioncon.text;
    reqmodel.reqfoundlossDes = reqfounddescriptionrcon.text;
    reqmodel.reqitemmodel = reqmodelcon.text;
    reqmodel.reqdatelossfound = datetimepicked;
    reqmodel.reqitembrand = reqbrandcon.text;
    reqmodel.reqitemMarks = reqmarkingscon.text;
    reqmodel.reqitemserailNum = messagecon.text;
    reqmodel.reqphtoURL = widget.postmodel.phtoURL;
    reqmodel.reqitemstatus = "Send_Request";
    reqmodel.reqType = "Send Request";
    reqmodel.reqitemtype = "";
    reqmodel.reqitemsubtype = "";
    reqmodel.requserPhotourl = userlogin!.profileURL;
    reqmodel.requserpostername = widget.postmodel.userpostername;
    reqmodel.userreqID = widget.postmodel.userID;
    reqmodel.nmame = requsermamecon.text;
    reqmodel.ndept = requserDeptcon.text;
    reqmodel.scholid = requserIDcon.text;

    await FirebaseFirestore.instance
        .collection('feeds')
        .doc(user.uid)
        .collection('Activityfeed')
        .add(reqmodel.tomap())
        .then((value) => debugPrint("Request Submitted"))
        .onError(
            (error, stackTrace) => (value) => debugPrint("Request Submitted"));

    snack;
    handlecleartext();
  }

  handlecleartext() {
    datetimepicked = null;
    reqitemtitlecon.clear();
    reqfounddescriptionrcon.clear();
    reqitemcolorcon.clear();
    reqlocationcon.clear();
    reqlocationDescriptioncon.clear();
    reqitemdescriptioncon.clear();
    reqmobilenumbercon.clear();
    reqsocialmediacon.clear();
    reqmodelcon.clear();
    reqbrandcon.clear();
    reqmarkingscon.clear();
    messagecon.clear();
    requsermamecon.clear();
    requserIDcon.clear();
    requserDeptcon.clear();
  }

  handlesubmission() {
    if (reqitemtitlecon.text.isEmpty ||
        reqlocationcon.text.isEmpty ||
        reqlocationDescriptioncon.text.isEmpty ||
        reqitemdescriptioncon.text.isEmpty ||
        reqfounddescriptionrcon.text.isEmpty ||
        datetimepicked == null ||
        reqmarkingscon.text.isEmpty ||
        messagecon.text.isEmpty ||
        requsermamecon.text.isEmpty ||
        requserDeptcon.text.isEmpty ||
        requserIDcon.text.isEmpty) {
      snackBarScreen(context, "Please fill out all the information");
    } else {
      handlesendRequest();
    }
  }

  Future<bool> onwillPop() async {
    return (await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const TextView(
              title: "Exit",
              fontsize: 18,
              fontcolor: primaryColor,
              fontweight: FontWeight.bold,
            ),
            content: const TextView(
              title: "Are you sure you want to exit this page? ",
              fontsize: 15,
              fontcolor: primaryColor,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
                child: const TextView(
                  title: "No",
                  fontsize: 18,
                  fontcolor: primaryColor,
                  fontweight: FontWeight.w500,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                  SchedulerBinding.instance.scheduleFrameCallback((timeStamp) {
                    Navigator.pop(context);
                    handlecleartext();
                  });
                },
                child: const TextView(
                  title: "Yes",
                  fontsize: 18,
                  fontcolor: primaryColor,
                  fontweight: FontWeight.w500,
                ),
              ),
            ],
          );
        }));
  }
}
