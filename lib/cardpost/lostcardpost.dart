import 'package:intl/intl.dart';
import 'package:lostfoundapp/mics/getuserProfile.dart';
import 'package:lostfoundapp/mics/packages.dart';
import 'package:lostfoundapp/sendRequest/lostSendRequest.dart';

class LostCardPost extends StatefulWidget {
  final UserPostModel postModel;
  const LostCardPost(this.postModel, {super.key});

  @override
  State<LostCardPost> createState() => _LostCardPostState();
}

class _LostCardPostState extends State<LostCardPost> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    Timestamp timestamp = widget.postModel.dateposted as Timestamp;
    final DateTime timeDate = timestamp.toDate();
    final tiemformat = DateFormat('M/d/y KK:mm').format(timeDate);
    return Padding(
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
            child: GetUserProfileLost(
                userID: "${widget.postModel.userID}",
                postModel: widget.postModel,
                tiemformat: tiemformat),
          ),
        ),
      ),
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
