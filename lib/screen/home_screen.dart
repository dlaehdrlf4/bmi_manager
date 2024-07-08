import 'package:bmi_manager/component/custom_test_field.dart';
import 'package:bmi_manager/component/main_calender.dart';
import 'package:bmi_manager/component/schedule_bottom_sheet.dart';
import 'package:bmi_manager/component/schedule_card.dart';
import 'package:bmi_manager/component/today_banner.dart';
import 'package:bmi_manager/const/colors.dart';
import 'package:bmi_manager/model/schedule.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDay = DateTime.utc(
      DateTime.now().year, DateTime.now().month, DateTime.now().day);
  DateTime focusedDay = DateTime.utc(
      DateTime.now().year, DateTime.now().month, DateTime.now().day);

  Map<DateTime, List<Schedule>> schedules = {
    DateTime.utc(2024, 7, 3): [
      Schedule(
          id: 1,
          startTime: 11,
          endTime: 12,
          content: 'PT하기',
          date: DateTime.utc(2024, 7, 3),
          color: categoryColor[0],
          createdAt: DateTime.now().toUtc()),
      Schedule(
          id: 2,
          startTime: 14,
          endTime: 16,
          content: 'PT하기2',
          date: DateTime.utc(2024, 7, 3),
          color: categoryColor[3],
          createdAt: DateTime.now().toUtc()),
    ],
  };

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
              child: ListView.separated(
                itemBuilder: (context, index) {
                  final selectedSchedules = schedules[selectedDay]!;
                  final scheduleModel = selectedSchedules[index];
                  return ScheduleCard(
                      startTime: scheduleModel.startTime,
                      endTime: scheduleModel.endTime,
                      content: scheduleModel.content,
                      color: scheduleModel.color);
                },
                itemCount: schedules.containsKey(selectedDay)
                    ? schedules[selectedDay]!.length
                    : 0,
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 4,
                  );
                },
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
    return date.year == selectedDay.year &&
        date.month == selectedDay.month &&
        date.day == selectedDay.day;
  }
}
