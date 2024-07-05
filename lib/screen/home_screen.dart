import 'package:bmi_manager/component/custom_test_field.dart';
import 'package:bmi_manager/component/main_calender.dart';
import 'package:bmi_manager/component/schedule_bottom_sheet.dart';
import 'package:bmi_manager/component/schedule_card.dart';
import 'package:bmi_manager/component/today_banner.dart';
import 'package:bmi_manager/const/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDay = DateTime.utc(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  DateTime focusedDay = DateTime.utc(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          MainCalendar(selectedDay: selectedDay, onDaySelected: onDaySelected),
          TodayBanner(
            selectedDate: selectedDay,
            taskCount: 0,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
              child: ListView(
                children: [
                  ScheduleCard(
                    startTime: DateTime(2023, 01, 03, 11),
                    endTime: DateTime(2023, 01, 03, 12),
                    content: 'PT받기',
                    color: Colors.red,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (_) {
              return ScheduleBottomSheet();
            },
          );
        },
        backgroundColor: PRIMARY_COLOR,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  void onDaySelected(selectedDay, focusedDay) {
    setState(() {
      this.selectedDay = selectedDay;
      this.focusedDay = selectedDay;
    });
  }

  bool selectedDayPredicate(date) {
    return date.year == selectedDay.year && date.month == selectedDay.month && date.day == selectedDay.day;
  }
}
