// ignore_for_file: file_names

import 'package:lostfoundapp/mics/packages.dart';

class SliverHomePage extends StatefulWidget {
  const SliverHomePage({super.key});

  @override
  State<SliverHomePage> createState() => _SliverHomePageState();
}

class _SliverHomePageState extends State<SliverHomePage>
    with TickerProviderStateMixin {
  late TabController tabController;
  List<Widget> list = const [
    Tab(
      child: Text(
        "Found Items",
      ),
    ),
    Tab(
      child: Text(
        "Lost Items",
      ),
    ),
    Tab(
      child: Text(
        "Suggestions",
      ),
    ),
  ];

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: colorWhite,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Builder(
            builder: (context) => IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: const Icon(
                  Icons.dehaze_rounded,
                  size: 25,
                  color: colorblack45,
                )),
          ),
        ),
        elevation: 0,
        backgroundColor: colorWhite,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Row(
              children: [
                IconButton(
                    splashRadius: 1,
                    onPressed: () {},
                    icon: const Icon(
                      Icons.search_outlined,
                      color: colorblack45,
                      size: 25,
                    )),
                IconButton(
                    splashRadius: 1.9,
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const NotificationFeed())),
                    icon: const Icon(
                      Icons.notifications_outlined,
                      color: colorblack45,
                      size: 25,
                    )),
                IconButton(
                    splashRadius: 1.9,
                    onPressed: () {},
                    icon: const Icon(
                      Icons.more_vert,
                      color: colorblack45,
                      size: 25,
                    )),
              ],
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10),
        child: NestedScrollView(
          headerSliverBuilder: ((context, innerBoxIsScrolled) {
            return [
              SliverToBoxAdapter(
                child: ListTile(
                  title: const TextViewInter(
                      title: 'Hello,',
                      fontsize: 19,
                      fontweight: FontWeight.bold,
                      fontcolor: colorblack),
                  subtitle: TextViewInter(
                      title: '${userlogin!.username}',
                      fontsize: 23,
                      fontweight: FontWeight.bold,
                      fontcolor: colorblack),
                  trailing: GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProfilePage())),
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: NetworkImage('${userlogin!.profileURL}'),
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Cardpost(widthsize: size),
              ),
              SliverAppBar(
                automaticallyImplyLeading: false,
                backgroundColor: colorWhite,
                elevation: 0,
                toolbarHeight: 45.0,
                pinned: true,
                floating: false,
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(20.0),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: SizedBox(
                      width: size * 0.89,
                      child: TabBar(
                        controller: tabController,
                        unselectedLabelColor: colorblack,
                        tabs: list,
                        labelStyle: GoogleFonts.inter(
                            fontSize: 12, fontWeight: FontWeight.w600),
                        labelColor: colorWhite,
                        indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: colorgreenHue),
                      ),
                    ),
                  ),
                ),
              ),
            ];
          }),
          body: TabBarView(controller: tabController, children: const [
            FoundItems(),
            LostItemTabs(),
            SuggestionItems(),
          ]),
        ),
      ),
      drawer: DrawerPropety(widthsize: size),
    );
  }
}
