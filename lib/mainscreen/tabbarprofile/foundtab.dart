import 'package:lostfoundapp/cardpost/foundcardpost.dart';
import 'package:lostfoundapp/mics/packages.dart';

class FoundItemProfiletab extends StatefulWidget {
  const FoundItemProfiletab({super.key});

  @override
  State<FoundItemProfiletab> createState() => _FoundItemProfiletabState();
}

class _FoundItemProfiletabState extends State<FoundItemProfiletab> {
  List _listfeed = [];
  final userPostRef = FirebaseFirestore.instance;
  @override
  void initState() {
    getuserPost();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: _listfeed.length,
        itemBuilder: ((context, index) {
          return FoundCardPost(_listfeed[index] as UserPostModel);
        }));
  }

  Future getuserPost() async {
    final data = await userPostRef
        .collection("found_items")
        .doc(userlogin!.useruid)
        .collection('fitems')
        .orderBy('dateposted', descending: true)
        .get();

    if (mounted) {
      setState(() {
        _listfeed =
            List.from(data.docs.map((doc) => UserPostModel.fromDocuments(doc)));
      });
    } else {
      dispose();
    }
  }
}
