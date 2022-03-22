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
      this.enabled})
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
              fontWeight: FontWeight.w600,
              color: labelColor ?? blackColor,
            ),
          ),
          const SizedBox(
            height: 10,
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
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
                  isCollapsed: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
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
      ),
    );
  }
}
