import 'package:lostfoundapp/mics/packages.dart';
import 'package:lostfoundapp/model/userdata.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formkey = GlobalKey<FormState>();
  final userAuth = FirebaseAuth.instance;
  String? errormessage;
  String? value;
  bool isloading = false;
  final department = [
    'College of Agriculture, Resources and Environment Sciences',
    'College of Arts & Sciences',
    'College of Business ',
    'College of Computer Studies',
    'College of Education',
    'College of Engineering',
    'College of Hospitality Management',
    'College of Law',
    'College of Medical Labaratory Sciences',
    'College of Medicine',
    'College of Nursing',
    'College of Pharmacy',
    'College of Theology',
  ];

  //department list
  Widget dropdown() {
    return Container(
      padding: const EdgeInsets.only(left: 10),
      height: 60,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.circular(10)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          value: value,
          hint: const TextView(
              title: 'Department',
              fontsize: 14,
              fontweight: FontWeight.normal,
              fontcolor: colorgrey),
          items: department.map(buildMenuItem).toList(),
          onChanged: (value) => setState(() => this.value = value),
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String deparments) => DropdownMenuItem(
      value: deparments,
      child: Text(
        deparments,
        maxLines: 2,
        style: GoogleFonts.montserrat(fontSize: 12, color: colorgrey),
      ));

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

  //create signup
  signup(String email, String password) async {
    if (_formkey.currentState!.validate()) {
      try {
        await userAuth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((uid) => {postDetailsToFireStore(), handleNivagate()})
            .catchError((e) {
          snacbarmessage(context, e!.message);
        });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errormessage = "Your email address appears to be malformed.";
            break;
          case "wrong-password":
            errormessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errormessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errormessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errormessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errormessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errormessage = "An undefined Error happened.";
        }
      }
    }
  }

  //handlesubmit
  handleSubmit(BuildContext context) {
    setState(() {
      isloading = true;
    });
    if (usernamecon.text.isEmpty ||
        schoolIDcon.text.isEmpty ||
        value!.isEmpty ||
        userAddcon.text.isEmpty ||
        useremailcon.text.isEmpty ||
        userpasscon.text.isEmpty) {
      snacbarmessage(context, 'Fill out all the form');
    } else if (confirmpasscon.text != userpasscon.text) {
      snacbarmessage(context, "password did not match");
    } else if (userpasscon.text.length < 6) {
      snacbarmessage(context, "password to short");
    } else if (!RegExp("^[0-9]+-[0-9]+-[0-9]").hasMatch(schoolIDcon.text)) {
      snacbarmessage(context, "Invalid school ID");
    } else if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
        .hasMatch(useremailcon.text)) {
      snacbarmessage(context, "incorrect email address");
    } else {
      snacbarmessage(context, 'Signing In');
      signup(useremailcon.text, userpasscon.text);
    }
    setState(() {
      isloading = false;
    });
  }

  //userNavigation
  handleNivagate() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const UploadProgilePage(),
        ),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    const sizeheight = SizedBox(height: 15.0);
    final sizewidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(top: 45.0, left: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 60,
                width: 60,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: primaryColor,
                ),
              ),
              const TextViewPoppins(
                  title: "Get on Board!",
                  fontsize: 40,
                  fontweight: FontWeight.bold,
                  fontcolor: primaryColor),
              const TextView(
                  title: "Create your profile to start your Journey",
                  fontsize: 14,
                  fontweight: FontWeight.normal,
                  fontcolor: colorgrey),
              sizeheight,
              SizedBox(
                width: sizewidth * 0.88,
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      fname,
                      sizeheight,
                      Row(
                        children: [
                          Expanded(flex: 1, child: schlID),
                          const SizedBox(
                            width: 10.0,
                          ),
                          Expanded(
                            flex: 1,
                            child: dropdown(),
                          ),
                        ],
                      ),
                      sizeheight,
                      usradd,
                      sizeheight,
                      usremail,
                      sizeheight,
                      usrpsswrd,
                      sizeheight,
                      cnfpsswrd,
                    ],
                  ),
                ),
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
                        isloading ? null : handleSubmit(context);
                      },
                      child: const TextView(
                        title: "SIGNUP",
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
                          builder: (context) => const LoginPage()),
                      (route) => false),
                  child: const Center(
                    child: TextView(
                        title: "Already have an account? Signin",
                        fontsize: 14,
                        fontweight: FontWeight.normal,
                        fontcolor: colorblack),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  postDetailsToFireStore() async {
    User? user = userAuth.currentUser;
    UserDataModel usersmodel = UserDataModel();
    usersmodel.useruid = user!.uid;
    usersmodel.username = usernamecon.text;
    usersmodel.schoolID = schoolIDcon.text;
    usersmodel.schoolDept = value;
    usersmodel.useradd = userAddcon.text;
    usersmodel.useremail = useremailcon.text;
    usersmodel.userpassword = userpasscon.text;
    usersmodel.userSchool = "Central Philippine University";
    usersmodel.profileURL = "";

    await userDataRef.doc(user.uid).set(usersmodel.tomap());
    debugPrint("Account created");
  }

  @override
  void dispose() {
    usernamecon.dispose();
    schoolIDcon.dispose();
    userAddcon.dispose();
    useremailcon.dispose();
    userpasscon.dispose();
    confirmpasscon.dispose();
    super.dispose();
  }
}
