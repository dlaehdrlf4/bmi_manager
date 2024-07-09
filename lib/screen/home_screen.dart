import 'package:bmi_manager/component/custom_test_field.dart';
import 'package:bmi_manager/component/main_calender.dart';
import 'package:bmi_manager/component/schedule_bottom_sheet.dart';
import 'package:bmi_manager/component/schedule_card.dart';
import 'package:bmi_manager/component/today_banner.dart';
import 'package:bmi_manager/const/colors.dart';
import 'package:bmi_manager/database/drift_database.dart';
import 'package:bmi_manager/model/schedule.dart';
import 'package:bmi_manager/screen/knowledge_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDay = DateTime.utc(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  DateTime focusedDay = DateTime.utc(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  // Map<DateTime, List<Schedule>> schedules = {
  //   DateTime.utc(2024, 7, 3): [
  //     Schedule(
  //         id: 1,
  //         startTime: 11,
  //         endTime: 12,
  //         content: 'PT하기',
  //         date: DateTime.utc(2024, 7, 3),
  //         color: categoryColor[0],
  //         createdAt: DateTime.now().toUtc()),
  //     Schedule(
  //         id: 2,
  //         startTime: 14,
  //         endTime: 16,
  //         content: 'PT하기2',
  //         date: DateTime.utc(2024, 7, 3),
  //         color: categoryColor[3],
  //         createdAt: DateTime.now().toUtc()),
  //   ],
  // };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '멍매니저',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(
                '메뉴',
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              accountEmail: Text(''),
              decoration: BoxDecoration(color: Colors.yellow[200]),
            ),
            ListTile(
              leading: Icon(
                Icons.edit_calendar,
                color: Colors.grey[850],
              ),
              title: Text(
                '예방접종',
              ),
              onTap: () {
                showMessage(0);
                print('Home is clicked');
              },
              trailing: Icon(Icons.arrow_circle_right),
            ),
            ListTile(
              leading: Icon(
                Icons.edit_calendar,
                color: Colors.grey[850],
              ),
              title: Text(
                '심장사상충',
              ),
              onTap: () {
                showMessage(1);
                print('Home is clicked');
              },
              trailing: Icon(Icons.arrow_circle_right),
            ),
            ListTile(
              leading: Icon(
                Icons.edit_calendar,
                color: Colors.grey[850],
              ),
              title: Text('생일'),
              onTap: () {
                showMessage(2);
                print('Home is clicked');
              },
              trailing: Icon(Icons.arrow_circle_right),
            ),
            const SizedBox(
              height: 8,
            ),
            const Text(
              '강아지 백과사전',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(
              height: 8,
            ),
            ListTile(
              leading: Image.asset(
                'asset/img/know1.png',
                width: 30,
                height: 30,
              ),
              title: Text('예방접종'),
              onTap: () {
                context.pushNamed('knowledge', extra: '예방접종');
              },
              trailing: Icon(Icons.arrow_circle_right),
            ),
            ListTile(
              leading: Image.asset(
                'asset/img/know6.png',
                width: 30,
                height: 30,
              ),
              title: Text('목욕'),
              onTap: () {
                context.pushNamed('knowledge', extra: '강아지목욕');
              },
              trailing: Icon(Icons.arrow_circle_right),
            ),
            ListTile(
              leading: Image.asset(
                'asset/img/know10.png',
                width: 30,
                height: 30,
              ),
              title: Text('훈련'),
              onTap: () {
                context.pushNamed('knowledge', extra: '강아지훈련');
              },
              trailing: Icon(Icons.arrow_circle_right),
            ),
          ],
        ),
      ),
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
              // child: FutureBuilder<List<ScheduleTableData>>(
              //   future: GetIt.I<AppDatabase>().getSchedules(selectedDay),
              //   builder: (context, snapshot) {
              //     if (snapshot.hasError) {
              //       return const Center(
              //         child: Text('에러가 발생하였습니다.'),
              //       );
              //     }

              //     //함수를 처음 실행한 상태
              //     if (!snapshot.hasData && snapshot.connectionState == ConnectionState.waiting) {
              //       return const Center(
              //         child: CircularProgressIndicator(),
              //       );
              //     }

              //     final schedules = snapshot.data!;
              //     //final selectedSchedules = schedules.where((e) => e.date.isAtSameMomentAs(selectedDay)).toList();

              //     return ListView.separated(
              //       itemBuilder: (context, index) {
              //         //final selectedSchedules = schedules[selectedDay]!;
              //         //final scheduleModel = selectedSchedules[index];
              //         final schedule = schedules[index];

              //         //여기서 오른쪽에서 왼쪽으로 삭제처리 가능
              //         return Dismissible(
              //           key: ObjectKey(schedule.id),
              //           direction: DismissDirection.endToStart,
              //           //이미 사라진 다음에 실행하는거기 때문에 setState하면 늦는다.
              //           onDismissed: (direction) async {
              //             //데이터베이스 삭제해주는 로직이 필요

              //             //여기서 하면 이미 늦는다.
              //             //setState(() {});
              //           },
              //           confirmDismiss: (direction) async {
              //             await GetIt.I<AppDatabase>().removeSchedule(schedule.id);
              //             setState(() {});
              //             return true;
              //           },
              //           child: ScheduleCard(
              //               startTime: schedule.startTime,
              //               endTime: schedule.endTime,
              //               content: schedule.content,
              //               color: schedule.color),
              //         );
              //       },
              //       itemCount: schedules.length,
              //       //itemCount: schedules.containsKey(selectedDay) ? schedules[selectedDay]!.length : 0,
              //       separatorBuilder: (context, index) {
              //         return const SizedBox(
              //           height: 4,
              //         );
              //       },
              //     );
              //   },
              // ),

              //StreamBuilder 사용 아래
              child: StreamBuilder<List<ScheduleTableData>>(
                stream: GetIt.I<AppDatabase>().streamSchedules(selectedDay),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text('에러가 발생하였습니다.'),
                    );
                  }

                  //함수를 처음 실행한 상태
                  if (snapshot.data == null) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  final schedules = snapshot.data!;
                  //final selectedSchedules = schedules.where((e) => e.date.isAtSameMomentAs(selectedDay)).toList();

                  return ListView.separated(
                    itemBuilder: (context, index) {
                      //final selectedSchedules = schedules[selectedDay]!;
                      //final scheduleModel = selectedSchedules[index];
                      final schedule = schedules[index];

                      //여기서 오른쪽에서 왼쪽으로 삭제처리 가능
                      return Dismissible(
                        key: ObjectKey(schedule.id),
                        direction: DismissDirection.endToStart,
                        //이미 사라진 다음에 실행하는거기 때문에 setState하면 늦는다.
                        onDismissed: (direction) {
                          //데이터베이스 삭제해주는 로직이 필요

                          //여기서 하면 이미 늦는다.
                          //setState(() {});
                          //GetIt.I<AppDatabase>().removeSchedule(schedule.id);
                        },
                        confirmDismiss: (direction) async {
                          await GetIt.I<AppDatabase>().removeSchedule(schedule.id);
                          // setState(() {});
                          return true;
                        },
                        child: ScheduleCard(
                            startTime: schedule.startTime,
                            endTime: schedule.endTime,
                            content: schedule.content,
                            color: schedule.color),
                      );
                    },
                    itemCount: schedules.length,
                    //itemCount: schedules.containsKey(selectedDay) ? schedules[selectedDay]!.length : 0,
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 4,
                      );
                    },
                  );
                },
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final schedule = await showModalBottomSheet<ScheduleTable>(
            isScrollControlled: true,
            context: context,
            builder: (_) {
              return ScheduleBottomSheet(
                selectedDay: selectedDay,
              );
            },
          ).then((value) {
            //stream 빌드를 사용하면 아래 코드를 필요할 필요가 없다.
            //setState(() {});
          });
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

  Future<void> showMessage(int idx) async {
    String content = '';
    DateTime? date = await GetIt.I<AppDatabase>().getDate(idx);

    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        String title = '';
        if (idx == 0) {
          title = '예방접종';
        } else if (idx == 1) {
          title = '심장사상충';
        } else {
          title = '생일';
        }

        if (date != null) {
          content = date.toString();
          content = '${title} 날짜는 ${content.split(' ').first} 입니다.';
        } else {
          content = '데이터가 없습니다.';
        }

        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(content),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('확인'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
