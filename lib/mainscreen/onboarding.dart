import 'package:lostfoundapp/mics/packages.dart';
import 'package:lostfoundapp/registration/loadScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController controller = PageController();
  bool lastpage = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const sizeheight = SizedBox(
      height: 20,
    );
    return Scaffold(
      body: SafeArea(
        child: PageView(
          onPageChanged: (value) {
            setState(() {
              lastpage = value == 3;
            });
          },
          controller: controller,
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 40),
              color: colorWhite,
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 220,
                    width: 220,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage("${userlogin!.profileURL}"),
                    ),
                  ),
                  sizeheight,
                  const TextViewPoppins(
                      title: "Welcome to the",
                      fontweight: FontWeight.bold,
                      fontsize: 25,
                      fontcolor: primaryColor),
                  const TextViewPoppins(
                      title: "Lost and Found Mobile App",
                      fontweight: FontWeight.bold,
                      fontsize: 18,
                      fontcolor: primaryColor),
                  sizeheight,
                  sizeheight,
                  const TextViewPoppins(
                      title:
                          "The centralized platform\nfor lost and found items",
                      fontsize: 15,
                      textalign: TextAlign.center,
                      fontcolor: colorblack),
                ],
              )),
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 40),
              color: colorWhite,
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/onboard1.png'),
                  sizeheight,
                  const TextViewPoppins(
                      title: "Locating Item made easier",
                      fontweight: FontWeight.bold,
                      fontsize: 18,
                      fontcolor: primaryColor),
                  sizeheight,
                  const TextViewPoppins(
                      title:
                          "Finding lost things is\none of the greatest pleasures",
                      fontsize: 15,
                      textalign: TextAlign.center,
                      fontcolor: colorblack),
                ],
              )),
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 40),
              color: colorWhite,
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/onboard3.png'),
                  sizeheight,
                  const TextViewPoppins(
                      title: "Meet them halfway",
                      fontweight: FontWeight.bold,
                      fontsize: 18,
                      fontcolor: primaryColor),
                  sizeheight,
                  const TextViewPoppins(
                      title: "What is yours, will\ncomeback eventually",
                      fontsize: 15,
                      textalign: TextAlign.center,
                      fontcolor: colorblack),
                ],
              )),
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 40),
              color: colorWhite,
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/onboard2.png'),
                  sizeheight,
                  const TextViewPoppins(
                      title: "It's always Here",
                      fontweight: FontWeight.bold,
                      fontsize: 18,
                      fontcolor: primaryColor),
                  sizeheight,
                  const TextViewPoppins(
                      title: "And it's waiting for you",
                      fontsize: 15,
                      textalign: TextAlign.center,
                      fontcolor: colorblack),
                ],
              )),
            ),
          ],
        ),
      ),
      bottomSheet: lastpage
          ? TextButton(
              style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  backgroundColor: colorWhite,
                  minimumSize: const Size.fromHeight(80)),
              onPressed: handleSubmit,
              child: const TextViewPoppins(
                  title: "Get Started", fontsize: 19, fontcolor: primaryColor),
            )
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              height: 75,
              color: colorWhite,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () => controller.jumpToPage(4),
                    child: const TextViewPoppins(
                        title: "SKIP",
                        fontweight: FontWeight.bold,
                        fontsize: 15,
                        fontcolor: primaryColor),
                  ),
                  Center(
                    child: SmoothPageIndicator(
                      controller: controller,
                      count: 4,
                      effect: const WormEffect(
                        spacing: 15,
                        dotColor: seconprimaryColor,
                        activeDotColor: primaryColor,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => controller.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut),
                    child: const TextViewPoppins(
                        title: "NEXT",
                        fontweight: FontWeight.bold,
                        fontsize: 15,
                        fontcolor: primaryColor),
                  ),
                ],
              ),
            ),
    );
  }

  handleSubmit() async {
    final navigator = Navigator.of(context);
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('showHome', true);
    navigator.pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const LoadLoginScreen()),
        (route) => false);
  }
}