import 'package:bmi_manager/const/colors.dart';

import 'package:flutter/material.dart';

class ScheduleCard extends StatelessWidget {
  final DateTime startTime;
  final DateTime endTime;
  final String content;
  final Color color;

  const ScheduleCard(
      {required this.startTime, required this.endTime, required this.content, super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(border: Border.all(color: PRIMARY_COLOR!, width: 1), borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                children: [
                  Text(
                    '${startTime.hour.toString().padLeft(2, '0')}:00',
                    style: TextStyle(fontWeight: FontWeight.w600, color: PRIMARY_COLOR, fontSize: 16),
                  ),
                  Text(
                    '${endTime.hour.toString().padLeft(2, '0')}:00',
                    style: TextStyle(fontWeight: FontWeight.w600, color: PRIMARY_COLOR, fontSize: 10),
                  ),
                ],
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(child: Text('$content')),
              Container(
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
                width: 16,
                height: 16,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _Time extends StatelessWidget {
  final int startTime; // 시작시간
  final int endTime; // 종료시간

  const _Time({required this.startTime, required this.endTime, super.key});

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontWeight: FontWeight.w600,
      color: PRIMARY_COLOR!,
      fontSize: 16.0,
    );

    return Column(
      // 시간을 위에서 아래로 배치
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        // 숫자가 두 자리수가 안되면 0으로 채워주기
        Text(
          '${startTime.toString().padLeft(2, '0')}:00',
          style: textStyle,
        ),
        Text(
          '${endTime.toString().padLeft(2, '0')}:00',
          style: textStyle.copyWith(fontSize: 16.0),
        )
      ],
    );
  }
}

class _Content extends StatelessWidget {
  final String content; // 내용

  const _Content({required this.content, super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Text(content),
    );
  }
}
