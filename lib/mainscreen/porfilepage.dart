import 'package:lostfoundapp/mainscreen/tabbarprofile/foundtab.dart';
import 'package:lostfoundapp/mainscreen/tabbarprofile/losttab.dart';
import 'package:lostfoundapp/mics/packages.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
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
  ];

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  var top = 0.0;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: colorWhite,
      body: SafeArea(
          child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              backgroundColor: colorWhite,
              elevation: 0,
              automaticallyImplyLeading: false,
              pinned: true,
              floating: false,
              toolbarHeight: 75,
              expandedHeight: 150,
              actions: [
                IconButton(
                    onPressed: () {
                      handleButtonModalProfile(context);
                    },
                    icon: const Icon(
                      Icons.more_vert_rounded,
                      color: colorWhite,
                    )),
              ],
              flexibleSpace: LayoutBuilder(
                builder: (context, cons) {
                  top = cons.biggest.height;
                  return FlexibleSpaceBar(
                    centerTitle: true,
                    title: AnimatedOpacity(
                      opacity: top <= 100 ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 200),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 11.0),
                        child: Row(children: [
                          IconButton(
                              onPressed: () => Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SliverHomePage()),
                                  (route) => false),
                              icon: const Icon(Icons.arrow_back)),
                          const SizedBox(
                            width: 12,
                          ),
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                              "${userlogin!.profileURL}",
                            ),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          SizedBox(
                            width: 125,
                            child: AutoSizeText(
                              "${userlogin!.username}",
                              maxLines: 2,
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: colorblack),
                            ),
                          ),
                        ]),
                      ),
                    ),
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.asset(
                          "assets/background_green.jpg",
                          fit: BoxFit.cover,
                          color: const Color.fromARGB(141, 66, 73, 69),
                          colorBlendMode: BlendMode.multiply,
                        ),
                        Positioned(
                          bottom: 15.0,
                          left: 12.0,
                          child: Row(children: [
                            SizedBox(
                              height: 60,
                              width: 60,
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(
                                  "${userlogin!.profileURL}",
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            SizedBox(
                              width: 125,
                              child: AutoSizeText(
                                "${userlogin!.username}",
                                maxLines: 2,
                                style: GoogleFonts.inter(
                                    fontSize: 15,
                                    color: colorWhite,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                          ]),
                        ),
                      ],
                    ),
                  );
                },
              ),
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
        },
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TabBarView(
              controller: tabController,
              children: const [FoundItemProfiletab(), LostItemProfileTabs()]),
        ),
      )),
    );
  }
}
