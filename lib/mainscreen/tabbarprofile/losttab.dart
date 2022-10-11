import 'package:lostfoundapp/cardpost/lostcardpost.dart';
import 'package:lostfoundapp/mics/packages.dart';

class LostItemProfileTabs extends StatefulWidget {
  const LostItemProfileTabs({super.key});

  @override
  State<LostItemProfileTabs> createState() => _LostItemProfileTabsState();
}

class _LostItemProfileTabsState extends State<LostItemProfileTabs> {
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
          return LostCardPost(_listfeed[index] as UserPostModel);
        }));
  }

  Future getuserPost() async {
    final data = await userPostRef
        .collection('lost_items')
        .doc(userlogin!.useruid)
        .collection('litems')
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
