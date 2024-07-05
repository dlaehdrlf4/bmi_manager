import 'package:bmi_manager/const/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final bool expand;
  const CustomTextField({super.key, required this.label, this.expand = false});

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
      decoration: InputDecoration(border: InputBorder.none, fillColor: Colors.grey[300], filled: true),
      cursorColor: Colors.grey,
    );
  }
}
