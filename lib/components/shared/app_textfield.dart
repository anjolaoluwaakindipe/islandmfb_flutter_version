import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
      this.hideText = false,
      this.inputFormatters,
      this.suffixIconWidget,
      this.validator,
      this.readOnly = false,
      this.enabled,
      this.suffixIcon})
      : super(key: key);

  String label;
  String hint;
  TextEditingController textController;
  Color? labelColor;
  var onChanged;
  TextInputType? textInputType;
  int? maxCharacterLength;
  bool hideText;
  List<TextInputFormatter>? inputFormatters;
  Widget? suffixIconWidget;
  String? Function(String?)? validator;
  bool readOnly;
  bool? enabled;
  Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label != ""
            ? Text(
                label,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: labelColor ?? blackColor,
                ),
              )
            : Container(
                height: 0,
              ),
        label != ""
            ? const SizedBox(
                height: 10,
              )
            : Container(
                height: 0,
              ),
        Container(
          decoration: const BoxDecoration(
            color: Colors.transparent,
          ),
          child: Center(
            child: TextFormField(
              keyboardType: textInputType,
              maxLength: maxCharacterLength,
              obscureText: hideText,
              cursorColor: primaryColor,
              cursorWidth: 2,
              decoration: InputDecoration(
                suffixIconConstraints: BoxConstraints(maxWidth: 60),
                contentPadding: const EdgeInsets.only(
                    left: 10, right: 20, top: 25, bottom: 25),
                isCollapsed: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10.0),
                  
                ),
                
                suffix: suffixIcon,
                hintText: hint,
                filled: true,
                errorStyle: const TextStyle(color: primaryColor),
                fillColor: accentColor,
                hoverColor: accentColor,
                suffixIcon: suffixIconWidget,
              ),
              controller: textController,
              onChanged: onChanged,
              inputFormatters: inputFormatters,
              validator: validator,
              readOnly: readOnly,
              enabled: enabled,
            ),
          ),
        ),
      ],
    );
  }
}
