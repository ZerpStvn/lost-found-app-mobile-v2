// ignore_for_file: file_names

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
          onPressed: () => Navigator.pop(context),
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
              const SizedBox(
                height: 18,
              ),
              FutureBuilder<QuerySnapshot>(
                  future: FirebaseFirestore.instance
                      .collection('Claimed_items')
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
