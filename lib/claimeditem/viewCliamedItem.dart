// ignore_for_file: file_names

import 'package:intl/intl.dart';
import 'package:lostfoundapp/mics/packages.dart';

class ViewClaimedItems extends StatefulWidget {
  final ClaimedItemModel clm;
  const ViewClaimedItems(this.clm, {super.key});

  @override
  State<ViewClaimedItems> createState() => _ViewClaimedItemsState();
}

class _ViewClaimedItemsState extends State<ViewClaimedItems> {
  @override
  Widget build(BuildContext context) {
    Timestamp timestamp = widget.clm.claimedDate as Timestamp;
    final DateTime timeDate = timestamp.toDate();
    final tiemformat = DateFormat('M/d/y KK:mm').format(timeDate);
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 280,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  widget.clm.phtoURL == "empty"
                      ? Image.asset(
                          "assets/background_green.jpg",
                          fit: BoxFit.cover,
                        )
                      : Image.network(
                          "${widget.clm.phtoURL}}",
                          fit: BoxFit.cover,
                        ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      width: 220,
                      child: Text(
                        "${widget.clm.postID}",
                        maxLines: 1,
                        style: GoogleFonts.montserrat(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      )),
                  const TextView(
                    title: "Reference ID ",
                    fontcolor: colorgrey,
                    fontweight: FontWeight.bold,
                    fontsize: 14,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  SizedBox(
                      width: 220,
                      child: Text(
                        tiemformat,
                        maxLines: 1,
                        style: GoogleFonts.montserrat(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      )),
                  Row(
                    children: const [
                      Icon(Icons.calendar_month_outlined),
                      TextView(
                        title: "Date Claimed ",
                        fontcolor: colorgrey,
                        fontweight: FontWeight.bold,
                        fontsize: 14,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  SizedBox(
                      width: 220,
                      child: Text(
                        "${widget.clm.claimername}",
                        maxLines: 2,
                        style: GoogleFonts.montserrat(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      )),
                  Row(
                    children: const [
                      Icon(Icons.person_outline),
                      TextView(
                        title: "Owner's name ",
                        fontcolor: colorgrey,
                        fontweight: FontWeight.bold,
                        fontsize: 14,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  SizedBox(
                      width: 220,
                      child: Text(
                        widget.clm.userID == userlogin!.useruid ||
                                userlogin!.useremail == "steve1@gmail.com"
                            ? "${widget.clm.claimerID}"
                            : "**-****-**",
                        maxLines: 2,
                        style: GoogleFonts.montserrat(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      )),
                  Row(
                    children: const [
                      Icon(Icons.person_outline),
                      TextView(
                        title: "School ID",
                        fontcolor: colorgrey,
                        fontweight: FontWeight.bold,
                        fontsize: 14,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  SizedBox(
                      width: 220,
                      child: Text(
                        "${widget.clm.claimerdepartment}",
                        maxLines: 2,
                        style: GoogleFonts.montserrat(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      )),
                  Row(
                    children: const [
                      Icon(Icons.school_outlined),
                      TextView(
                        title: "Department ",
                        fontcolor: colorgrey,
                        fontweight: FontWeight.bold,
                        fontsize: 14,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  widget.clm.userID == userlogin!.useruid ||
                          userlogin!.useremail == "steve1@gmail.com"
                      ? Column(
                          children: [
                            Row(
                              children: const [
                                Icon(Icons.verified_outlined),
                                TextView(
                                  title: "Image verification",
                                  fontcolor: colorgrey,
                                  fontweight: FontWeight.bold,
                                  fontsize: 14,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 220,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          "${widget.clm.claimerPhotoURL}"),
                                      fit: BoxFit.cover)),
                            )
                          ],
                        )
                      : Container(),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
