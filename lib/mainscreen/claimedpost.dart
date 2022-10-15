import 'package:intl/intl.dart';
import 'package:lostfoundapp/mics/packages.dart';

class ClaimedItemPostPage extends StatefulWidget {
  const ClaimedItemPostPage({super.key});

  @override
  State<ClaimedItemPostPage> createState() => _ClaimedItemPostPageState();
}

class _ClaimedItemPostPageState extends State<ClaimedItemPostPage> {
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
      backgroundColor: colorWhite,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: colorWhite,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => const SliverHomePage())),
          icon: const Icon(
            Icons.arrow_back,
            color: colorblack,
          ),
        ),
        title: Row(
          children: const [
            TextView(
              title: "Claimed Items",
              fontsize: 18,
              fontcolor: primaryColor,
              fontweight: FontWeight.bold,
            ),
            SizedBox(
              width: 5,
            ),
            Icon(
              Icons.handshake_outlined,
              color: primaryColor,
            )
          ],
        ),
      ),
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
                        hintStyle: GoogleFonts.montserrat(color: colorblack),
                        suffixIcon: const Icon(Icons.search_outlined),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30))),
                  ),
                ),
              ),
              const SizedBox(
                height: 13,
              ),
              FutureBuilder<QuerySnapshot>(
                  future: FirebaseFirestore.instance
                      .collectionGroup('claimeditems')
                      .get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              ClaimedItemModel clm =
                                  ClaimedItemModel.fromDocument(
                                      snapshot.data!.docs[index].data());
                              Timestamp timestamp =
                                  clm.claimedDate as Timestamp;
                              final DateTime timeDate = timestamp.toDate();
                              final tiemformat =
                                  DateFormat('M/d/y KK:mm').format(timeDate);
                              if (!snapshot.hasData) {
                                return const Center(
                                  child: Text("No Data"),
                                );
                              }

                              if (clm.itemname!
                                      .trim()
                                      .toLowerCase()
                                      .contains(onchangevalue) ||
                                  clm.claimedDate
                                      .toString()
                                      .toLowerCase()
                                      .contains(onchangevalue) ||
                                  clm.claimername
                                      .toString()
                                      .toLowerCase()
                                      .contains(onchangevalue) ||
                                  clm.ownersname
                                      .toString()
                                      .toLowerCase()
                                      .contains(onchangevalue)) {
                                return ClaimedPostPage(
                                    clm: clm, tiemformat: tiemformat);
                              } else {
                                return ClaimedPostPage(
                                    clm: clm, tiemformat: tiemformat);
                              }
                            }),
                      );
                    }
                  })
            ],
          ),
        )),
      ),
    );
  }
}
