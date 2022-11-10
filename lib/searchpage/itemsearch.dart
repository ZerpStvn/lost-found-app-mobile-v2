import 'package:lostfoundapp/mics/packages.dart';
import 'package:lostfoundapp/searchpage/viewSearch.dart';

class ItemSearchPage extends StatefulWidget {
  const ItemSearchPage({super.key});

  @override
  State<ItemSearchPage> createState() => _ItemSearchPageState();
}

class _ItemSearchPageState extends State<ItemSearchPage> {
  final TextEditingController search = TextEditingController();
  String onchangevalue = "";

  @override
  void dispose() {
    search.dispose();
    super.dispose();
  }

  List<String> postdataquery = [];

  void searchqueary(String query) {
    setState(() {
      postdataquery = query.split(' ');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Center(
                        child: SizedBox(
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.89,
                          child: TextFormField(
                            controller: search,
                            onChanged: (value) {
                              setState(() {
                                searchqueary(value);
                              });
                            },
                            textInputAction: TextInputAction.search,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                                hintText: "Search",
                                hintStyle:
                                    GoogleFonts.montserrat(color: colorblack),
                                suffixIcon: const Icon(Icons.search_outlined),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30))),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 13,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 11.0, right: 11.0),
                        child: FutureBuilder<QuerySnapshot>(
                            future: FirebaseFirestore.instance
                                .collection('users_Post')
                                .get(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else {
                                return ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: snapshot.data!.docs.length,
                                    itemBuilder: (context, index) {
                                      UserPostModel post =
                                          UserPostModel.fromDocuments(snapshot
                                              .data!.docs[index]
                                              .data());

                                      if (!snapshot.hasData) {
                                        return Container();
                                      }
                                      List<String> queryingdata = [
                                        '${post.itemname}',
                                        '${post.location}',
                                        '${post.datelossfound}',
                                        '${post.locationDes}',
                                        '${post.itemDes}',
                                        '${post.itemMarks}',
                                        '${post.itemmodel}',
                                        '${post.itembrand}',
                                        '${post.foundlossDes}'
                                      ];
                                      for (var value in queryingdata) {
                                        if (postdataquery.any((element) => value
                                            .toLowerCase()
                                            .contains(element.toLowerCase()))) {
                                          return ViewSearchPost(post);
                                        }
                                      }

                                      return ViewSearchPost(post);
                                    });
                              }
                            }),
                      )
                    ],
                  )))),
    );
  }
}
