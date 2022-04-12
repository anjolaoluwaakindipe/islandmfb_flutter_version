// drop down menu items builder
import 'package:flutter/material.dart';

DropdownMenuItem<String> buildMenuItem(String item) {
  return DropdownMenuItem(
    child: Text(item),
    value: item,
  );
}
