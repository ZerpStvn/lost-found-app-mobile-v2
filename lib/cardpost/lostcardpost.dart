import 'package:flutter/scheduler.dart';
import 'package:lostfoundapp/mics/packages.dart';

class LostCardPost extends StatefulWidget {
  final UserPostModel postModel;
  const LostCardPost(this.postModel, {super.key});

  @override
  State<LostCardPost> createState() => _LostCardPostState();
}

class _LostCardPostState extends State<LostCardPost> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: SizedBox(
        height: 200,
        child: GestureDetector(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      FountItemRequestSender(widget.postModel))),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Card(
              elevation: 10,
              child: Stack(fit: StackFit.expand, children: [
                widget.postModel.phtoURL == "empty"
                    ? Container(
                        color: const Color.fromARGB(141, 66, 73, 69),
                        child: const Center(
                          child: TextViewPoppins(
                              title: "no image",
                              fontsize: 12,
                              fontcolor: colorWhite),
                        ),
                      )
                    : Image.network(
                        "${widget.postModel.phtoURL}",
                        fit: BoxFit.cover,
                        color: const Color.fromARGB(141, 66, 73, 69),
                        colorBlendMode: BlendMode.multiply,
                      ),
                Positioned(
                    top: 10,
                    left: 15,
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage(
                                  "${widget.postModel.userposterPhourl}"))),
                    )),
                Positioned(
                    top: 13,
                    left: 65,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        children: [
                          TextViewPoppins(
                              title: "${widget.postModel.userpostername}",
                              fontsize: 12,
                              fontcolor: colorWhite),
                          TextViewPoppins(
                              title: "${widget.postModel.dateposted!.toDate()}",
                              fontsize: 10,
                              fontcolor: colorWhite),
                        ],
                      ),
                    )),
                Positioned(
                    top: 8,
                    right: 10,
                    child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.more_vert,
                          color: colorWhite,
                        ))),
                Positioned(
                  bottom: 33,
                  left: 10,
                  child: Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        color: colorWhite,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      SizedBox(
                        width: 87,
                        child: AutoSizeText(
                          "${widget.postModel.location}",
                          maxLines: 1,
                          style: GoogleFonts.poppins(
                              fontSize: 12, color: colorWhite),
                        ),
                      ),
                    ],
                  ),
                ),
                const Positioned(
                  bottom: 18,
                  left: 15,
                  child: TextViewPoppins(
                      title: "location last seen",
                      fontsize: 12,
                      fontcolor: colorWhite),
                ),
                Positioned(
                  bottom: 18,
                  right: 15,
                  child: Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.transparent,
                    child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                            side:
                                const BorderSide(width: 2, color: Colors.white),
                            shape: const StadiumBorder()),
                        child: const TextViewPoppins(
                            title: "View",
                            fontsize: 12,
                            fontcolor: colorWhite)),
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
