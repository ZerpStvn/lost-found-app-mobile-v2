import 'package:lostfoundapp/cardpost/foundcardpost.dart';
import 'package:lostfoundapp/mics/packages.dart';

class FoundItems extends StatefulWidget {
  const FoundItems({super.key});

  @override
  State<FoundItems> createState() => _FoundItemsState();
}

class _FoundItemsState extends State<FoundItems> {
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
            return FoundCardPost(_listfeed[index] as UserPostModel);
          })),
    );
  }

  Future getuserPost() async {
    final data = await userPostRef.collectionGroup('fitems').get();

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
