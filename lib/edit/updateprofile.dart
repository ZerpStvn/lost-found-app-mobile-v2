import 'package:lostfoundapp/mics/packages.dart';
import 'package:lostfoundapp/model/userdata.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final TextEditingController editusernamecon = TextEditingController();
  final TextEditingController editschoolIDcon = TextEditingController();
  final TextEditingController edituserAddcon = TextEditingController();
  final TextEditingController edituseremailcon = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  final userAuth = FirebaseAuth.instance;
  bool onchange = false;
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
  updateEmail(String email) async {
    if (_formkey.currentState!.validate()) {
      try {
        await userAuth.currentUser!
            .updateEmail(email)
            .then((uid) => debugPrint("useremail updated"))
            .catchError((e) {
          snacbarmessage(context, e!.message);
        });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errormessage = "Your email address appears to be malformed.";
            break;
          case "too-many-requests":
            errormessage = "Too many requests";
            break;
          default:
            errormessage = "An undefined Error happened.";
        }
      }
    }
  }

  updatepassword(String password) async {
    if (_formkey.currentState!.validate()) {
      await userAuth.currentUser!
          .updatePassword(password)
          .then((uid) => debugPrint("password updated"));
    }
  }

  //handlesubmit
  handleSubmit(BuildContext context) {
    setState(() {
      isloading = true;
    });
    if (editusernamecon.text.isEmpty ||
        editschoolIDcon.text.isEmpty ||
        value!.isEmpty ||
        edituserAddcon.text.isEmpty ||
        edituseremailcon.text.isEmpty) {
      snacbarmessage(context, 'Fill out all the form');
    } else if (!RegExp("^[0-9]+-[0-9]+-[0-9]").hasMatch(editschoolIDcon.text)) {
      snacbarmessage(context, "Invalid school ID");
    } else if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
        .hasMatch(edituseremailcon.text)) {
      snacbarmessage(context, "incorrect email address");
    } else {
      snacbarmessage(context, 'Updating');

      postDetailsToFireStore();
      updateEmail(edituseremailcon.text);
    }
    setState(() {
      isloading = false;
    });
  }

  handledata() {
    editusernamecon.text = "${userlogin!.username}";
    editschoolIDcon.text = "${userlogin!.schoolID}";
    edituserAddcon.text = "${userlogin!.useradd}";
    value = "${userlogin!.schoolDept}";
    edituseremailcon.text = "${userlogin!.useremail}";
  }

  bool passchar = true;
  @override
  void initState() {
    handledata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const sizeheight = SizedBox(height: 15.0);
    final sizewidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                        image: DecorationImage(
                            image: AssetImage("assets/banner.png"))),
                  ),
                  const TextViewPoppins(
                      title: "Update Profile!",
                      fontsize: 40,
                      fontweight: FontWeight.bold,
                      fontcolor: primaryColor),
                  sizeheight,
                  SizedBox(
                    width: sizewidth * 0.88,
                    child: Form(
                      key: _formkey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: editusernamecon,
                            textCapitalization: TextCapitalization.values.first,
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.person),
                              labelText: 'Full name',
                              labelStyle: GoogleFonts.montserrat(
                                  fontSize: 14, color: colorgrey),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                            ),
                          ),
                          sizeheight,
                          Row(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: TextFormField(
                                    controller: editschoolIDcon,
                                    keyboardType: TextInputType.name,
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(Icons.description),
                                      labelText: 'School ID',
                                      labelStyle: GoogleFonts.montserrat(
                                          fontSize: 14, color: colorgrey),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                    ),
                                  )),
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
                          TextFormField(
                              controller: edituserAddcon,
                              textCapitalization:
                                  TextCapitalization.values.first,
                              keyboardType: TextInputType.name,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.location_on),
                                labelText: 'Complete address',
                                labelStyle: GoogleFonts.montserrat(
                                    fontSize: 14, color: colorgrey),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                              )),
                          sizeheight,
                          TextFormField(
                            controller: edituseremailcon,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.email),
                              labelText: 'Email',
                              labelStyle: GoogleFonts.montserrat(
                                  fontSize: 14, color: colorgrey),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                            ),
                          ),
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
                            title: "UPDATE",
                            fontweight: FontWeight.bold,
                            fontcolor: colorWhite,
                            fontsize: 14,
                          )),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }

  handleupadatefunction() async {
    final navpop = Navigator.of(context);
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));
    navpop.popUntil((route) => route.isFirst);
    await FirebaseAuth.instance.signOut().then((value) =>
        navpop.pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const LoginPage()),
            (route) => false));
  }

  postDetailsToFireStore() async {
    final snack = snacbarmessage(context, "Profile updated");
    User? user = userAuth.currentUser;
    UserDataModel usersmodel = UserDataModel();
    usersmodel.useruid = user!.uid;
    usersmodel.username = editusernamecon.text;
    usersmodel.schoolID = editschoolIDcon.text;
    usersmodel.schoolDept = value;
    usersmodel.useradd = edituserAddcon.text;
    usersmodel.useremail = edituseremailcon.text;
    usersmodel.userSchool = "Central Philippine University";
    usersmodel.profileURL = userlogin!.profileURL;

    await userDataRef.doc(user.uid).update(usersmodel.tomap()).then((value) {
      handleupadatefunction();
    });
    debugPrint("Account updated");
    snack;
  }

  @override
  void dispose() {
    editusernamecon.dispose();
    editschoolIDcon.dispose();
    edituserAddcon.dispose();
    edituseremailcon.dispose();
    super.dispose();
  }
}
