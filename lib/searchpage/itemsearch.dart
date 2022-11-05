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
                                onchangevalue = value;
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

                                      // String searchfrag =
                                      //     "${post.itemname}${post.location}${post.datelossfound}${post.locationDes}${post.itemDes}${post.itemMarks}${post.itemmodel}${post.itembrand}${post.foundlossDes}"
                                      //         .trim();
                                      // var reviewRegex = RegExp(onchangevalue)
                                      //     .hasMatch(searchfrag);
                                      if (!snapshot.hasData) {
                                        return Container();
                                      }
                                      if (post.itemname!
                                              .trim()
                                              .toLowerCase()
                                              .contains(onchangevalue) ||
                                          post.location!
                                              .trim()
                                              .toLowerCase()
                                              .contains(onchangevalue) ||
                                          post.datelossfound!
                                              .trim()
                                              .toLowerCase()
                                              .contains(onchangevalue) ||
                                          post.locationDes!
                                              .trim()
                                              .toLowerCase()
                                              .contains(onchangevalue) ||
                                          post.itemDes!
                                              .trim()
                                              .toLowerCase()
                                              .contains(onchangevalue) ||
                                          post.itemMarks!
                                              .trim()
                                              .toLowerCase()
                                              .contains(onchangevalue) ||
                                          post.itemmodel!
                                              .trim()
                                              .toLowerCase()
                                              .contains(onchangevalue) ||
                                          post.itembrand!
                                              .trim()
                                              .toLowerCase()
                                              .contains(onchangevalue) ||
                                          post.foundlossDes!
                                              .trim()
                                              .toLowerCase()
                                              .contains(onchangevalue)) {
                                        return ViewSearchPost(post);
                                      }
                                      return Container();
                                    });
                              }
                            }),
                      )
                    ],
                  )))),
    );
  }
}
