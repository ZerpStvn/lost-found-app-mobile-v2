import 'package:lostfoundapp/edit/updateprofile.dart';
import 'package:lostfoundapp/mics/packages.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future handleButtonModalOption(BuildContext context) async {
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
                leading: const Icon(Icons.person_outline),
                title: const TextView(
                    title: "View Profile",
                    fontsize: 13,
                    fontweight: FontWeight.w500,
                    fontcolor: colorblack),
                onTap: () {
                  Navigator.of(context, rootNavigator: true).pop();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProfilePage()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout_outlined),
                title: const TextView(
                    title: "Logout",
                    fontsize: 13,
                    fontweight: FontWeight.w500,
                    fontcolor: colorblack),
                onTap: () {
                  Navigator.of(context, rootNavigator: true).pop();
                  FirebaseAuth.instance.signOut();
                  snacbarmessage(context, "Logged out");
                  Future.delayed(const Duration(milliseconds: 2000));
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                      (route) => false);
                },
              )
            ],
          ),
        );
      }));
}

snacbarmessage(BuildContext context, String title) {
  final snack = SnackBar(
    content: TextView(
      title: title,
      fontcolor: colorWhite,
      fontsize: 12,
      fontweight: FontWeight.normal,
    ),
    backgroundColor: colorblack,
  );
  ScaffoldMessenger.of(context).showSnackBar(snack);
}

Future handleButtonModalProfile(BuildContext context) async {
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
                leading: const Icon(Icons.person_outline),
                title: const TextView(
                    title: "Edit Profile",
                    fontsize: 13,
                    fontweight: FontWeight.w500,
                    fontcolor: colorblack),
                onTap: () {
                  Navigator.of(context, rootNavigator: true).pop();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const UpdateProfile()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout_outlined),
                title: const TextView(
                    title: "Logout",
                    fontsize: 13,
                    fontweight: FontWeight.w500,
                    fontcolor: colorblack),
                onTap: () {
                  Navigator.of(context, rootNavigator: true).pop();
                  FirebaseAuth.instance.signOut();
                  snacbarmessage(context, "Logged out");
                  Future.delayed(const Duration(milliseconds: 2000));
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                      (route) => false);
                },
              )
            ],
          ),
        );
      }));
}

Future showdescriptionModal(BuildContext context) async {
  //const duration = Duration(seconds: 6);
  return (await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Reminder",
            style: GoogleFonts.inter(
                fontSize: 18, color: primaryColor, fontWeight: FontWeight.bold),
          ),
          content: Text(
            "PRO TIPS!\n(for success and accuracy of potential matches)\n\n1. Fill-in as much details as possible\n\n2. Double check grammar and spelling\n\n3. Make sure to post clear pictures of the lost/found item.",
            style: GoogleFonts.inter(
              fontSize: 14,
              color: colorblack,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: TextButton(
                onPressed: () =>
                    Navigator.of(context, rootNavigator: true).pop(),
                child: Text(
                  "Continue",
                  style: GoogleFonts.inter(
                      fontSize: 18,
                      color: primaryColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        );
      }));
}

Future onAccept(BuildContext context) async {
  //const duration = Duration(seconds: 6);
  return (await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Reminder",
            style: GoogleFonts.inter(
                fontSize: 18, color: primaryColor, fontWeight: FontWeight.bold),
          ),
          content: Text(
            "SAFETY AND GUIDELINES!\n\n1. Meet-up at public areas (Malls, School, etc.)\n\n2. To avoid scams, make sure to review information given is accurate by the person you are transacting with.\n\n3. Make sure that the person you are dealing with is a certified student of your university.",
            style: GoogleFonts.inter(
              fontSize: 14,
              color: colorblack,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: TextButton(
                onPressed: () =>
                    Navigator.of(context, rootNavigator: true).pop(),
                child: Text(
                  "Continue",
                  style: GoogleFonts.inter(
                      fontSize: 18,
                      color: primaryColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        );
      }));
}
