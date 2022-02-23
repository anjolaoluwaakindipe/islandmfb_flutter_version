import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utilities/colors.dart';

class AppTextField extends StatelessWidget {
  AppTextField({Key? key, this.label = "", this.hint = ""}) : super(key: key);

  String label;
  String hint;

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
            ),
          ),
          TextFormField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hint,
              filled: true,
              fillColor: accentColor,
            ),
          ),
        ],
      ),
    );
  }
}
