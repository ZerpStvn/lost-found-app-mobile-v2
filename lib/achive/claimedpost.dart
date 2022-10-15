import 'package:lostfoundapp/mics/packages.dart';

class ClaimedPostPage extends StatelessWidget {
  const ClaimedPostPage({
    Key? key,
    required this.clm,
    required this.tiemformat,
  }) : super(key: key);

  final ClaimedItemModel clm;
  final String tiemformat;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.91,
        height: 180,
        child: Card(
          child: Stack(fit: StackFit.expand, children: [
            clm.phtoURL == "empty"
                ? Image.asset(
                    "assets/background_green.jpg",
                    fit: BoxFit.cover,
                    color: const Color.fromARGB(141, 66, 73, 69),
                    colorBlendMode: BlendMode.multiply,
                  )
                : Image.network(
                    "${clm.phtoURL}",
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
                          image: NetworkImage("${clm.onwerprofileURl}"),
                          fit: BoxFit.cover)),
                )),
            Positioned(
                top: 13,
                left: 65,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        width: 130,
                        child: AutoSizeText(
                          "${clm.ownersname}",
                          maxLines: 1,
                          style: GoogleFonts.poppins(
                              fontSize: 14, color: colorWhite),
                        )),
                    TextViewPoppins(
                        title: tiemformat, fontsize: 10, fontcolor: colorWhite),
                  ],
                )),
            Positioned(
              bottom: 18,
              right: 15,
              child: Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(30),
                color: Colors.transparent,
                child: OutlinedButton(
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ViewClaimedItems(clm))),
                    style: OutlinedButton.styleFrom(
                        side: const BorderSide(width: 2, color: Colors.white),
                        shape: const StadiumBorder()),
                    child: const TextViewPoppins(
                        title: "View", fontsize: 12, fontcolor: colorWhite)),
              ),
            ),
            Positioned(
              bottom: 33,
              left: 10,
              child: Row(
                children: [
                  const Icon(
                    Icons.date_range_outlined,
                    color: colorWhite,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  SizedBox(
                    width: 87,
                    child: AutoSizeText(
                      tiemformat,
                      maxLines: 1,
                      style:
                          GoogleFonts.poppins(fontSize: 12, color: colorWhite),
                    ),
                  ),
                ],
              ),
            ),
            const Positioned(
              bottom: 18,
              left: 15,
              child: TextViewPoppins(
                  title: "Date Claimed", fontsize: 12, fontcolor: colorWhite),
            ),
          ]),
        ),
      ),
    );
  }
}
