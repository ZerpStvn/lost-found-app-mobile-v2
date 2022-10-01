import 'package:lostfoundapp/mics/packages.dart';
import 'package:lostfoundapp/posttabs/founditems.dart';
import 'package:lostfoundapp/posttabs/lostitems.dart';
import 'package:lostfoundapp/posttabs/suggestion.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  int currentIndex = 0;
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
    super.initState();
    tabController = TabController(length: list.length, vsync: this);

    tabController.addListener(() {
      if (mounted) {
        setState(() {
          currentIndex = tabController.index;
        });
      } else {
        dispose();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final widthsize = MediaQuery.of(context).size.width;
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
                  Icons.clear_all_outlined,
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
                    onPressed: () {},
                    icon: const Icon(
                      Icons.search_outlined,
                      color: colorblack45,
                      size: 25,
                    )),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.notifications_outlined,
                      color: colorblack45,
                      size: 25,
                    )),
                IconButton(
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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            profileView(context),
            const SizedBox(
              height: 10.0,
            ),
            Cardpost(widthsize: widthsize),
            const SizedBox(
              height: 21.0,
            ),
            Center(child: tabsection(context)),
          ],
        ),
      ),
      drawer: DrawerPropety(widthsize: widthsize),
    );
  }

  //profileView===//
  Widget profileView(BuildContext context) {
    return ListTile(
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
        onTap: () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ProfilePage())),
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
    );
  }

  Widget tabsection(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.90,
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(30.0),
                color: colorWhite),
            child: TabBar(
              unselectedLabelColor: colorblack,
              tabs: list,
              labelStyle:
                  GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600),
              labelColor: colorWhite,
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: colorgreenHue),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: const TabBarView(children: [
              FoundItems(),
              LostItemTabs(),
              SuggestionItems(),
            ]),
          ),
        ],
      ),
    );
  }
}
