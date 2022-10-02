// ignore_for_file: file_names

import 'package:lostfoundapp/mics/packages.dart';

class LostReportOption2 extends StatefulWidget {
  const LostReportOption2({super.key});

  @override
  State<LostReportOption2> createState() => _LostReportOption2State();
}

class _LostReportOption2State extends State<LostReportOption2> {
  @override
  Widget build(BuildContext context) {
    final widthsize = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            const SubmitReportForm(),
            Padding(
              padding: const EdgeInsets.only(bottom: 18.0),
              child: Center(
                child: SizedBox(
                  width: widthsize * 0.89,
                  height: 50,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                        ),
                        onPressed: () {},
                        child: const Center(
                          child: TextViewInter(
                            title: "SUBMIT",
                            fontsize: 14,
                            fontcolor: colorWhite,
                            fontweight: FontWeight.bold,
                          ),
                        )),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
