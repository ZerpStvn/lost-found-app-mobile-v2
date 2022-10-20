// ignore_for_file: file_names

import 'package:flutter/scheduler.dart';
import 'package:lostfoundapp/mics/packages.dart';

class SuggestionFoundCardPost extends StatefulWidget {
  final UserPostModel userPostModel;
  final double total;
  const SuggestionFoundCardPost(this.userPostModel, this.total, {super.key});

  @override
  State<SuggestionFoundCardPost> createState() =>
      _SuggestionFoundCardPostState();
}

class _SuggestionFoundCardPostState extends State<SuggestionFoundCardPost> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    final sizewidth = MediaQuery.of(context).size.width;
    final String colorValue = "${widget.userPostModel.itemcolor}";
    final int value = int.parse(colorValue);
    final Color colorval = Color(value);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 280,
                child: Stack(
                  children: [
                    Container(
                      width: sizewidth,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  '${widget.userPostModel.phtoURL}'),
                              fit: BoxFit.cover),
                          color: colorblack,
                          borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(30))),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextView(
                      title: "${widget.userPostModel.itemname}",
                      fontsize: 23,
                      fontcolor: colorblack,
                      fontweight: FontWeight.bold,
                    ),
                    const TextView(
                      title: "Item name ",
                      fontcolor: colorgrey,
                      fontweight: FontWeight.bold,
                      fontsize: 14,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Container(
                          height: 30,
                          width: 30,
                          color: colorval,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Container(
                          height: 30,
                          width: 30,
                          color: colorval,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Container(
                          height: 30,
                          width: 30,
                          color: colorval,
                        ),
                      ],
                    ),
                    const TextView(
                      title: "Item color ",
                      fontcolor: colorgrey,
                      fontweight: FontWeight.bold,
                      fontsize: 14,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: primaryColor,
                        ),
                        TextView(
                          title: "${widget.userPostModel.location} ",
                          fontcolor: colorblack,
                          fontweight: FontWeight.bold,
                          fontsize: 14,
                        ),
                      ],
                    ),
                    const TextView(
                      title: "Item location ",
                      fontcolor: colorgrey,
                      fontweight: FontWeight.bold,
                      fontsize: 14,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const TextView(
                      title: "Description ",
                      fontcolor: colorgrey,
                      fontweight: FontWeight.bold,
                      fontsize: 14,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: sizewidth * 0.89,
                      child: ReadMoreText(
                        "${widget.userPostModel.foundlossDes} ",
                        colorClickableText: primaryColor,
                        textAlign: TextAlign.justify,
                        style:
                            GoogleFonts.inter(fontSize: 15, color: colorblack),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    widget.total >= 0.60
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const TextView(
                                title: "Item Description ",
                                fontcolor: colorgrey,
                                fontweight: FontWeight.bold,
                                fontsize: 14,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                width: sizewidth * 0.89,
                                child: ReadMoreText(
                                  "${widget.userPostModel.itemDes} ",
                                  colorClickableText: primaryColor,
                                  textAlign: TextAlign.justify,
                                  style: GoogleFonts.inter(
                                      fontSize: 15, color: colorblack),
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              const TextView(
                                title: "Location ",
                                fontcolor: colorgrey,
                                fontweight: FontWeight.bold,
                                fontsize: 14,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                width: sizewidth * 0.89,
                                child: ReadMoreText(
                                  "${widget.userPostModel.locationDes} ",
                                  colorClickableText: primaryColor,
                                  textAlign: TextAlign.justify,
                                  style: GoogleFonts.inter(
                                      fontSize: 15, color: colorblack),
                                ),
                              ),
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const TextView(
                                title: "Location ",
                                fontcolor: colorgrey,
                                fontweight: FontWeight.bold,
                                fontsize: 14,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                width: sizewidth * 0.89,
                                child: ReadMoreText(
                                  "${widget.userPostModel.locationDes} ",
                                  colorClickableText: primaryColor,
                                  textAlign: TextAlign.justify,
                                  style: GoogleFonts.inter(
                                      fontSize: 15, color: colorblack),
                                ),
                              ),
                            ],
                          ),
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              buildButton(context, sizewidth)
            ],
          ),
        ),
      ),
    );
  }

  Widget buildButton(BuildContext context, double sizewidth) {
    if (widget.userPostModel.userID == user!.uid) {
      return Center(
          child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: SizedBox(
                width: sizewidth,
                height: 50,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 28, 218, 44)),
                      onPressed: () {
                        SchedulerBinding.instance
                            .addPostFrameCallback((timestamp) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      EditTextPost(widget.userPostModel)));
                        });
                      },
                      child: const TextViewInter(
                          title: "EDIT",
                          fontsize: 14,
                          fontweight: FontWeight.bold,
                          fontcolor: colorWhite)),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 1,
              child: SizedBox(
                width: sizewidth,
                height: 50,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor),
                      onPressed: () {
                        deletedata();
                      },
                      child: const TextViewInter(
                          title: "DELETE",
                          fontsize: 14,
                          fontweight: FontWeight.bold,
                          fontcolor: colorWhite)),
                ),
              ),
            ),
          ],
        ),
      ));
    } else {
      return Center(
        child: SizedBox(
          width: sizewidth * 0.88,
          height: 50,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 28, 218, 44)),
                onPressed: () {
                  SchedulerBinding.instance.scheduleFrameCallback((timeStamp) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                SendRequest(widget.userPostModel)));
                  });
                },
                child: const TextViewInter(
                    title: "SEND REQUEST",
                    fontsize: 14,
                    fontweight: FontWeight.bold,
                    fontcolor: colorWhite)),
          ),
        ),
      );
    }
  }

  //using snackbar show the data message==//
  snackBarScreen(BuildContext context, String title) {
    final snack = SnackBar(
      content: Text(
        title,
        style: GoogleFonts.inter(fontSize: 14, color: colorWhite),
      ),
      backgroundColor: colorblack,
    );
    ScaffoldMessenger.of(context).showSnackBar(snack);
  }

  //==========deleting a userpost()=========//
  Future deletedata() async {
    final snack = snackBarScreen(context, "Deleting");
    final snackdone = snackBarScreen(context, "Post deleted");
    final navigator = Navigator.of(context);
    await FirebaseFirestore.instance
        .collection("found_items")
        .doc(user!.uid)
        .collection('fitems')
        .doc(widget.userPostModel.postID)
        .delete()
        .then((value) => debugPrint("data deleted"))
        .catchError((err) => debugPrint("Field to delete data"));
    snack;
    navigator.pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const SliverHomePage()),
        (route) => false);
    snackdone;
  }
}
