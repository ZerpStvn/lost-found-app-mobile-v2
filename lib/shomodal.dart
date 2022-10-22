import 'package:lostfoundapp/edit/updateprofile.dart';
import 'package:lostfoundapp/mics/packages.dart';

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
