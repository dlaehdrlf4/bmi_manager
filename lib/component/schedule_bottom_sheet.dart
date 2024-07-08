import 'package:bmi_manager/component/custom_test_field.dart';
import 'package:bmi_manager/const/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ScheduleBottomSheet extends StatefulWidget {
  const ScheduleBottomSheet({super.key});

  @override
  State<ScheduleBottomSheet> createState() => _ScheduleBottomSheetState();
}

class _ScheduleBottomSheetState extends State<ScheduleBottomSheet> {
  final GlobalKey<FormState> formKey = GlobalKey();
  Color selectedColor = categoryColor.first;
  int? startTime;
  int? endTime;
  String? content;
  Color? category;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 600,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 16, left: 8, right: 8),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                _Time(
                  onStartSaved: onStartTimeSaved,
                  onStartValidator: onStartTimeValidate,
                  onEndSaved: onEndTimeSaved,
                  onEndValidator: onEndTimeValidate,
                ),
                const SizedBox(
                  height: 8,
                ),
                _Content(
                  onSaved: onContentSaved,
                  onValidate: onContentValidate,
                ),
                const SizedBox(
                  height: 8,
                ),
                _Categorys(
                  selectedColor: selectedColor,
                  onTap: (Color color) {
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
  }

  void onStartTimeSaved(String? val) {
    if (val == null) return;
    startTime = int.parse(val);
  }

  String? onStartTimeValidate(String? val) {
    if (val == null) {
      return '값을 입력해주세요!';
    }
    // if(int.tryParse(source))
  }

  void onEndTimeSaved(String? val) {
    if (val == null) return;
    endTime = int.parse(val);
  }

  String? onEndTimeValidate(String? val) {}
  void onContentSaved(String? val) {
    if (val == null) return;
    content = val;
  }

  String? onContentValidate(String? val) {}

  void onSavePressed() {
    formKey.currentState!.save();
    print(startTime);
    print(endTime);
    print(content);
    print(category);
  }
}

class _Time extends StatelessWidget {
  //단하나의 키값을 만든다 form의 상태를 저장

  final FormFieldSetter<String> onStartSaved;
  final FormFieldSetter<String> onEndSaved;
  final FormFieldValidator<String> onStartValidator;
  final FormFieldValidator<String> onEndValidator;

  const _Time(
      {super.key,
      required this.onStartSaved,
      required this.onEndSaved,
      required this.onStartValidator,
      required this.onEndValidator});

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
            )),
            const SizedBox(
              width: 16,
            ),
            Expanded(
                child: CustomTextField(
              label: '마감시간',
              onSaved: onEndSaved,
              validator: onEndValidator,
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
  const _Content({super.key, required this.onSaved, required this.onValidate});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomTextField(
        label: '내용',
        expand: true,
        onSaved: onSaved,
        validator: onValidate,
      ),
    );
  }
}

typedef OnColorSelected = void Function(
    Color color); // 이거랑 final Function(Color color) onTap; 이거랑 같은동작을 한다.

class _Categorys extends StatelessWidget {
  final Color selectedColor;
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
                        color: e,
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
