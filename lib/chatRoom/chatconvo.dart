import 'package:lostfoundapp/mics/packages.dart';
import 'package:lostfoundapp/model/chatroommodel.dart';
import 'package:lostfoundapp/model/convo.dart';

class ChatConvopage extends StatefulWidget {
  final ChatRoomModel chatroom;
  const ChatConvopage(this.chatroom, {super.key});

  @override
  State<ChatConvopage> createState() => _ChatConvopageState();
}

class _ChatConvopageState extends State<ChatConvopage> {
  final TextEditingController chat = TextEditingController();
  final ScrollController controller = ScrollController();
  final user = FirebaseAuth.instance.currentUser;
  ChatConvo chatConvo = ChatConvo();
  ClaimedItemModel clm = ClaimedItemModel();

  @override
  void dispose() {
    chat.dispose();
    super.dispose();
  }

  handleconvosent() async {
    if (chat.text.isEmpty) {
      return null;
    } else {
      chatConvo.userID = user!.uid;
      chatConvo.message = chat.text;
      await FirebaseFirestore.instance
          .collection("ChatRooms")
          .doc(widget.chatroom.chatRoomID)
          .collection('conversation')
          .add(chatConvo.tomap())
          .then((value) => debugPrint("message sent"));
      chat.clear();
    }
  }

  Widget getuserchat() {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("ChatRooms")
            .doc(widget.chatroom.chatRoomID)
            .collection('conversation')
            .orderBy("timesent", descending: false)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container();
          } else {
            return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Container();
                  } else {
                    chatConvo = ChatConvo.fromDoCument(
                        snapshot.data!.docs[index].data());
                    final onchat = chatConvo.userID == user!.uid;
                    return Chatflow(onchat: onchat, chatConvo: chatConvo);
                  }
                });
          }
        });
  }

  Future getclaimedDate() async {
    DocumentSnapshot docs = await FirebaseFirestore.instance
        .collection('')
        .doc(widget.chatroom.sentbyID)
        .collection('')
        .doc('')
        .get();
  }

  @override
  Widget build(BuildContext context) {
    final usersentBy = widget.chatroom.sentbyID == user!.uid;
    return Scaffold(
        backgroundColor: colorWhite,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: IconButton(
                onPressed: () => Navigator.pop(context),
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
                        image: usersentBy
                            ? NetworkImage(
                                "${widget.chatroom.sentToprofileURL}")
                            : NetworkImage(
                                "${widget.chatroom.sentbyprofileURL}"),
                        fit: BoxFit.cover)),
              ),
              const SizedBox(
                width: 5,
              ),
              SizedBox(
                width: 140,
                child: AutoSizeText(
                  usersentBy
                      ? "${widget.chatroom.sentToname}"
                      : "${widget.chatroom.sentbyname}",
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
        body: SizedBox(
          child: Stack(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.75,
                child: SingleChildScrollView(
                  reverse: true,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      getuserchat(),
                      const Padding(padding: EdgeInsets.only(bottom: 15.0))
                    ],
                  ),
                ),
              ),
              userPost(),
              if (widget.chatroom.status == "Claimed")
                Container()
              else
                Container(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      color: colorWhite,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, right: 8.0, bottom: 20, top: 15),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: chat,
                                decoration: InputDecoration(
                                    hintText: "Chat",
                                    hintStyle: GoogleFonts.inter(
                                        fontSize: 14, color: colorblack),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20))),
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  handleconvosent();
                                },
                                icon: const Icon(Icons.send_rounded))
                          ],
                        ),
                      ),
                    ))
            ],
          ),
        ));
  }

  Widget userPost() {
    return SizedBox(
      height: 90,
      child: Card(
        color: primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 15,
        child: Center(
          child: ListTile(
            leading: Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(9),
                  child: SizedBox(
                    width: 80,
                    child: Image.network(
                      '${widget.chatroom.itemphotoURL}',
                      fit: BoxFit.cover,
                    ),
                  )),
            ),
            title: AutoSizeText(
              "Name: ${widget.chatroom.itemname}",
              style: GoogleFonts.inter(
                  fontSize: 14, fontWeight: FontWeight.bold, color: colorWhite),
            ),
            subtitle: AutoSizeText(
              "Ref. ID: ${widget.chatroom.itemID}",
              maxLines: 2,
              style: GoogleFonts.inter(
                  fontSize: 4, fontWeight: FontWeight.w400, color: colorWhite),
            ),
            trailing: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.check_circle_outline_outlined,
                  color: colorWhite,
                )),
          ),
        ),
      ),
    );
  }
}

class Chatflow extends StatelessWidget {
  const Chatflow({
    Key? key,
    required this.onchat,
    required this.chatConvo,
  }) : super(key: key);

  final bool onchat;
  final ChatConvo chatConvo;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: 8, bottom: 8, left: onchat ? 0 : 24, right: onchat ? 24 : 0),
      alignment: onchat ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        children: [
          Container(
            margin: onchat
                ? const EdgeInsets.only(left: 30)
                : const EdgeInsets.only(right: 30),
            padding:
                const EdgeInsets.only(top: 17, bottom: 17, left: 20, right: 20),
            decoration: BoxDecoration(
                borderRadius: onchat
                    ? const BorderRadius.only(
                        topLeft: Radius.circular(23),
                        topRight: Radius.circular(23),
                        bottomLeft: Radius.circular(23))
                    : const BorderRadius.only(
                        topLeft: Radius.circular(23),
                        topRight: Radius.circular(23),
                        bottomRight: Radius.circular(23)),
                color: onchat ? primaryColor : colorblack),
            child: Text("${chatConvo.message}",
                textAlign: TextAlign.start,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'OverpassRegular',
                    fontWeight: FontWeight.w300)),
          )
        ],
      ),
    );
  }
}
