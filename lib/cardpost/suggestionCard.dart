// ignore_for_file: file_names

//import 'dart:ui';

import 'package:intl/intl.dart';
import 'package:lostfoundapp/cardpost/vievsuggestionCardpost.dart';
import 'package:lostfoundapp/claimeditem/lostclaimed.dart';
import 'package:lostfoundapp/mics/packages.dart';
import 'package:lostfoundapp/sendRequest/lostSendRequest.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class SuggestionCardPost extends StatefulWidget {
  final UserPostModel postModel;
  const SuggestionCardPost(this.postModel, {super.key});

  @override
  State<SuggestionCardPost> createState() => _SuggestionCardPostState();
}

class _SuggestionCardPostState extends State<SuggestionCardPost> {
  final user = FirebaseAuth.instance.currentUser;

  double percentage = 0;
  double percentage2 = 0;
  double percentage3 = 0;
  double percentage4 = 0;
  double percentage5 = 0;
  double percentage6 = 0;

  Widget suggestion(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance.collectionGroup('fitems').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container();
          } else {
            return ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container();
                  } else {
                    UserPostModel post = UserPostModel.fromDocuments(
                        snapshot.data!.docs[index].data());
                    //=================================================
                    if (post.itemtype!.trim().toLowerCase().contains(
                        widget.postModel.itemtype!.trim().toLowerCase())) {
                      percentage = 0.50;
                      if (post.datelossfound!.trim().toLowerCase().contains(
                          widget.postModel.datelossfound!
                              .trim()
                              .toLowerCase())) {
                        percentage2 = 0.25;
                        if (post.itemname!.trim().toLowerCase().contains(
                            widget.postModel.itemname!.trim().toLowerCase())) {
                          percentage3 = 0.25;
                          double total = percentage + percentage2 + percentage3;
                          return CardSuggest(total: total, userpost: post);
                        }
                      }
                    }
                    //=======================
                    if (post.itemtype!.trim().toLowerCase().contains(
                        widget.postModel.itemtype!.trim().toLowerCase())) {
                      percentage = 0.30;
                      if (!post.datelossfound!.trim().toLowerCase().contains(
                          widget.postModel.datelossfound!
                              .trim()
                              .toLowerCase())) {
                        percentage2 = 0.10;
                        if (post.itemname!.trim().toLowerCase().contains(
                            widget.postModel.itemname!.trim().toLowerCase())) {
                          percentage3 = 0.20;
                          double total = percentage + percentage2 + percentage3;
                          return CardSuggest(total: total, userpost: post);
                        }
                      }
                    }

                    //==========================
                    if (post.itemtype!.trim().toLowerCase().contains(
                        widget.postModel.itemtype!.trim().toLowerCase())) {
                      percentage = 0.30;
                      if (post.datelossfound!.trim().toLowerCase().contains(
                          widget.postModel.datelossfound!
                              .trim()
                              .toLowerCase())) {
                        percentage2 = 0.10;
                        if (!post.itemname!.trim().toLowerCase().contains(
                            widget.postModel.itemname!.trim().toLowerCase())) {
                          percentage3 = 0.10;
                          double total = percentage + percentage2 + percentage3;
                          return CardSuggest(total: total, userpost: post);
                        }
                      }
                    }
                    //==============================

                    if (post.itemtype!.trim().toLowerCase().contains(
                        widget.postModel.itemtype!.trim().toLowerCase())) {
                      percentage = 0.10;
                      if (!post.datelossfound!.trim().toLowerCase().contains(
                          widget.postModel.datelossfound!
                              .trim()
                              .toLowerCase())) {
                        percentage2 = 0.0;
                        if (!post.itemname!.trim().toLowerCase().contains(
                            widget.postModel.itemname!.trim().toLowerCase())) {
                          percentage3 = 0.0;
                          double total = percentage + percentage2 + percentage3;
                          return CardSuggest(total: total, userpost: post);
                        }
                      }
                    }
                    //==========================
                    if (!post.itemtype!.trim().toLowerCase().contains(
                        widget.postModel.itemtype!.trim().toLowerCase())) {
                      percentage = 0.0;
                      if (post.datelossfound!.trim().toLowerCase().contains(
                          widget.postModel.datelossfound!
                              .trim()
                              .toLowerCase())) {
                        percentage2 = 0.10;
                        if (post.itemname!.trim().toLowerCase().contains(
                            widget.postModel.itemname!.trim().toLowerCase())) {
                          percentage3 = 0.20;
                          double total = percentage + percentage2 + percentage3;
                          return CardSuggest(total: total, userpost: post);
                        }
                      }
                    }
                    //==========================
                    if (!post.itemtype!.trim().toLowerCase().contains(
                        widget.postModel.itemtype!.trim().toLowerCase())) {
                      percentage = 0.0;
                      if (!post.datelossfound!.trim().toLowerCase().contains(
                          widget.postModel.datelossfound!
                              .trim()
                              .toLowerCase())) {
                        percentage2 = 0.0;
                        if (post.itemname!.trim().toLowerCase().contains(
                            widget.postModel.itemname!.trim().toLowerCase())) {
                          percentage4 = 0.20;
                          double total = percentage + percentage2 + percentage3;
                          return CardSuggest(total: total, userpost: post);
                        }
                      }
                    }

                    return Container();
                  }
                });
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    Timestamp timestamp = widget.postModel.dateposted as Timestamp;
    final DateTime timeDate = timestamp.toDate();
    final tiemformat = DateFormat('M/d/y KK:mm').format(timeDate);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
            height: 150.0,
            width: MediaQuery.of(context).size.width,
            child: suggestion(context)),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: SizedBox(
            height: 200,
            child: GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          LostItemRequestSender(widget.postModel))),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Card(
                  elevation: 10,
                  child: Stack(fit: StackFit.expand, children: [
                    widget.postModel.phtoURL == "empty"
                        ? Container(
                            color: const Color.fromARGB(141, 66, 73, 69),
                            child: Container(
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/background_green.jpg'),
                                    fit: BoxFit.cover),
                              ),
                              child: const Center(
                                child: TextViewPoppins(
                                    title: "no image",
                                    fontsize: 12,
                                    fontcolor: colorWhite),
                              ),
                            ),
                          )
                        : Image.network(
                            "${widget.postModel.phtoURL}",
                            fit: BoxFit.cover,
                            color: const Color.fromARGB(141, 66, 73, 69),
                            colorBlendMode: BlendMode.multiply,
                          ),
                    Positioned(
                        top: 10,
                        left: 15,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: NetworkImage(
                                      "${widget.postModel.userposterPhourl}"),
                                  fit: BoxFit.cover)),
                        )),
                    Positioned(
                        top: 13,
                        left: 65,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                                width: 130,
                                child: AutoSizeText(
                                  "${widget.postModel.userpostername}",
                                  maxLines: 1,
                                  style: GoogleFonts.poppins(
                                      fontSize: 14, color: colorWhite),
                                )),
                            TextViewPoppins(
                                title: tiemformat,
                                fontsize: 10,
                                fontcolor: colorWhite),
                          ],
                        )),
                    Positioned(
                        top: 8,
                        right: 10,
                        child: IconButton(
                            onPressed: () {
                              handleButtonModalItem(context);
                            },
                            icon: const Icon(
                              Icons.more_vert,
                              color: colorWhite,
                            ))),
                    Positioned(
                      bottom: 33,
                      left: 10,
                      child: Row(
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            color: colorWhite,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          SizedBox(
                            width: 87,
                            child: AutoSizeText(
                              "${widget.postModel.location}",
                              maxLines: 1,
                              style: GoogleFonts.poppins(
                                  fontSize: 12, color: colorWhite),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Positioned(
                      bottom: 18,
                      left: 15,
                      child: TextViewPoppins(
                          title: "location last seen",
                          fontsize: 12,
                          fontcolor: colorWhite),
                    ),
                    Positioned(
                      bottom: 18,
                      right: 15,
                      child: Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.transparent,
                        child: OutlinedButton(
                            onPressed: () {
                              if (widget.postModel.userID ==
                                  userlogin!.useruid) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            LostClaimedPage(widget.postModel)));
                              }
                            },
                            style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                                    width: 2, color: Colors.white),
                                shape: const StadiumBorder()),
                            child: TextViewPoppins(
                                title: widget.postModel.userID ==
                                        userlogin!.useruid
                                    ? "Mark Claimed"
                                    : "View",
                                fontsize: 12,
                                fontcolor: colorWhite)),
                      ),
                    ),
                  ]),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future handleButtonModalItem(BuildContext context) async {
    return (await showModalBottomSheet(
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.only(top: 11.0, bottom: 11.0),
            child: widget.postModel.userID == userlogin!.useruid
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        leading: const Icon(Icons.edit_outlined),
                        title: const TextView(
                            title: "Edit",
                            fontsize: 13,
                            fontweight: FontWeight.w500,
                            fontcolor: colorblack),
                        onTap: () {
                          Navigator.of(context, rootNavigator: true).pop();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      LostItemRequestSender(widget.postModel)));
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.delete),
                        title: const TextView(
                            title: "Delete",
                            fontsize: 13,
                            fontweight: FontWeight.w500,
                            fontcolor: colorblack),
                        onTap: () {
                          Navigator.of(context, rootNavigator: true).pop();
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      LostItemRequestSender(widget.postModel)),
                              (route) => false);
                        },
                      )
                    ],
                  )
                : ListTile(
                    leading: const Icon(Icons.report_outlined),
                    title: const TextView(
                        title: "Report",
                        fontsize: 13,
                        fontweight: FontWeight.w500,
                        fontcolor: colorblack),
                    onTap: () {
                      Navigator.of(context, rootNavigator: true).pop();
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  LostItemRequestSender(widget.postModel)),
                          (route) => false);
                    },
                  ),
          );
        }));
  }
}

class CardSuggest extends StatelessWidget {
  const CardSuggest({super.key, required this.total, required this.userpost});
  final double total;
  final UserPostModel userpost;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SuggestionFoundCardPost(userpost, total))),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: SizedBox(
          width: 150,
          child: Card(
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  "${userpost.phtoURL}",
                  fit: BoxFit.cover,
                  color: const Color.fromARGB(141, 66, 73, 69),
                  colorBlendMode: BlendMode.multiply,
                ),
                Positioned(
                    bottom: 15,
                    left: 10,
                    child: Row(
                      children: [
                        CircularPercentIndicator(
                            percent: total,
                            radius: 20.0,
                            lineWidth: 7.0,
                            progressColor: primaryColor,
                            backgroundColor:
                                const Color.fromARGB(255, 251, 250, 253),
                            circularStrokeCap: CircularStrokeCap.round,
                            center: Text(
                              "${total.toStringAsFixed(2)}%",
                              style: GoogleFonts.inter(
                                  fontSize: 6.0, color: colorWhite),
                            )),
                        const SizedBox(
                          width: 5,
                        ),
                        const TextViewPoppins(
                          title: "MATCH",
                          fontsize: 10,
                          fontcolor: colorWhite,
                          fontweight: FontWeight.bold,
                        ),
                      ],
                    )),
                Positioned(
                    top: 10.0,
                    left: 10.0,
                    child: Row(
                      children: [
                        Container(
                          height: 13.0,
                          width: 13.0,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromARGB(255, 24, 211, 80),
                          ),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        TextViewPoppins(
                          title: "${userpost.datelossfound}",
                          fontsize: 10,
                          fontcolor: colorWhite,
                          fontweight: FontWeight.bold,
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
