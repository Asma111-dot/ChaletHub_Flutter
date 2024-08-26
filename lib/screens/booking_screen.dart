import 'package:chalet_2/components/custom_appbar.dart';
import 'package:chalet_2/resources/config.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'summary_screen.dart';
import 'package:chalet_2/components/button.dart'; // Import Button component

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  final List<DateTime> _bookedDays = [
    DateTime.utc(2024, 6, 5),
    DateTime.utc(2024, 6, 12),
    DateTime.utc(2024, 6, 19),
    DateTime.utc(2024, 6, 26),
  ];

  String _formatDate(DateTime date) {
    return DateFormat('EEEE, yyyy-MM-dd')
        .format(date); // تنسيق التاريخ بشكل مناسب مع اليوم
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appTitle: 'Bookings Guide',
        icon: const FaIcon(Icons.arrow_back_ios),
      ),
      body: Column(
        children: [
          Config.spaceSmall,
          TableCalendar(
            firstDay: DateTime.now(), // Start from today's date
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              if (!_bookedDays.contains(selectedDay)) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay; // update `_focusedDay` here as well
                });
              }
              // Check if the selected day is in the same month as the focused day
              if (selectedDay.month != _focusedDay.month) {
                setState(() {
                  _focusedDay = DateTime(
                    selectedDay.year,
                    selectedDay.month,
                  ); // Update the focused day to the selected day's month
                });
              }
            },
            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, day, focusedDay) {
                if (_bookedDays.contains(day)) {
                  return Center(
                    child: Text(
                      '${day.day}',
                      style: TextStyle(color: Config.primaryColor),
                    ),
                  );
                }
                return null;
              },
              disabledBuilder: (context, day, focusedDay) {
                if (_bookedDays.contains(day)) {
                  return Center(
                    child: Text(
                      '${day.day}',
                      style: TextStyle(color: Colors.grey),
                    ),
                  );
                }
                return null;
              },
            ),
            enabledDayPredicate: (day) {
              return !_bookedDays.contains(day);
            },
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.rectangle,
              ),
              selectedDecoration: BoxDecoration(
                color: Config.primaryColor,
                shape: BoxShape.rectangle,
              ),
            ),
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
              leftChevronIcon:
                  Icon(Icons.chevron_left, color: Config.primaryColor),
              rightChevronIcon:
                  Icon(Icons.chevron_right, color: Config.primaryColor),
            ),
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          ),
          if (_selectedDay != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Selected Day',
                  labelStyle: TextStyle(color: Config.primaryColor),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Config.primaryColor)),
                ),
                controller: TextEditingController(
                  text: _selectedDay != null ? _formatDate(_selectedDay!) : '',
                ),
              ),
            ),
          Config.spaceSmall,
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Button(
              width: double.infinity,
              title: 'Payment',
              onPressed: _selectedDay != null
                  ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SummaryScreen(
                            selectedDay: _selectedDay!,
                            chaletName:
                                'Chalet and swimming pool Qatar Al-Nada',
                          ),
                        ),
                      );
                    }
                  : () {}, // Provide an empty function when _selectedDay is null
              disable: _selectedDay == null,
            ),
          ),
        ],
      ),
    );
  }
}
