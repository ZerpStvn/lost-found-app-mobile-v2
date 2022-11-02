import 'package:intl/intl.dart';
import 'package:lostfoundapp/mics/getuserProfile.dart';
import 'package:lostfoundapp/mics/packages.dart';

class FoundCardPost extends StatefulWidget {
  final UserPostModel postModel;
  const FoundCardPost(this.postModel, {super.key});

  @override
  State<FoundCardPost> createState() => _FoundCardPostState();
}

class _FoundCardPostState extends State<FoundCardPost> {
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
                      FountItemRequestSender(widget.postModel))),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: GetUserProfile(
                  userID: "${widget.postModel.userID}",
                  postModel: widget.postModel,
                  tiemformat: tiemformat)),
        ),
      ),
    );
  }
}
