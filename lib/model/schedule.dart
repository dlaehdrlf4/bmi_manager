import 'dart:ui';

import 'package:drift/drift.dart';

class Schedule {
  //식별 ID
  final int id;
  //시작 시간
  final int startTime;
  //종료 시간
  final int endTime;
  //일정내용
  final String content;
  //날짜
  final DateTime date;
  //카테고리
  final Color color;
  //일정 생성날짜시간
  final DateTime createdAt;

  Schedule(
      {required this.id,
      required this.startTime,
      required this.endTime,
      required this.content,
      required this.date,
      required this.color,
      required this.createdAt});
}
