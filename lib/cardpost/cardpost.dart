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
                          title:
                              "Meet them halfway what's yours will comeback eventually.",
                          fontsize: 15,
                          fontweight: FontWeight.normal,
                          fontcolor: colorWhite),
                      Padding(
                        padding: const EdgeInsets.only(top: 17.0),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColor),
                            onPressed: () {
                              handleButtonModal(context);
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

Future handleButtonModal(BuildContext context) async {
  return (await showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.only(top: 11.0, bottom: 11.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.description_outlined),
                title: const TextView(
                    title: "Report found item",
                    fontsize: 13,
                    fontweight: FontWeight.w500,
                    fontcolor: colorblack),
                onTap: () {
                  Navigator.of(context, rootNavigator: true).pop();
                  SchedulerBinding.instance.scheduleFrameCallback((timeStamp) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const FoundReportPage()));
                  });
                },
              ),
              ListTile(
                leading: const Icon(Icons.description_outlined),
                title: const TextView(
                    title: "Report lost item",
                    fontsize: 13,
                    fontweight: FontWeight.w500,
                    fontcolor: colorblack),
                onTap: () {
                  Navigator.of(context, rootNavigator: true).pop();
                  handleOption(context);
                },
              ),
            ],
          ),
        );
      }));
}
