// ignore_for_file: file_names
import 'package:lostfoundapp/mics/packages.dart';

const colorWhite = Colors.white;
const colorblack = Colors.black;
const colorblack45 = Colors.black45;
const colorgrey = Colors.grey;
const primaryColor = Color(0xff23B574);
const seconprimaryColor = Color(0xff9FFDD2);

//const second = Color(4294561908);
const er = Color(0xff26252d);
const colorgreenHue = Color.fromARGB(255, 27, 250, 101);

class TextView extends StatelessWidget {
  const TextView(
      {super.key,
      required this.title,
      required this.fontsize,
      this.fontweight,
      required this.fontcolor,
      this.textalign});
  final String title;
  final double fontsize;
  final FontWeight? fontweight;
  final Color fontcolor;
  final TextAlign? textalign;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: textalign,
      style: GoogleFonts.montserrat(
          fontSize: fontsize, fontWeight: fontweight, color: fontcolor),
    );
  }
}

class TextViewPoppins extends StatelessWidget {
  const TextViewPoppins(
      {super.key,
      required this.title,
      required this.fontsize,
      this.fontweight,
      required this.fontcolor,
      this.textalign});
  final String title;
  final double fontsize;
  final FontWeight? fontweight;
  final Color fontcolor;

  final TextAlign? textalign;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: textalign,
      style: GoogleFonts.poppins(
          fontSize: fontsize, fontWeight: fontweight, color: fontcolor),
    );
  }
}

class TextViewInter extends StatelessWidget {
  const TextViewInter(
      {super.key,
      required this.title,
      required this.fontsize,
      this.fontweight,
      required this.fontcolor,
      this.alignment});
  final String title;
  final double fontsize;
  final FontWeight? fontweight;
  final Color fontcolor;
  final TextAlign? alignment;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: alignment,
      style: GoogleFonts.inter(
          fontSize: fontsize, fontWeight: fontweight, color: fontcolor),
    );
  }
}
