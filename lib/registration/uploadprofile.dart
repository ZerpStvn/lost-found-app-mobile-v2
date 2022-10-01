import 'package:lostfoundapp/mics/packages.dart';

class UploadProgilePage extends StatefulWidget {
  const UploadProgilePage({super.key});

  @override
  State<UploadProgilePage> createState() => _UploadProgilePageState();
}

class _UploadProgilePageState extends State<UploadProgilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LoginPage())),
              child: const Text("Login"))
        ],
      ),
    );
  }
}
