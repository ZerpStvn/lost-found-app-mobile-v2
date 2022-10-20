import 'package:lostfoundapp/cardpost/suggestionCard.dart';
import 'package:lostfoundapp/mics/packages.dart';

class SuggestionItems extends StatefulWidget {
  const SuggestionItems({super.key});

  @override
  State<SuggestionItems> createState() => _SuggestionItemsState();
}

class _SuggestionItemsState extends State<SuggestionItems> {
  List suggested = [];
  final userPostRef = FirebaseFirestore.instance;
  @override
  void initState() {
    getlostPost();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: getlostPost,
      child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: suggested.length,
          itemBuilder: ((context, index) {
            return SuggestionCardPost(suggested[index] as UserPostModel);
          })),
    );
  }

  Future getlostPost() async {
    final post = await FirebaseFirestore.instance
        .collection('lost_items')
        .doc(userlogin!.useruid)
        .collection('litems')
        .get();

    if (mounted) {
      setState(() {
        suggested =
            List.from(post.docs.map((doc) => UserPostModel.fromDocuments(doc)));
      });
    } else {
      dispose();
    }
  }
}
