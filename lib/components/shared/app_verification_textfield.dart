import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CodeInput extends StatelessWidget {
  final FocusNode focusNode0;
  final FocusNode focusNode1;
  final FocusNode focusNode2;

  const CodeInput({
    Key? key,
    required this.focusNode0,
    required this.focusNode1,
    required this.focusNode2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 15,
          child: TextField(
            focusNode: focusNode1,
            textAlign: TextAlign.center,
            maxLength: 1,
            onChanged: (str) {
              if (str.length == 1) {
                FocusScope.of(context).requestFocus(focusNode2);
              } else if (str.length == 0) {
                FocusScope.of(context).requestFocus(focusNode0);
              }
            },
            decoration: InputDecoration(
              hintText: "*",
              hintStyle: TextStyle(color: Colors.grey),
              counterText: "",
            ),
          ),
        ),
      ],
    );
  }
}
