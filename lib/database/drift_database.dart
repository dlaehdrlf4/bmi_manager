import 'dart:io';

import 'package:bmi_manager/model/schedule.dart';
import 'package:drift/drift.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:sqlite3/sqlite3.dart';
import 'package:drift/native.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';

part 'drift_database.g.dart';

@DriftDatabase(tables: [ScheduleTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  Future<ScheduleTableData> getScheduleById(int id) =>
      (select(scheduleTable)..where((tbl) => tbl.id.equals(id))).getSingle();

  Stream<List<ScheduleTableData>> streamSchedules(DateTime date) => (select(
          scheduleTable)
        ..where((table) => table.date.equals(date))
        ..orderBy([
          (table) =>
              OrderingTerm(expression: table.startTime, mode: OrderingMode.asc),
          (table) =>
              OrderingTerm(expression: table.endTime, mode: OrderingMode.asc)
        ]))
      .watch(); // watch 계속 반환하는 stream을 반환한다

  Future<List<ScheduleTableData>> getSchedules(DateTime date) =>
      (select(scheduleTable)..where((table) => table.date.equals(date))).get();

  Future<DateTime?> getDate(int idx) async {
    final selectQuery = select(scheduleTable)
      ..where((table) => table.selectedCategory.equals(idx))
      ..orderBy([
        (t) => OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc)
      ])
      ..limit(1);

    final result = await selectQuery.getSingleOrNull();

    return result?.date;
  }
  // final selectQuery = select(scheduleTable);
  // selectQuery.where((table) => table.date.equals(date));
  // return selectQuery.get();
  //select하면 데이터를 가져올수 있다.

  Future<int> createSchedule(ScheduleTableCompanion data) =>
      into(scheduleTable).insert(
        data,
      ); //ScheduleTableCompanion 데이터 생성, 데이터 업데이트할때 사용

  Future<int> removeSchedule(int id) =>
      (delete(scheduleTable)..where((table) => table.id.equals(id))).go();

  //업데이트
  Future<int> updateScheduleById(int id, ScheduleTableCompanion data) =>
      (update(scheduleTable)..where((table) => table.id.equals(id)))
          .write(data);

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationCacheDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));

    final cachebase = await getTemporaryDirectory();
    sqlite3.tempDirectory = cachebase.path;

    if (Platform.isAndroid) {
      applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
    }

    return NativeDatabase(file);
  });
}
