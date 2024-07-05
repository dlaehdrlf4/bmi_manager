import 'package:bmi_manager/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  //flutter 프레임워크를 사용할수 있다 준비 단계
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'NotoSans'),
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}
