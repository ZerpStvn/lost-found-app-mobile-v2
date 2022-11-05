// import 'package:lostfoundapp/mics/packages.dart';

// class SettingsView extends StatefulWidget {
//   const SettingsView({super.key});

//   @override
//   State<SettingsView> createState() => _SettingsViewState();
// }

// class _SettingsViewState extends State<SettingsView> {
//   final TextEditingController textt = TextEditingController();

//   check() {
//     if (!RegExp("^[0-9]{2}-[0-9]{4}-[0-9]{2}").hasMatch(textt.text)) {
//       debugPrint("fale");
//     } else {
//       debugPrint("True");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           TextFormField(
//             controller: textt,
//           ),
//           ElevatedButton(onPressed: check, child: const Text("Night Mode")),
//         ],
//       ),
//     );
//   }
// }
