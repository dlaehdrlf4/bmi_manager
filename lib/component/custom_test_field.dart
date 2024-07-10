import 'package:bmi_manager/const/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final bool expand;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final String? initialValue;
  const CustomTextField(
      {super.key,
      required this.label,
      this.expand = false,
      required this.onSaved,
      required this.validator,
      this.initialValue});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label',
          style: TextStyle(color: PRIMARY_COLOR, fontWeight: FontWeight.w600),
        ),
        if (expand) Expanded(child: renderTextFomfield()),
        if (!expand) renderTextFomfield(),
      ],
    );
  }

  renderTextFomfield() {
    return TextFormField(
      maxLines: expand ? null : 1,
      minLines: expand ? null : 1,
      expands: expand,
      decoration: InputDecoration(
          border: InputBorder.none, fillColor: Colors.grey[300], filled: true),
      cursorColor: Colors.grey,
      //저장했을때
      onSaved: onSaved,
      //검증할때 로직
      validator: validator,
      initialValue: initialValue,
    );
  }
}
