import 'package:flutter/material.dart';

class DateTimePickerTable extends StatefulWidget {
  const DateTimePickerTable({super.key});

  @override
  State<DateTimePickerTable> createState() => _DateTimePickerTableState();
}

class _DateTimePickerTableState extends State<DateTimePickerTable> {
  DateTime? selectedDate;
  TimeOfDay? startTime;
  TimeOfDay? endTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Date and Time Picker')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Table(
          columnWidths: const {
            0: FlexColumnWidth(),
            1: FlexColumnWidth(),
          },
          children: [
            TableRow(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2101),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        selectedDate = pickedDate;
                      });
                    }
                  },
                  child: const Text("Chọn Ngày"),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    selectedDate != null ? '${selectedDate!.toLocal()}'.split(' ')[0] : 'Chưa chọn',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            TableRow(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    TimeOfDay? pickedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (pickedTime != null) {
                      setState(() {
                        startTime = pickedTime;
                      });
                    }
                  },
                  child: const Text("Chọn Thời Gian Bắt Đầu"),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    startTime != null ? startTime!.format(context) : 'Chưa chọn',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            TableRow(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    TimeOfDay? pickedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (pickedTime != null) {
                      setState(() {
                        endTime = pickedTime;
                      });
                    }
                  },
                  child: const Text("Chọn Thời Gian Kết Thúc"),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    endTime != null ? endTime!.format(context) : 'Chưa chọn',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
