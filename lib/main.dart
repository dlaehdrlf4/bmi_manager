import 'package:bmi_manager/const/colors.dart';
import 'package:bmi_manager/database/drift_database.dart';
import 'package:bmi_manager/router/app_route.dart';
import 'package:bmi_manager/screen/home_screen.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_it/get_it.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  //flutter 프레임워크를 사용할수 있다 준비 단계
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();
  await dotenv.load(fileName: 'asset/config/.env');

  final database = AppDatabase();
  GetIt.I.registerSingleton<AppDatabase>(database); //어디에서든 사용할수 있도록 선언

  // await database.createSchedule(ScheduleTableCompanion(
  //   startTime: Value(12),
  //   endTime: Value(15),
  //   content: Value('flutter check'),
  //   date: Value(DateTime(2024, 7, 9)),
  //   color: Value(categoryColor.first),
  // ));
  //final resp = await database.getSchedules();

  // print('--------------');
  // print(resp);
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Future.delayed(const Duration(seconds: 1));
  FlutterNativeSplash.remove();
  //Firebase.initializeApp().whenComplete(() => {FlutterNativeSplash.remove()});

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(fontFamily: 'NotoSans'),
      debugShowCheckedModeBanner: false,
      routerConfig: AppRoute.router, //go_router를 사용할때 config 파일이 추가되어야함
    );
  }
}
