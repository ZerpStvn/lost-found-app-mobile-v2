import 'package:lostfoundapp/mics/packages.dart';

class RequestForm extends StatelessWidget {
  const RequestForm({super.key});

  @override
  Widget build(BuildContext context) {
    final widthsize = MediaQuery.of(context).size.width;
    const sizeheight = SizedBox(height: 10);
    return Padding(
      padding: const EdgeInsets.only(left: 18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              TextViewInter(
                title: "PESONAL INFO",
                fontcolor: primaryColor,
                fontsize: 15,
                fontweight: FontWeight.bold,
              ),
              Padding(
                padding: EdgeInsets.only(left: 5.0),
                child: Icon(
                  Icons.help_outline,
                  color: primaryColor,
                  size: 18,
                ),
              )
            ],
          ),
          sizeheight,
          SizedBox(
            width: widthsize * 0.89,
            child: requsername,
          ),
          sizeheight,
          SizedBox(
            width: widthsize * 0.89,
            child: requserID,
          ),
          sizeheight,
          SizedBox(
            width: widthsize * 0.89,
            child: reqDept,
          ),
          const SizedBox(
            height: 28.0,
          ),
          Row(
            children: const [
              TextViewInter(
                title: "ITEM DETIALS",
                fontcolor: primaryColor,
                fontsize: 15,
                fontweight: FontWeight.bold,
              ),
              Padding(
                padding: EdgeInsets.only(left: 5.0),
                child: Icon(
                  Icons.help_outline,
                  color: primaryColor,
                  size: 18,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 15.0,
          ),
          SizedBox(
            width: widthsize * 0.89,
            child: reqitemtitle,
          ),
          sizeheight,
          SizedBox(
            width: widthsize * 0.89,
            child: const DateTimepicker('Date found'),
          ),
          sizeheight,
          SizedBox(
            width: widthsize * 0.89,
            height: 5 * 25.0,
            child: reqitemdescription,
          ),
          sizeheight,
          Row(
            children: const [
              TextViewInter(
                title: "LOCATIONS",
                fontcolor: primaryColor,
                fontsize: 15,
                fontweight: FontWeight.bold,
              ),
              Padding(
                padding: EdgeInsets.only(left: 5.0),
                child: Icon(
                  Icons.help_outline,
                  color: primaryColor,
                  size: 18,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15.0,
          ),
          SizedBox(
            width: widthsize * 0.89,
            child: reqitemlocation,
          ),
          sizeheight,
          SizedBox(
            width: widthsize * 0.89,
            height: 5 * 25.0,
            child: reqitemlocationDescription,
          ),
          sizeheight,
          Row(
            children: const [
              TextViewInter(
                title: "DESCRIPTIONS",
                fontcolor: primaryColor,
                fontsize: 15,
                fontweight: FontWeight.bold,
              ),
              Padding(
                padding: EdgeInsets.only(left: 5.0),
                child: Icon(
                  Icons.help_outline,
                  color: primaryColor,
                  size: 18,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15.0,
          ),
          SizedBox(
            width: widthsize * 0.89,
            height: 5 * 25.0,
            child: reqfounlossdDescription,
          ),
          sizeheight,
          Row(
            children: const [
              TextViewInter(
                title: "CONTACTS",
                fontcolor: primaryColor,
                fontsize: 15,
                fontweight: FontWeight.bold,
              ),
              Padding(
                padding: EdgeInsets.only(left: 5.0),
                child: Icon(
                  Icons.help_outline,
                  color: primaryColor,
                  size: 18,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15.0,
          ),
          SizedBox(
            width: widthsize * 0.89,
            child: reqmobilenumber,
          ),
          const SizedBox(height: 29),
          Row(
            children: const [
              TextViewInter(
                title: "ITEMS",
                fontcolor: primaryColor,
                fontsize: 15,
                fontweight: FontWeight.bold,
              ),
              Padding(
                padding: EdgeInsets.only(left: 5.0),
                child: Icon(
                  Icons.help_outline,
                  color: primaryColor,
                  size: 18,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15.0,
          ),
          SizedBox(
            width: widthsize * 0.89,
            child: reqitemmodel,
          ),
          sizeheight,
          SizedBox(
            width: widthsize * 0.89,
            child: reqitembrand,
          ),
          const SizedBox(height: 29),
          Row(
            children: const [
              TextViewInter(
                title: "OTHERS",
                fontcolor: primaryColor,
                fontsize: 15,
                fontweight: FontWeight.bold,
              ),
              Padding(
                padding: EdgeInsets.only(left: 5.0),
                child: Icon(
                  Icons.help_outline,
                  color: primaryColor,
                  size: 18,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15.0,
          ),
          SizedBox(
            width: widthsize * 0.89,
            child: reqmarkings,
          ),
          sizeheight,
          SizedBox(
            width: widthsize * 0.89,
            height: 5 * 25.0,
            child: messagefield,
          ),
        ],
      ),
    );
  }
}
