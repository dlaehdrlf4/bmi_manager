import 'package:bmi_manager/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class MainCalendar extends StatelessWidget {
  final DateTime selectedDay;
  final OnDaySelected onDaySelected;

  const MainCalendar({super.key, required this.selectedDay, required this.onDaySelected});

  @override
  Widget build(BuildContext context) {
    final defaultBoxDeco = BoxDecoration(
      color: Colors.grey[200],
      borderRadius: BorderRadius.circular(6.0),
    );

    final defaultTextStyle = TextStyle(
      color: Colors.grey[600],
      fontWeight: FontWeight.w700,
    );

    final todayBoxDeco = BoxDecoration(
      color: Colors.grey,
      borderRadius: BorderRadius.circular(12.0),
    );

    return TableCalendar(
      locale: 'ko-KR',
      calendarStyle: CalendarStyle(
        outsideDecoration: const BoxDecoration(shape: BoxShape.rectangle),
        isTodayHighlighted: true,
        todayDecoration: todayBoxDeco,
        defaultDecoration: defaultBoxDeco,
        weekendDecoration: defaultBoxDeco,
        defaultTextStyle: defaultTextStyle,
        weekendTextStyle: defaultTextStyle,
        selectedDecoration: defaultBoxDeco.copyWith(color: PRIMARY_COLOR),
      ),
      focusedDay: DateTime.now(),
      firstDay: DateTime(1800),
      lastDay: DateTime(3000),
      headerStyle: const HeaderStyle(
          formatButtonVisible: false, titleCentered: true, titleTextStyle: TextStyle(fontWeight: FontWeight.w700)),
      onDaySelected: onDaySelected,
      selectedDayPredicate: (date) {
        return date.year == selectedDay.year && date.month == selectedDay.month && date.day == selectedDay.day;
      },
    );
  }
}
