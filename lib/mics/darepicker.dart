// ignore_for_file: no_logic_in_create_state, depend_on_referenced_packages

import 'package:intl/intl.dart';
import 'package:lostfoundapp/mics/packages.dart';

String? datetimepicked;
final TextEditingController datetimeController = TextEditingController();

class DateTimepicker extends StatefulWidget {
  final String date;
  const DateTimepicker(this.date, {Key? key}) : super(key: key);

  @override
  State<DateTimepicker> createState() => _DateTimepickerState(date);
}

class _DateTimepickerState extends State<DateTimepicker> {
  final String date;

  _DateTimepickerState(this.date);
  @override
  void initState() {
    datetimeController.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: GoogleFonts.inter(fontSize: 12, color: colorgrey),
      autofocus: false,
      controller: datetimeController,
      readOnly: true,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
        );
        if (pickedDate != null) {
          String formattedDate = DateFormat('MM-dd-yyyy').format(pickedDate);
          setState(() {
            datetimeController.text = formattedDate;
            datetimepicked = formattedDate.toString();
          });
        }
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.calendar_month, color: primaryColor),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: date,
        hintStyle: GoogleFonts.inter(fontSize: 12, color: colorgrey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
