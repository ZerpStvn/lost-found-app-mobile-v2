import 'package:lostfoundapp/cardpost/lostcardpost.dart';
import 'package:lostfoundapp/mics/packages.dart';

class LostItemTabs extends StatefulWidget {
  const LostItemTabs({super.key});

  @override
  State<LostItemTabs> createState() => _LostItemTabsState();
}

class _LostItemTabsState extends State<LostItemTabs> {
  List _listfeed = [];
  final userPostRef = FirebaseFirestore.instance;
  @override
  void initState() {
    getuserPost();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: getuserPost,
      child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: _listfeed.length,
          itemBuilder: ((context, index) {
            return LostCardPost(_listfeed[index] as UserPostModel);
          })),
    );
  }

  Future getuserPost() async {
    final data = await userPostRef.collectionGroup('litems').get();

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
