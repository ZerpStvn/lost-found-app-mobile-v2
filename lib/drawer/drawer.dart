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
    return SafeArea(
      child: Drawer(
        width: widget.widthsize * 0.60,
        backgroundColor: colorWhite,
        child: Column(
          children: [
            drawerheaderproperty(context),
            buildmenuitem(context),
            logout(context),
          ],
        ),
      ),
    );
  }

  Widget logout(BuildContext context) => Container(
        alignment: Alignment.bottomCenter,
        child: Column(
          children: [
            const SizedBox(
              height: 60.0,
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

  Widget buildmenuitem(BuildContext context) => Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            ListTile(
              hoverColor: seconprimaryColor,
              minLeadingWidth: 5,
              onTap: () => Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SliverHomePage()),
                  (route) => false),
              leading: const Icon(
                Icons.home_outlined,
                size: 25,
                color: colorblack45,
              ),
              title: const TextView(
                  title: 'Home',
                  fontsize: 14,
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
              title: const TextView(
                  title: 'Messages',
                  fontsize: 14,
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
              title: const TextView(
                  title: 'Notification',
                  fontsize: 14,
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
              title: const TextView(
                  title: 'Archive',
                  fontsize: 14,
                  fontweight: FontWeight.w300,
                  fontcolor: colorblack),
            ),
            // ListTile(
            //   minLeadingWidth: 5,
            //   onTap: () {},
            //   leading: const Icon(
            //     Icons.settings_outlined,
            //     size: 25,
            //     color: colorblack45,
            //   ),
            //   title: const TextView(
            //       title: 'Settings',
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
              title: const TextView(
                  title: 'Claimed items',
                  fontsize: 14,
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
