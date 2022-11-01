import 'package:intl/intl.dart';
import 'package:lostfoundapp/mics/packages.dart';

class ArchivePage extends StatefulWidget {
  const ArchivePage({super.key});

  @override
  State<ArchivePage> createState() => _ArchivePageState();
}

class _ArchivePageState extends State<ArchivePage> {
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
          icon: const Icon(Icons.arrow_back, color: colorblack),
        ),
        title: Row(
          children: const [
            TextView(
              title: "Archive",
              fontsize: 18,
              fontcolor: primaryColor,
              fontweight: FontWeight.bold,
            ),
            SizedBox(
              width: 5,
            ),
            Icon(
              Icons.archive_outlined,
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
                              if (!snapshot.hasData) {
                                return const Center(
                                  child: Text("No Data"),
                                );
                              }
                              if (userlogin!.useruid == clm.userID) {
                                Timestamp timestamp =
                                    clm.claimedDate as Timestamp;
                                final DateTime timeDate = timestamp.toDate();
                                final tiemformat =
                                    DateFormat('M/d/y KK:mm').format(timeDate);
                                return ClaimedPostPage(
                                    clm: clm, tiemformat: tiemformat);
                              } else {
                                return Container();
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
