import 'package:bmi_manager/component/custom_test_field.dart';
import 'package:bmi_manager/const/colors.dart';
import 'package:bmi_manager/database/drift_database.dart';
import 'package:bmi_manager/model/schedule.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class ScheduleBottomSheet extends StatefulWidget {
  final int? id;
  final DateTime selectedDay;
  const ScheduleBottomSheet({super.key, required this.selectedDay, this.id});

  @override
  State<ScheduleBottomSheet> createState() => _ScheduleBottomSheetState();
}

class _ScheduleBottomSheetState extends State<ScheduleBottomSheet> {
  final GlobalKey<FormState> formKey = GlobalKey();
  String selectedColor = categoryColor.first;
  int? startTime;
  int? endTime;
  String? content;
  Color? category;
  int _selectedIndex = -1;
  bool _alarmEnabled = true;
  String _selectedTime = '1시간전';

  final List<String> _timeOptions = ['1시간전', '6시간전', '12시간전'];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initColor();
  }

  initColor() async {
    if (widget.id != null) {
      final resp = await GetIt.I<AppDatabase>().getScheduleById(widget.id!);

      setState(() {
        selectedColor = resp.color;
        _selectedIndex = resp.selectedCategory;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: widget.id == null
            ? null
            : GetIt.I<AppDatabase>().getScheduleById(widget.id!),
        builder: (context, snapshot) {
          if (widget.id != null &&
              snapshot.connectionState == ConnectionState.waiting &&
              !snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final data = snapshot.data;

          return Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height / 1.1,
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.only(top: 16, left: 8, right: 8),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      ToggleButtons(
                        isSelected: List.generate(
                            3, (index) => index == _selectedIndex),
                        onPressed: (int newIndex) {
                          setState(() {
                            _selectedIndex = newIndex;
                          });
                        },
                        children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 32.0),
                            child: Text('예방접종'),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 32.0),
                            child: Text('심장사상충'),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 32.0),
                            child: Text('생일'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // Row(
                      //   children: [
                      //     Icon(Icons.alarm, color: Colors.blue),
                      //     const SizedBox(width: 8),
                      //     Text('알람 설정'),
                      //     const SizedBox(width: 8),
                      //     DropdownButton<String>(
                      //       value: _selectedTime,
                      //       items: _timeOptions.map((String value) {
                      //         return DropdownMenuItem<String>(
                      //           value: value,
                      //           child: Text(value),
                      //         );
                      //       }).toList(),
                      //       onChanged: (String? newValue) {
                      //         setState(() {
                      //           _selectedTime = newValue!;
                      //         });
                      //       },
                      //     ),
                      //     const Spacer(),
                      //     Switch(
                      //       value: _alarmEnabled,
                      //       onChanged: (bool newValue) {
                      //         setState(() {
                      //           _alarmEnabled = newValue;
                      //         });
                      //       },
                      //     ),
                      //   ],
                      // ),
                      // const SizedBox(
                      //   height: 16,
                      // ),
                      _Time(
                        onStartSaved: onStartTimeSaved,
                        onStartValidator: onStartTimeValidate,
                        onEndSaved: onEndTimeSaved,
                        onEndValidator: onEndTimeValidate,
                        startTimeInitialValue: data?.startTime.toString(),
                        endTimeInitialValue: data?.endTime.toString(),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      _Content(
                        onSaved: onContentSaved,
                        onValidate: onContentValidate,
                        initalValue: data?.content,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      _Categorys(
                        selectedColor: selectedColor,
                        onTap: (String color) {
                          setState(() {
                            selectedColor = color;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      _SaveButton(
                        onPressed: onSavePressed,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  void onStartTimeSaved(String? val) {
    if (val == null) return;
    startTime = int.parse(val);
  }

  String? onStartTimeValidate(String? val) {
    if (val == null) {
      return '값을 입력해주세요!';
    }
    if (int.tryParse(val) == null) {
      return '숫자를 입력해주세요!';
    }

    final time = int.parse(val);

    if (time > 24 || time < 0) {
      return '0과 24 사이의 숫자를 입력해주세요!';
    }

    return null;
  }

  void onEndTimeSaved(String? val) {
    if (val == null) {
      return;
    }

    endTime = int.parse(val);
  }

  String? onEndTimeValidate(String? val) {
    if (val == null) {
      return '값을 입력해주세요!';
    }
    if (int.tryParse(val) == null) {
      return '숫자를 입력해주세요!';
    }

    final time = int.parse(val);

    if (time > 24 || time < 0) {
      return '0과 24 사이의 숫자를 입력해주세요!';
    }

    return null;
  }

  String? onContentValidate(String? val) {
    if (val == null) {
      return '내용을 입력해주세요!';
    }

    if (val.length < 5) {
      return '5자 이상을 입력해주세요!';
    }

    return null;
  }

  void onContentSaved(String? val) {
    if (val == null) {
      return;
    }

    content = val;
  }

  void onSavePressed() async {
    final isValid = formKey.currentState!.validate();
    if (isValid) {
      formKey.currentState!.save();

      final database = GetIt.I<AppDatabase>();

      if (widget.id == null) {
        await database.createSchedule(ScheduleTableCompanion(
          startTime: Value(startTime!),
          endTime: Value(endTime!),
          content: Value(content!),
          color: Value(selectedColor),
          date: Value(widget.selectedDay),
          selectedCategory: Value(_selectedIndex),
        ));
      } else {
        await database.updateScheduleById(
            widget.id!,
            ScheduleTableCompanion(
              startTime: Value(startTime!),
              endTime: Value(endTime!),
              content: Value(content!),
              color: Value(selectedColor),
              date: Value(widget.selectedDay),
              selectedCategory: Value(_selectedIndex),
            ));
      }

      // Navigator.of(context).pop(schedule);
      Navigator.of(context).pop();
    }
  }
}

class _Time extends StatelessWidget {
  //단하나의 키값을 만든다 form의 상태를 저장

  final FormFieldSetter<String> onStartSaved;
  final FormFieldSetter<String> onEndSaved;
  final FormFieldValidator<String> onStartValidator;
  final FormFieldValidator<String> onEndValidator;
  final String? startTimeInitialValue;
  final String? endTimeInitialValue;

  const _Time(
      {super.key,
      required this.onStartSaved,
      required this.onEndSaved,
      required this.onStartValidator,
      required this.onEndValidator,
      this.startTimeInitialValue,
      this.endTimeInitialValue});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: CustomTextField(
              label: '시작시간',
              onSaved: onStartSaved,
              validator: onStartValidator,
              initialValue: startTimeInitialValue,
            )),
            const SizedBox(
              width: 16,
            ),
            Expanded(
                child: CustomTextField(
              label: '마감시간',
              onSaved: onEndSaved,
              validator: onEndValidator,
              initialValue: endTimeInitialValue,
            )),
          ],
        ),
      ],
    );
  }
}

class _Content extends StatelessWidget {
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> onValidate;
  final String? initalValue;
  const _Content(
      {super.key,
      required this.onSaved,
      required this.onValidate,
      this.initalValue});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomTextField(
        label: '내용',
        expand: true,
        onSaved: onSaved,
        validator: onValidate,
        initialValue: initalValue,
      ),
    );
  }
}

typedef OnColorSelected = void Function(
    String color); // 이거랑 final Function(Color color) onTap; 이거랑 같은동작을 한다.

class _Categorys extends StatelessWidget {
  final String selectedColor;
  //상위 위젯에 있는 onTap을 넘겨주고 상위 위젯의 함수를 실행시켜 UI를 렌더링 한다.
  final OnColorSelected onTap;

  const _Categorys(
      {super.key, required this.selectedColor, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: categoryColor
          .map((e) => Padding(
                padding: const EdgeInsets.only(right: 8),
                child: GestureDetector(
                  onTap: () {
                    onTap(e);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(int.parse(e, radix: 16)),
                        shape: BoxShape.circle,
                        border: selectedColor == e
                            ? Border.all(color: Colors.black, width: 4)
                            : null),
                    width: 32,
                    height: 32,
                  ),
                ),
              ))
          .toList(),
    );
  }
}

class _SaveButton extends StatelessWidget {
  final VoidCallback onPressed;
  const _SaveButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: onPressed,
            child: Text('저장'),
            style: ElevatedButton.styleFrom(
                backgroundColor: PRIMARY_COLOR, foregroundColor: Colors.white),
          ),
        ),
      ],
    );
  }
}
