// ignore_for_file: file_names

import 'package:lostfoundapp/mics/packages.dart';
import 'package:readmore/readmore.dart';

class LostItemRequestSender extends StatefulWidget {
  final UserPostModel userPostModel;
  const LostItemRequestSender(this.userPostModel, {super.key});

  @override
  State<LostItemRequestSender> createState() => _LostItemRequestSenderState();
}

class _LostItemRequestSenderState extends State<LostItemRequestSender> {
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    final sizewidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 280,
              child: Stack(
                children: [
                  Container(
                    height: 280,
                    width: sizewidth,
                    decoration: BoxDecoration(
                        image: widget.userPostModel.phtoURL == "empty"
                            ? const DecorationImage(
                                image:
                                    AssetImage('assets/background_green.jpg'),
                                fit: BoxFit.cover)
                            : DecorationImage(
                                image: NetworkImage(
                                    '${widget.userPostModel.phtoURL}'),
                                fit: BoxFit.cover),
                        color: colorblack,
                        borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(30))),
                    child: widget.userPostModel.phtoURL == "empty"
                        ? const Center(
                            child: TextView(
                              title: "No image",
                              fontsize: 14,
                              fontcolor: colorWhite,
                              fontweight: FontWeight.bold,
                            ),
                          )
                        : Container(),
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
                        color: Colors.green,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Container(
                        height: 30,
                        width: 30,
                        color: Colors.green,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Container(
                        height: 30,
                        width: 30,
                        color: Colors.green,
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
                      const SizedBox(
                        width: 5,
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
                      style: GoogleFonts.montserrat(
                          fontSize: 15, color: colorblack),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 55,
            ),
            buildButton(context, sizewidth)
          ],
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
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 28, 218, 44)),
                    onPressed: () {},
                    child: const TextView(
                        title: "EDIT",
                        fontsize: 14,
                        fontweight: FontWeight.bold,
                        fontcolor: colorWhite)),
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
                child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: primaryColor),
                    onPressed: () {},
                    child: const TextView(
                        title: "DELETE",
                        fontsize: 14,
                        fontweight: FontWeight.bold,
                        fontcolor: colorWhite)),
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
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 28, 218, 44)),
              onPressed: () {},
              child: const TextView(
                  title: "SEND REQUEST",
                  fontsize: 14,
                  fontweight: FontWeight.bold,
                  fontcolor: colorWhite)),
        ),
      );
    }
  }
}
