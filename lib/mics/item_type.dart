import 'package:lostfoundapp/mics/packages.dart';

String? itemvalue;

class ItemTypeCategory extends StatefulWidget {
  const ItemTypeCategory({super.key});

  @override
  State<ItemTypeCategory> createState() => _ItemTypeCategoryState();
}

class _ItemTypeCategoryState extends State<ItemTypeCategory> {
  final itemTypes = [
    "Electronics",
    "Clothings",
    "Accessories",
    "Food and Supplements",
    "Others"
  ];
  String? givinvalue;
  Widget dropdown() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        padding: const EdgeInsets.only(left: 10),
        height: 58,
        decoration: BoxDecoration(
          border: Border.all(color: colorgrey, width: 1),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            isExpanded: true,
            value: itemvalue,
            hint: Text("Item type",
                style: GoogleFonts.inter(fontSize: 14, color: colorblack)),
            items: itemTypes.map(buildMenuItem).toList(),
            onChanged: (value) {
              setState(() {
                itemvalue = value;
              });
            },
          ),
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String itemType) => DropdownMenuItem(
      value: itemType,
      child: AutoSizeText(
        itemType,
        wrapWords: false,
        maxLines: 1,
        style: GoogleFonts.inter(fontSize: 14, color: colorblack),
      ));

  @override
  Widget build(BuildContext context) {
    return dropdown();
  }
}
