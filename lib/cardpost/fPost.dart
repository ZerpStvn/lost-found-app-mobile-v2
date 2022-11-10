// ignore_for_file: file_names

import 'package:flutter/scheduler.dart';
import 'package:lostfoundapp/mics/networkImage.dart';
import 'package:lostfoundapp/mics/packages.dart';
import 'package:lostfoundapp/model/userdata.dart';

class PostCardViewScreen extends StatefulWidget {
  const PostCardViewScreen(
      {super.key,
      required this.postModel,
      required this.tiemformat,
      required this.users});
  final UserPostModel postModel;
  final String tiemformat;
  final UserDataModel users;

  @override
  State<PostCardViewScreen> createState() => _PostCardViewScreenState();
}

class _PostCardViewScreenState extends State<PostCardViewScreen> {
  Future handleDIalog(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const TextViewPoppins(
              title: "Notice",
              fontsize: 18,
              fontcolor: primaryColor,
              fontweight: FontWeight.bold,
            ),
            content: const TextViewPoppins(
              title: "Did you deliver the Item to the owner? ",
              fontsize: 15,
              fontcolor: colorblack,
            ),
            actions: [
              TextButton(
                onPressed: () =>
                    Navigator.of(context, rootNavigator: true).pop(),
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
                  SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ClaimedPage(widget.postModel)));
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
        });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Stack(fit: StackFit.expand, children: [
        NetWorkCacheImageView("${widget.postModel.phtoURL}",
            widget: Center(
              child: Image.asset('assets/banner.png'),
            )),
        Positioned(
            top: 10,
            left: 15,
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: NetworkImage("${widget.users.profileURL}"),
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
                      "${widget.users.username}",
                      maxLines: 1,
                      style:
                          GoogleFonts.poppins(fontSize: 14, color: colorWhite),
                    )),
                TextViewPoppins(
                    title: widget.tiemformat,
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
                  style: GoogleFonts.poppins(fontSize: 12, color: colorWhite),
                ),
              ),
            ],
          ),
        ),
        const Positioned(
          bottom: 18,
          left: 15,
          child: TextViewPoppins(
              title: "location last found",
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
                  if (widget.postModel.userID == userlogin!.useruid) {
                    handleDIalog(context);
                  } else {
                    null;
                  }
                },
                style: OutlinedButton.styleFrom(
                    side: const BorderSide(width: 2, color: Colors.white),
                    shape: const StadiumBorder()),
                child: TextViewPoppins(
                    title: "${widget.postModel.itemstatus}",
                    fontsize: 12,
                    fontcolor: colorWhite)),
          ),
        ),
      ]),
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
                                  builder: (context) => FountItemRequestSender(
                                      widget.postModel)));
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FountItemRequestSender(
                                      widget.postModel)));
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  FountItemRequestSender(widget.postModel)));
                    },
                  ),
          );
        }));
  }
}
