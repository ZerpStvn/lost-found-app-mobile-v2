// ignore_for_file: file_names
import 'package:lostfoundapp/chatRoom/chatconvo.dart';
import 'package:lostfoundapp/mics/packages.dart';
import 'package:lostfoundapp/model/chatroommodel.dart';

class ChatRoomPage extends StatefulWidget {
  const ChatRoomPage({super.key});

  @override
  State<ChatRoomPage> createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  final user = FirebaseAuth.instance.currentUser;
  final TextEditingController _serach = TextEditingController();
  String chatsearch = "";

  @override
  void dispose() {
    _serach.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //final widthsize = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: colorWhite,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: IconButton(
              onPressed: () => Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SliverHomePage()),
                  (route) => false),
              icon: const Icon(Icons.arrow_back)),
        ),
        leadingWidth: 40,
        elevation: 0,
        backgroundColor: colorWhite,
        iconTheme: const IconThemeData(color: primaryColor),
        title: Row(
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: NetworkImage("${userlogin!.profileURL}"),
                      fit: BoxFit.cover)),
            ),
            const SizedBox(
              width: 5,
            ),
            SizedBox(
              width: 140,
              child: AutoSizeText(
                "${userlogin!.username}",
                maxLines: 1,
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.bold,
                    color: colorblack,
                    fontSize: 18),
              ),
            ),
          ],
        ),
        toolbarHeight: 75,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 25.0),
            child: Icon(
              Icons.info_outline_rounded,
              color: primaryColor,
            ),
          )
        ],
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('ChatRooms')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                if (!snapshot.hasData) {
                                  return Container();
                                } else {
                                  ChatRoomModel chatroom =
                                      ChatRoomModel.fromDocument(
                                          snapshot.data!.docs[index].data());
                                  if (chatroom.sentbyID == user!.uid) {
                                    return ListTile(
                                      leading: Container(
                                        height: 65,
                                        width: 65,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    "${chatroom.sentToprofileURL}"),
                                                fit: BoxFit.cover)),
                                      ),
                                      title: TextViewInter(
                                          title: "${chatroom.sentToname}",
                                          fontsize: 16,
                                          fontweight: FontWeight.bold,
                                          fontcolor: colorblack),
                                      subtitle: const TextViewInter(
                                          title: "Send message",
                                          fontsize: 14,
                                          fontweight: FontWeight.w400,
                                          fontcolor: colorgrey),
                                      trailing: const Padding(
                                        padding: EdgeInsets.only(right: 12.0),
                                        child: Icon(Icons.send_rounded),
                                      ),
                                      onTap: () {
                                        //handlegetDataClaimed(chatroom);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ChatConvopage(chatroom)));
                                      },
                                    );
                                  }
                                  if (chatroom.sentToID == user!.uid) {
                                    return ListTile(
                                      leading: Container(
                                        height: 65,
                                        width: 65,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    "${chatroom.sentbyprofileURL}"),
                                                fit: BoxFit.cover)),
                                      ),
                                      title: TextViewInter(
                                          title: "${chatroom.sentbyname}",
                                          fontsize: 16,
                                          fontweight: FontWeight.bold,
                                          fontcolor: colorblack),
                                      subtitle: const TextViewInter(
                                          title: "Send message",
                                          fontsize: 14,
                                          fontweight: FontWeight.w400,
                                          fontcolor: colorgrey),
                                      trailing: const Padding(
                                        padding: EdgeInsets.only(right: 12.0),
                                        child: Icon(Icons.send_rounded),
                                      ),
                                      onTap: () {
                                        // handlegetDataClaimed(chatroom);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ChatConvopage(chatroom)));
                                      },
                                    );
                                  } else {
                                    return Container();
                                  }
                                }
                              }),
                        );
                      }
                    }),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
