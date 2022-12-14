import 'package:lostfoundapp/mics/packages.dart';
import 'package:lostfoundapp/model/userdata.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formkey = GlobalKey<FormState>();
  final userAuth = FirebaseAuth.instance;
  bool psschar = true;
  bool isloading = false;
  String? errorMessage;
  TextEditingController userpassconnew = TextEditingController();
  TextEditingController emailconnew = TextEditingController();

  //snakbarmessage
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

  //handleuserdata
  Future handleuserdate() async {
    final navigate = Navigator.of(context);
    User? users = userAuth.currentUser;
    DocumentSnapshot docs = await userDataRef.doc(users!.uid).get();
    if (docs.exists) {
      userlogin = UserDataModel.fromDocuments(docs);
    }
    userlogin = UserDataModel.fromDocuments(docs);

    navigate.pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const SliverHomePage()),
        (route) => false);
  }

  //signingup
  login(String email, String password) async {
    if (_formkey.currentState!.validate()) {
      try {
        await userAuth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((uid) => {handleuserdate()});
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";

            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        if (mounted) {
          snacbarmessage(context, errorMessage!);
        }
      }
    }
  }

  //handle login
  handlesubmit(BuildContext context) {
    setState(() {
      isloading = true;
    });
    if (userpassconnew.text.isEmpty || emailconnew.text.isEmpty) {
      snacbarmessage(context, 'fill out all the form');
    } else if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
        .hasMatch(emailconnew.text)) {
      snacbarmessage(context, 'You entered invalid email');
    } else if (userpassconnew.text.length < 6) {
      snacbarmessage(context, 'password to short');
    } else {
      snacbarmessage(context, "Signing in");
      login(emailconnew.text, userpassconnew.text);
    }
    setState(() {
      isloading = false;
    });
  }

  @override
  void dispose() {
    userpassconnew.dispose();
    emailconnew.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const sizeheight = SizedBox(height: 15.0);
    final sizewidth = MediaQuery.of(context).size.width;

    final usremailfied = TextFormField(
      controller: emailconnew,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.email),
        labelText: 'Email',
        labelStyle: GoogleFonts.montserrat(fontSize: 14, color: colorgrey),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
      ),
    );
    //passwordlogin
    final lgsswrd = TextFormField(
      controller: userpassconnew,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.done,
      obscureText: psschar,
      decoration: InputDecoration(
        suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                psschar = !psschar;
              });
            },
            icon: psschar
                ? const Icon(
                    Icons.visibility_off,
                    color: colorgrey,
                  )
                : const Icon(
                    Icons.visibility_outlined,
                    color: colorgrey,
                  )),
        prefixIcon: const Icon(Icons.key),
        labelText: 'password',
        labelStyle: GoogleFonts.montserrat(fontSize: 14, color: colorgrey),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
      ),
    );

    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(top: 85.0, left: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 60,
                width: 60,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/banner.png'),
                      fit: BoxFit.cover),
                  shape: BoxShape.circle,
                  color: primaryColor,
                ),
              ),
              const TextViewPoppins(
                  title: "Welcome Back,",
                  fontsize: 35,
                  fontweight: FontWeight.bold,
                  fontcolor: primaryColor),
              const TextView(
                  title: "Make it work, make it right, make it fast",
                  fontsize: 14,
                  fontweight: FontWeight.bold,
                  fontcolor: colorblack),
              const SizedBox(
                height: 50.0,
              ),
              SizedBox(
                width: sizewidth * 0.88,
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      usremailfied,
                      sizeheight,
                      lgsswrd,
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(right: 15.0),
                alignment: Alignment.centerRight,
                child: TextButton(
                    onPressed: () {},
                    child: const TextView(
                        title: "Forgot password ?",
                        fontsize: 14,
                        fontweight: FontWeight.normal,
                        fontcolor: primaryColor)),
              ),
              sizeheight,
              SizedBox(
                height: 55.0,
                width: sizewidth * 0.88,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                      ),
                      onPressed: () {
                        isloading ? null : handlesubmit(context);
                      },
                      child: const TextView(
                        title: "SIGNIN",
                        fontweight: FontWeight.bold,
                        fontcolor: colorWhite,
                        fontsize: 14,
                      )),
                ),
              ),
              TextButton(
                  onPressed: () => Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (conext) => const SignupPage()),
                      (route) => false),
                  child: const Center(
                    child: TextView(
                        title: "Dont have an account? Signup",
                        fontsize: 14,
                        fontweight: FontWeight.normal,
                        fontcolor: colorblack),
                  )),
              const SizedBox(height: 80.0),
              Container(
                alignment: Alignment.bottomCenter,
                child: Column(
                  children: const [
                    TextView(
                      title: 'By using our App you agree to our',
                      fontsize: 14,
                      fontcolor: colorblack,
                      textalign: TextAlign.center,
                    ),
                    TextView(
                      title: 'Terms and Privacy Policy',
                      fontsize: 14,
                      fontweight: FontWeight.bold,
                      fontcolor: colorblack,
                      textalign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
