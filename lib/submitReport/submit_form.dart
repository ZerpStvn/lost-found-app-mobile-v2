import 'package:lostfoundapp/mics/modal/help_modal.dart';
import 'package:lostfoundapp/mics/packages.dart';

class SubmitReportForm extends StatefulWidget {
  const SubmitReportForm({super.key});

  @override
  State<SubmitReportForm> createState() => _SubmitReportFormState();
}

class _SubmitReportFormState extends State<SubmitReportForm> {
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
            children: [
              const TextViewInter(
                title: "ITEM DETIALS",
                fontcolor: primaryColor,
                fontsize: 15,
                fontweight: FontWeight.bold,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: IconButton(
                    onPressed: () {
                      handleModal(context, content1);
                    },
                    icon: const Icon(
                      Icons.help_outline,
                      color: primaryColor,
                      size: 18,
                    )),
              )
            ],
          ),
          SizedBox(
            width: widthsize * 0.89,
            child: itemtitle,
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
            child: itemdescription,
          ),
          Row(
            children: [
              const TextViewInter(
                title: "LOCATIONS",
                fontcolor: primaryColor,
                fontsize: 15,
                fontweight: FontWeight.bold,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.help_outline,
                      color: primaryColor,
                      size: 18,
                    )),
              ),
            ],
          ),
          SizedBox(
            width: widthsize * 0.89,
            child: itemlocation,
          ),
          sizeheight,
          SizedBox(
            width: widthsize * 0.89,
            height: 5 * 25.0,
            child: itemlocationDescription,
          ),
          Row(
            children: [
              const TextViewInter(
                title: "DESCRIPTIONS",
                fontcolor: primaryColor,
                fontsize: 15,
                fontweight: FontWeight.bold,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.help_outline,
                      color: primaryColor,
                      size: 18,
                    )),
              ),
            ],
          ),
          SizedBox(
            width: widthsize * 0.89,
            height: 5 * 25.0,
            child: founlossdDescription,
          ),
          Row(
            children: [
              const TextViewInter(
                title: "CONTACTS",
                fontcolor: primaryColor,
                fontsize: 15,
                fontweight: FontWeight.bold,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.help_outline,
                      color: primaryColor,
                      size: 18,
                    )),
              ),
            ],
          ),
          SizedBox(
            width: widthsize * 0.89,
            child: mobilenumber,
          ),
          sizeheight,
          SizedBox(
            width: widthsize * 0.89,
            child: socialmedia,
          ),
          const SizedBox(height: 29),
          Row(
            children: [
              const TextViewInter(
                title: "ITEMS",
                fontcolor: primaryColor,
                fontsize: 15,
                fontweight: FontWeight.bold,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.help_outline,
                      color: primaryColor,
                      size: 18,
                    )),
              ),
            ],
          ),
          SizedBox(
            width: widthsize * 0.89,
            child: itemmodel,
          ),
          sizeheight,
          SizedBox(
            width: widthsize * 0.89,
            child: itembrand,
          ),
          const SizedBox(height: 29),
          Row(
            children: [
              const TextViewInter(
                title: "OTHERS",
                fontcolor: primaryColor,
                fontsize: 15,
                fontweight: FontWeight.bold,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.help_outline,
                      color: primaryColor,
                      size: 18,
                    )),
              ),
            ],
          ),
          SizedBox(
            width: widthsize * 0.89,
            child: markings,
          ),
          sizeheight,
          SizedBox(
            width: widthsize * 0.89,
            height: 5 * 25.0,
            child: serial,
          ),
        ],
      ),
    );
  }
}
