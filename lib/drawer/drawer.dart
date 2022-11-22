//import 'package:lostfoundapp/mainscreen/test.dart';
import 'package:lostfoundapp/mics/packages.dart';

class DrawerPropety extends StatefulWidget {
  const DrawerPropety({
    Key? key,
    required this.widthsize,
  }) : super(key: key);

  final double widthsize;

  @override
  State<DrawerPropety> createState() => _DrawerPropetyState();
}

class _DrawerPropetyState extends State<DrawerPropety> {
  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    final mainSize = MediaQuery.of(context).size.width;

    final mainHSize = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Drawer(
        width: widget.widthsize * 0.60,
        backgroundColor: colorWhite,
        child: Column(
          children: [
            drawerheaderproperty(context),
            buildmenuitem(context, mainSize),
            logout(context, mainHSize),
          ],
        ),
      ),
    );
  }

  Widget logout(BuildContext context, double mainHSize) => Container(
        alignment: Alignment.bottomCenter,
        child: Column(
          children: [
            SizedBox(
              height: mainHSize < 360.0 ? 40 : 60.0,
            ),
            const TextViewPoppins(
                title: "V 1.2.0",
                fontsize: 14,
                fontweight: FontWeight.w700,
                fontcolor: colorblack),
            TextButton(
              onPressed: () {
                signout();
              },
              child: const TextViewPoppins(
                  title: "Log out",
                  fontsize: 13,
                  fontweight: FontWeight.w200,
                  fontcolor: colorblack),
            ),
          ],
        ),
      );

  Widget drawerheaderproperty(BuildContext context) => DrawerHeader(
        margin: const EdgeInsets.all(0),
        padding: const EdgeInsets.all(0),
        child: UserAccountsDrawerHeader(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/background_green.jpg'),
                  fit: BoxFit.cover)),
          onDetailsPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => const ProfilePage())),
          currentAccountPicture: CircleAvatar(
            backgroundImage: NetworkImage('${userlogin!.profileURL}'),
          ),
          margin: const EdgeInsets.all(0),
          accountName: TextViewPoppins(
              title: "${userlogin!.username}",
              fontsize: 13,
              fontweight: FontWeight.bold,
              fontcolor: colorWhite),
          accountEmail: TextViewPoppins(
              title: "${userlogin!.useremail}",
              fontsize: 13,
              fontcolor: colorWhite),
        ),
      );

  Widget buildmenuitem(BuildContext context, double mainSize) => Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            ListTile(
              hoverColor: seconprimaryColor,
              minLeadingWidth: 5,
              onTap: () => Navigator.pop(context),
              leading: const Icon(
                Icons.home_outlined,
                size: 25,
                color: colorblack45,
              ),
              title: TextView(
                  title: 'Home',
                  fontsize: mainSize < 360.0 ? 11 : 14,
                  fontweight: FontWeight.w300,
                  fontcolor: colorblack),
            ),
            ListTile(
              minLeadingWidth: 5,
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ChatRoomPage())),
              leading: const Icon(
                Icons.chat_bubble_outline,
                size: 22,
                color: colorblack45,
              ),
              title: TextView(
                  title: 'Messages',
                  fontsize: mainSize < 360.0 ? 11 : 14,
                  fontweight: FontWeight.w300,
                  fontcolor: colorblack),
            ),
            ListTile(
              minLeadingWidth: 5,
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const NotificationFeed())),
              leading: const Icon(
                Icons.notifications_outlined,
                size: 25,
                color: colorblack45,
              ),
              title: TextView(
                  title: 'Notification',
                  fontsize: mainSize < 360.0 ? 11 : 14,
                  fontweight: FontWeight.w300,
                  fontcolor: colorblack),
            ),
            ListTile(
              minLeadingWidth: 5,
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ArchivePage())),
              leading: const Icon(
                Icons.archive_outlined,
                size: 25,
                color: colorblack45,
              ),
              title: TextView(
                  title: 'Archive',
                  fontsize: mainSize < 360.0 ? 11 : 14,
                  fontweight: FontWeight.w300,
                  fontcolor: colorblack),
            ),
            // ListTile(
            //   minLeadingWidth: 5,
            //   onTap: () => Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: (context) => const SettingsView())),
            //   leading: const Icon(
            //     Icons.settings_outlined,
            //     size: 25,
            //     color: colorblack45,
            //   ),
            //   title: const TextView(
            //       title: 'Test',
            //       fontsize: 14,
            //       fontweight: FontWeight.w300,
            //       fontcolor: colorblack),
            // ),
            ListTile(
              minLeadingWidth: 5,
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ClaimedItemPostPage())),
              leading: const Icon(
                Icons.handshake_outlined,
                size: 25,
                color: colorblack45,
              ),
              title: TextView(
                  title: 'Claimed items',
                  fontsize: mainSize < 360.0 ? 11 : 14,
                  fontweight: FontWeight.w300,
                  fontcolor: colorblack),
            ),
          ],
        ),
      );
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

  Future signout() async {
    final snack = snacbarmessage(context, "Logged out");
    final navigaotr = Navigator.of(context);
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));
    final navpop = Navigator.of(context);
    await FirebaseAuth.instance.signOut();
    await Future.delayed(const Duration(seconds: 2));
    navpop.popUntil((route) => route.isFirst);
    navigaotr.pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const LoginPage()),
        (route) => false);
    snack;
  }
}
