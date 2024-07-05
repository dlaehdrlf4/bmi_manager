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
  Color selectedColor = categoryColor.first;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 600,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 16, left: 8, right: 8),
          child: Column(
            children: [
              _Time(),
              const SizedBox(
                height: 8,
              ),
              _Content(),
              const SizedBox(
                height: 8,
              ),
              _Categorys(
                selectedColor: selectedColor,
                onTap: (Color color) {
                  print(color);
                  setState(() {
                    selectedColor = color;
                  });
                },
              ),
              const SizedBox(
                height: 8,
              ),
              _SaveButton(),
              const SizedBox(
                height: 8,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Time extends StatelessWidget {
  const _Time({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
            child: CustomTextField(
          label: '시작시간',
        )),
        SizedBox(
          width: 16,
        ),
        Expanded(
            child: CustomTextField(
          label: '마감시간',
        )),
      ],
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({super.key});

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: CustomTextField(
        label: '내용',
        expand: true,
      ),
    );
  }
}

typedef OnColorSelected = void Function(Color color);

class _Categorys extends StatelessWidget {
  final Color selectedColor;
  final VoidCallback(Color color) onTap;
  const _Categorys({super.key, required this.selectedColor, required this.onTap});

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
                        border: selectedColor == e ? Border.all(color: Colors.black, width: 4) : null),
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
  const _SaveButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {},
            child: Text('저장'),
            style: ElevatedButton.styleFrom(backgroundColor: PRIMARY_COLOR, foregroundColor: Colors.white),
          ),
        ),
      ],
    );
  }
}
