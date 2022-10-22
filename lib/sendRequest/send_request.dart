import 'package:flutter/scheduler.dart';
import 'package:lostfoundapp/mics/packages.dart';
import 'package:lostfoundapp/sendRequest/submitform.dart';

class SendRequest extends StatefulWidget {
  final UserPostModel postmodel;
  const SendRequest(this.postmodel, {super.key});

  @override
  State<SendRequest> createState() => _SendRequestState();
}

class _SendRequestState extends State<SendRequest> {
  final TextEditingController requsermamecon = TextEditingController();
  final TextEditingController requserIDcon = TextEditingController();
  final TextEditingController requserDeptcon = TextEditingController();
  final TextEditingController reqitemtitlecon = TextEditingController();
  final TextEditingController reqfounddescriptionrcon = TextEditingController();
  final TextEditingController reqlocationcon = TextEditingController();
  final TextEditingController reqcolorcon = TextEditingController();
  final TextEditingController reqlocationDescriptioncon =
      TextEditingController();
  final TextEditingController reqitemdescriptioncon = TextEditingController();
  final TextEditingController reqmobilenumbercon = TextEditingController();
  final TextEditingController reqmodelcon = TextEditingController();
  final TextEditingController reqbrandcon = TextEditingController();
  final TextEditingController reqmarkingscon = TextEditingController();
  final TextEditingController reqmessagecon = TextEditingController();
  final TextEditingController reqdatetimeController = TextEditingController();

  getuser() {
    SchedulerBinding.instance.scheduleFrameCallback((timeStamp) {
      requsermamecon.text = "${userlogin!.username}";
      requserDeptcon.text = "${userlogin!.schoolDept}";
      requserIDcon.text = "${userlogin!.schoolID}";
    });
  }

  @override
  void dispose() {
    requsermamecon.dispose();
    requserIDcon.dispose();
    requserDeptcon.dispose();
    reqitemtitlecon.dispose();
    reqfounddescriptionrcon.dispose();
    reqlocationcon.dispose();
    reqlocationDescriptioncon.dispose();
    reqitemdescriptioncon.dispose();
    reqmobilenumbercon.dispose();
    reqmodelcon.dispose();
    reqbrandcon.dispose();
    reqmarkingscon.dispose();
    reqcolorcon.dispose();
    reqmessagecon.dispose();
    reqdatetimeController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    getuser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final widthsize = MediaQuery.of(context).size.width;
    return Scaffold(
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
                                image:
                                    AssetImage("assets/background_green.jpg"),
                                fit: BoxFit.cover),
                          )
                        : BoxDecoration(
                            image: DecorationImage(
                                image:
                                    NetworkImage("${widget.postmodel.phtoURL}"),
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
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 120,
                              child: AutoSizeText(
                                "${widget.postmodel.itemname}",
                                maxLines: 1,
                                style: GoogleFonts.montserrat(
                                    fontSize: 14,
                                    color: colorblack,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const TextView(
                              title: "Item name ",
                              fontcolor: colorgrey,
                              fontweight: FontWeight.bold,
                              fontsize: 14,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            SizedBox(
                              width: 110,
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
                          ],
                        ),
                        const SizedBox(
                          width: 50,
                        ),
                        Column(
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: primaryColor,
                                image: DecorationImage(
                                    image: NetworkImage(
                                        "${widget.postmodel.userposterPhourl}"),
                                    fit: BoxFit.cover),
                              ),
                            ),
                            const TextView(
                              title: "posted by ",
                              fontcolor: colorgrey,
                              fontweight: FontWeight.bold,
                              fontsize: 14,
                            ),
                            SizedBox(
                              width: 140,
                              child: AutoSizeText(
                                "${widget.postmodel.userpostername}",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.montserrat(
                                    fontSize: 14, color: colorblack),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // IconButton(
              //     onPressed: () {
              //       debugPrint(reqcolorValue);
              //     },
              //     icon: const Icon(Icons.burst_mode)),
              const SizedBox(
                height: 15,
              ),
              RequestForm(
                  con1: requsermamecon,
                  con2: requserIDcon,
                  con3: requserDeptcon,
                  con4: reqitemtitlecon,
                  con5: reqdatetimeController,
                  con6: reqfounddescriptionrcon,
                  con7: reqlocationcon,
                  con8: reqlocationDescriptioncon,
                  con9: reqitemdescriptioncon,
                  con10: reqmobilenumbercon,
                  con12: reqmodelcon,
                  con13: reqbrandcon,
                  con14: reqmarkingscon,
                  con15: reqmessagecon,
                  con16: reqcolorcon,
                  date: "Date of loss/found"),
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
    );
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
    reqmodel.itemname = widget.postmodel.itemname;
    reqmodel.reqpostID = widget.postmodel.postID;
    reqmodel.requserID = user!.uid;
    reqmodel.reqitemname = reqitemtitlecon.text;
    reqmodel.reqitemcolor = reqcolorValue;
    reqmodel.requsermobileNum = reqmobilenumbercon.text;
    reqmodel.reqlocation = reqlocationcon.text;
    reqmodel.reqlocationDes = reqlocationDescriptioncon.text;
    reqmodel.reqitemDes = reqitemdescriptioncon.text;
    reqmodel.reqfoundlossDes = reqfounddescriptionrcon.text;
    reqmodel.reqitemmodel = reqmodelcon.text;
    reqmodel.reqdatelossfound = reqdatetimeController.text;
    reqmodel.reqitembrand = reqbrandcon.text;
    reqmodel.reqitemMarks = reqmarkingscon.text;
    reqmodel.reqitemserailNum = reqmessagecon.text;
    reqmodel.reqphtoURL = widget.postmodel.phtoURL;
    reqmodel.reqitemstatus = "Send_Request";
    reqmodel.reqType = "Send Request";
    reqmodel.reqitemtype = "";
    reqmodel.reqitemsubtype = "";
    reqmodel.requserPhotourl = userlogin!.profileURL;
    reqmodel.requserpostername = widget.postmodel.userpostername;
    reqmodel.posteruserID = widget.postmodel.userID;
    reqmodel.nmame = requsermamecon.text;
    reqmodel.ndept = requserDeptcon.text;
    reqmodel.scholid = requserIDcon.text;
    reqmodel.useronwerphotopostUrl = widget.postmodel.userposterPhourl;

    await FirebaseFirestore.instance
        .collection('request_feeds')
        .doc(user.uid)
        .collection('Activityfeed')
        .doc(widget.postmodel.postID)
        .set(reqmodel.tomap())
        .then((value) => debugPrint("Request Submitted"))
        .onError(
            (error, stackTrace) => (value) => debugPrint("Request Submitted"));

    snack;
    handlecleartext();
  }

  handlecleartext() {
    reqitemtitlecon.clear();
    reqfounddescriptionrcon.clear();
    reqlocationcon.clear();
    reqlocationDescriptioncon.clear();
    reqitemdescriptioncon.clear();
    reqmobilenumbercon.clear();
    reqmodelcon.clear();
    reqbrandcon.clear();
    reqmarkingscon.clear();
    reqmessagecon.clear();
    reqcolorcon.clear();
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
        reqdatetimeController.text.isEmpty ||
        reqmarkingscon.text.isEmpty ||
        reqmessagecon.text.isEmpty ||
        requsermamecon.text.isEmpty ||
        requserDeptcon.text.isEmpty ||
        reqcolorcon.text.isEmpty ||
        requserIDcon.text.isEmpty) {
      snackBarScreen(context, "Please fill out all the information");
    } else {
      handlesendRequest();
    }
  }
}
