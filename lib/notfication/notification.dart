import 'package:lostfoundapp/mics/packages.dart';

class NotificationFeed extends StatefulWidget {
  const NotificationFeed({super.key});

  @override
  State<NotificationFeed> createState() => _NotificationFeedState();
}

class _NotificationFeedState extends State<NotificationFeed> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorWhite,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: colorWhite,
        iconTheme: const IconThemeData(color: colorblack),
        title: Row(
          children: const [
            TextView(
              title: "Notification",
              fontsize: 18,
              fontcolor: primaryColor,
              fontweight: FontWeight.bold,
            ),
            SizedBox(
              width: 5,
            ),
            Icon(
              Icons.notifications_outlined,
              color: primaryColor,
            )
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 17,
              ),
              Center(
                child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collectionGroup('Activityfeed')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return SizedBox(
                          width: MediaQuery.of(context).size.width * 0.89,
                          child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                Requesmodel reqmodel =
                                    Requesmodel.fromDocuments(
                                        snapshot.data!.docs[index].data());
                                if (!snapshot.hasData) {
                                  return Container();
                                }

                                if (reqmodel.posteruserID == user!.uid) {
                                  if (reqmodel.feed == "Notif") {
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: ListTile(
                                        shape: RoundedRectangleBorder(
                                            side: const BorderSide(
                                                color: colorblack, width: 0.6),
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        leading: Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    "${reqmodel.requserPhotourl}"),
                                                fit: BoxFit.cover),
                                          ),
                                        ),
                                        title: TextViewInter(
                                            title: "${reqmodel.nmame}",
                                            fontsize: 18,
                                            fontweight: FontWeight.bold,
                                            fontcolor: colorblack),
                                        subtitle: TextViewInter(
                                          title:
                                              reqmodel.reqitemstatus == "Accept"
                                                  ? "Request Accepted"
                                                  : reqmodel.reqitemstatus ==
                                                          "Canceled"
                                                      ? "Request Rejected"
                                                      : "sent you a request",
                                          fontsize: 10,
                                          fontcolor: colorgrey,
                                          fontweight: FontWeight.normal,
                                        ),
                                        trailing: ElevatedButton(
                                            onPressed: () => Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ViewNotification(
                                                            reqmodel))),
                                            child: const Text("View")),
                                      ),
                                    );
                                  }
                                }
                                if (reqmodel.requserID == user!.uid) {
                                  if (reqmodel.reqType == "Request accepted") {
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: ListTile(
                                        shape: RoundedRectangleBorder(
                                            side: const BorderSide(
                                                color: colorblack, width: 0.6),
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        leading: Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    "${reqmodel.useronwerphotopostUrl}"),
                                                fit: BoxFit.cover),
                                          ),
                                        ),
                                        title: TextViewInter(
                                            title:
                                                "${reqmodel.requserpostername}",
                                            fontsize: 18,
                                            fontweight: FontWeight.bold,
                                            fontcolor: colorblack),
                                        subtitle: const TextViewInter(
                                          title: "Accepted your request",
                                          fontsize: 10,
                                          fontcolor: colorgrey,
                                          fontweight: FontWeight.normal,
                                        ),
                                        trailing: ElevatedButton(
                                            onPressed: () => Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const ChatRoomPage())),
                                            child: const Text("Chat")),
                                      ),
                                    );
                                  }
                                }
                                return Container();
                              }),
                        );
                      }
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
