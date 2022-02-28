import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utilities/colors.dart';

class AppTextField extends StatelessWidget {
  AppTextField(
      {Key? key,
      this.label = "",
      this.hint = "",
      required this.textController,
      this.onChanged,
      this.labelColor,
      this.textInputType,
      this.maxCharacterLength,
      this.hideText = false})
      : super(key: key);

  String label;
  String hint;
  TextEditingController textController;
  Color? labelColor;
  var onChanged;
  TextInputType? textInputType;
  int? maxCharacterLength;
  bool hideText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w200,
              color: labelColor ?? blackColor,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 60,
            decoration: BoxDecoration(
              color: accentColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: TextFormField(
                keyboardType: textInputType,
                maxLength: maxCharacterLength,
                obscureText: hideText,
                cursorColor: primaryColor,
                cursorWidth: 1,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: hint,
                  filled: true,
                  counter: const SizedBox(),
                  fillColor: Colors.transparent,
                  hoverColor: accentColor,
                ),
                controller: textController,
                onChanged: onChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
