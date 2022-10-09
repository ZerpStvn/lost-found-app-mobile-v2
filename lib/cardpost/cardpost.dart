import 'package:flutter/scheduler.dart';
import 'package:lostfoundapp/mics/packages.dart';

class Cardpost extends StatelessWidget {
  const Cardpost({
    Key? key,
    required this.widthsize,
  }) : super(key: key);

  final double widthsize;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        alignment: Alignment.center,
        width: widthsize * 0.91,
        height: 180,
        color: colorgreenHue,
        child: Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Stack(
            children: [
              Positioned(
                top: 30,
                left: 10,
                child: Container(
                  height: 120,
                  width: 120,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: seconprimaryColor,
                  ),
                ),
              ),
              Image.asset('assets/person.png'),
              Padding(
                padding: const EdgeInsets.only(left: 120.0),
                child: ListTile(
                  title: const TextViewInter(
                      title: 'Lost and Found',
                      fontsize: 23,
                      fontweight: FontWeight.bold,
                      fontcolor: colorWhite),
                  subtitle: Column(
                    children: [
                      const TextViewInter(
                          title: 'Lorem ipsum dolor sit amet consec elit.',
                          fontsize: 15,
                          fontweight: FontWeight.normal,
                          fontcolor: colorWhite),
                      Padding(
                        padding: const EdgeInsets.only(top: 26.0),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColor),
                            onPressed: () {
                              shoowDialog(context);
                            },
                            child: const Center(
                              child: TextViewInter(
                                  title: 'Create Post',
                                  fontsize: 13,
                                  fontweight: FontWeight.normal,
                                  fontcolor: colorWhite),
                            )),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future timerdelay(BuildContext context) async {
  await Future.delayed(const Duration(milliseconds: 1000));
}

handlefoundNavigate(BuildContext context) {
  timerdelay(context);
  Navigator.of(context).pop(true);
}

Future shoowDialog(BuildContext context) async {
  await showDialog(
      context: context,
      builder: (context) => SimpleDialog(
            backgroundColor: colorWhite,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: const TextView(
                title: "Choose Options",
                fontsize: 17,
                fontweight: FontWeight.bold,
                fontcolor: colorblack),
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                  SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const FoundReportPage()));
                  });
                },
                child: const TextView(
                    title: "Report Found item",
                    fontsize: 13,
                    fontweight: FontWeight.w500,
                    fontcolor: colorblack),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                  handleOption(context);
                },
                child: const TextView(
                    title: "Report lost item",
                    fontsize: 13,
                    fontweight: FontWeight.w500,
                    fontcolor: colorblack),
              ),
            ],
          ));
}

Future handleOption(BuildContext context) async {
  return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const TextView(
            title: "options",
            fontsize: 18,
            fontcolor: primaryColor,
            fontweight: FontWeight.bold,
          ),
          content: const TextView(
            title: "Do you have an image? ",
            fontsize: 15,
            fontcolor: primaryColor,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
                SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LostReportOption2()));
                });
              },
              child: const TextView(
                title: "No",
                fontsize: 18,
                fontcolor: primaryColor,
                fontweight: FontWeight.w500,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
                SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LostReportPage()));
                });
              },
              child: const TextView(
                title: "Yes",
                fontsize: 18,
                fontcolor: primaryColor,
                fontweight: FontWeight.w500,
              ),
            ),
          ],
        );
      });
}
