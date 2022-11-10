// ignore_for_file: file_names

import 'package:lostfoundapp/claimeditem/lostclaimed.dart';
import 'package:lostfoundapp/mics/networkImage.dart';
import 'package:lostfoundapp/mics/packages.dart';
import 'package:lostfoundapp/model/userdata.dart';
import 'package:lostfoundapp/sendRequest/lostSendRequest.dart';

class LostPostScreenView extends StatefulWidget {
  const LostPostScreenView({
    super.key,
    required this.postModel,
    required this.tiemformat,
    required this.users,
  });
  final UserPostModel postModel;
  final String tiemformat;
  final UserDataModel users;

  @override
  State<LostPostScreenView> createState() => _LostPostScreenViewState();
}

class _LostPostScreenViewState extends State<LostPostScreenView> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Stack(fit: StackFit.expand, children: [
        widget.postModel.phtoURL == "empty"
            ? Container(
                color: const Color.fromARGB(141, 66, 73, 69),
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/background_green.jpg'),
                        fit: BoxFit.cover),
                  ),
                  child: const Center(
                    child: TextViewPoppins(
                        title: "no image", fontsize: 12, fontcolor: colorWhite),
                  ),
                ),
              )
            : NetWorkCacheImageView("${widget.postModel.phtoURL}",
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
                      image:
                          NetworkImage("${widget.postModel.userposterPhourl}"),
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
              title: "location last seen", fontsize: 12, fontcolor: colorWhite),
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                LostClaimedPage(widget.postModel)));
                  }
                  if (widget.postModel.userID != userlogin!.useruid) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                LostItemRequestSender(widget.postModel)));
                  }
                },
                style: OutlinedButton.styleFrom(
                    side: const BorderSide(width: 2, color: Colors.white),
                    shape: const StadiumBorder()),
                child: TextViewPoppins(
                    title: widget.postModel.userID == userlogin!.useruid
                        ? "Mark Claimed"
                        : "View",
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
                        title: const TextViewPoppins(
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
                        title: const TextViewPoppins(
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
                    title: const TextViewPoppins(
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
                                  LostItemRequestSender(widget.postModel)));
                    },
                  ),
          );
        }));
  }
}
