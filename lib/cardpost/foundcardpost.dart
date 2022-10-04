import 'package:flutter/scheduler.dart';
import 'package:lostfoundapp/mics/packages.dart';

class FoundCardPost extends StatefulWidget {
  final UserPostModel postModel;
  const FoundCardPost(this.postModel, {super.key});

  @override
  State<FoundCardPost> createState() => _FoundCardPostState();
}

class _FoundCardPostState extends State<FoundCardPost> {
  final user = FirebaseAuth.instance.currentUser;

  Future handleDIalog(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const TextView(
              title: "Notice",
              fontsize: 18,
              fontcolor: primaryColor,
              fontweight: FontWeight.bold,
            ),
            content: const TextView(
              title: "Did you deliver the Item to the owner? ",
              fontsize: 15,
              fontcolor: primaryColor,
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
                            builder: (context) => const ClaimedPage()));
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
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: SizedBox(
        height: 200,
        child: GestureDetector(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      FountItemRequestSender(widget.postModel))),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Card(
              elevation: 10,
              child: Stack(fit: StackFit.expand, children: [
                Image.network(
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
                            title: "${widget.postModel.dateposted!.toDate()}",
                            fontsize: 10,
                            fontcolor: colorWhite),
                      ],
                    )),
                Positioned(
                    top: 8,
                    right: 10,
                    child: IconButton(
                        onPressed: () {},
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
                          if (widget.postModel.userID == user!.uid) {
                            handleDIalog(context);
                          } else {
                            null;
                          }
                        },
                        style: OutlinedButton.styleFrom(
                            side:
                                const BorderSide(width: 2, color: Colors.white),
                            shape: const StadiumBorder()),
                        child: TextViewPoppins(
                            title: "${widget.postModel.itemstatus}",
                            fontsize: 12,
                            fontcolor: colorWhite)),
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
