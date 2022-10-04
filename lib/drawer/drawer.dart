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
              onPressed: () {},
              child: const TextViewPoppins(
                  title: "Logout",
                  fontsize: 13,
                  fontweight: FontWeight.w200,
                  fontcolor: colorblack),
            )
          ],
        ),
      );

  Widget drawerheaderproperty(BuildContext context) => DrawerHeader(
        margin: const EdgeInsets.all(0),
        padding: const EdgeInsets.all(0),
        child: UserAccountsDrawerHeader(
          currentAccountPicture: GestureDetector(
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ProfilePage())),
            child: CircleAvatar(
              backgroundImage: NetworkImage('${userlogin!.profileURL}'),
            ),
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
                onTap: () {},
                leading: const Icon(
                  Icons.home_outlined,
                  size: 25,
                  color: colorblack45,
                ),
                title: const TextView(
                    title: 'Home',
                    fontsize: 14,
                    fontweight: FontWeight.w300,
                    fontcolor: colorblack)),
            ListTile(
              minLeadingWidth: 5,
              onTap: () {},
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
              onTap: () {},
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
              onTap: () {},
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
            ListTile(
              minLeadingWidth: 5,
              onTap: () {},
              leading: const Icon(
                Icons.settings_outlined,
                size: 25,
                color: colorblack45,
              ),
              title: const TextView(
                  title: 'Settings',
                  fontsize: 14,
                  fontweight: FontWeight.w300,
                  fontcolor: colorblack),
            ),
          ],
        ),
      );
}
