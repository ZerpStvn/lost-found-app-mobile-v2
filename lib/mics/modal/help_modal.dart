import 'package:lostfoundapp/mics/packages.dart';

String content1 = "Please prived all the need information given in the textbox";
Future handleModal(BuildContext context, String content) async {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const TextView(
            fontcolor: primaryColor,
            title: "Reminder",
            fontweight: FontWeight.bold,
            fontsize: 18,
          ),
          content: TextViewPoppins(
              textalign: TextAlign.justify,
              title: content,
              fontsize: 13,
              fontcolor: colorblack),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
                child: const TextView(
                  fontcolor: primaryColor,
                  title: "OK",
                  fontweight: FontWeight.w500,
                  fontsize: 14,
                )),
          ],
        );
      });
}
