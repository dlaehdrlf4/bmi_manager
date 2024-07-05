import 'package:bmi_manager/const/colors.dart';
import 'package:flutter/material.dart';

class TodayBanner extends StatelessWidget {
  final DateTime selectedDate;
  final int taskCount;
  const TodayBanner({required this.selectedDate, required this.taskCount, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: PRIMARY_COLOR,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${selectedDate.year}년 ${selectedDate.month}월 ${selectedDate.day}일',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
            ),
            Text(
              '$taskCount개',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}
