import 'package:lostfoundapp/mics/packages.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController emailtext = TextEditingController();
  @override
  void dispose() {
    emailtext.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.89,
                child: Column(
                  children: [
                    const TextViewInter(
                        title: "Email will be sent to you",
                        fontsize: 14,
                        fontweight: FontWeight.bold,
                        fontcolor: colorblack),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: emailtext,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.email_outlined,
                            color: primaryColor,
                          ),
                          label: const Text("Email"),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.50,
                        height: 45,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                            ),
                            onPressed: () {
                              handleReset();
                            },
                            child: const Text("Reset password")))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

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

  Future handleReset() async {
    final snacksent = snacbarmessage(context, "password reset email sent");
    final navpop = Navigator.of(context);
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailtext.text.trim())
          .then((value) => snacksent);
      navpop.popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch (e) {
      snacbarmessage(context, e.message!);
      navpop.pop();
    }
  }
}
