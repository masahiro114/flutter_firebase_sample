import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IOSDatePicker extends StatefulWidget {
  final Function(DateTime) onDateSelected;

  const IOSDatePicker({Key? key, required this.onDateSelected}) : super(key: key);

  @override
  _IOSDatePickerState createState() => _IOSDatePickerState();
}

class _IOSDatePickerState extends State<IOSDatePicker> {
  DateTime? _selectedDate;

  void _showDatePicker(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        height: 300,
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: Column(
          children: [
            /// Done Button
            Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.all(10),
              child: CupertinoButton(
                child: const Text('Done', style: TextStyle(color: CupertinoColors.activeBlue)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),

            /// iOS Date Picker
            Expanded(
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: DateTime(2000, 1, 1),
                maximumDate: DateTime.now(),
                onDateTimeChanged: (DateTime newDate) {
                  setState(() {
                    _selectedDate = newDate;
                  });

                  /// Pass the selected date to the parent widget
                  widget.onDateSelected(newDate);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showDatePicker(context);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          border: Border.all(color: CupertinoColors.systemGrey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _selectedDate == null
                  ? 'Select Birthday'
                  : '${_selectedDate!.year}-${_selectedDate!.month.toString().padLeft(2, '0')}-${_selectedDate!.day.toString().padLeft(2, '0')}',
              style: TextStyle(
                fontSize: 16,
                color: _selectedDate == null
                    ? CupertinoColors.inactiveGray
                    : CupertinoColors.black,
              ),
            ),
            const Icon(
              CupertinoIcons.calendar,
              color: CupertinoColors.activeBlue,
            ),
          ],
        ),
      ),
    );
  }
}
