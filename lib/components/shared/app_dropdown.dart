import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../../utilities/colors.dart';

class AppDropdown extends StatefulWidget {
  const AppDropdown(
      {Key? key,
      required this.requiredItems,
      required this.itemValue,
      required this.text,
      required this.hintText})
      : super(key: key);

  final List<String> requiredItems;
  final String? itemValue;
  final String text;
  final String hintText;

  @override
  State<AppDropdown> createState() => _AppDropdownState();
}

class _AppDropdownState extends State<AppDropdown> {
  String? _itemValue;

  @override
  void initState() {
    super.initState();
    _itemValue = widget.itemValue;
  }

  DropdownMenuItem<String> buildMenuItem(String item) {
    return DropdownMenuItem(
      value: item,
      child: Text(item),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        widget.text,
        style: const TextStyle(
            fontSize: 15, color: blackColor, fontWeight: FontWeight.w600),
      ),
      const SizedBox(height: 10),
      DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          items: widget.requiredItems.map(buildMenuItem).toList(),
          onChanged: (value) => setState(() => _itemValue = value),
          hint: Text(widget.hintText),
          isExpanded: true,
          value: _itemValue,
          buttonHeight: 70,
          buttonPadding:
              const EdgeInsets.symmetric(horizontal: 15.0, vertical: 4),
          dropdownElevation: 0,
          offset: const Offset(0, -4),
          buttonDecoration: BoxDecoration(
            color: accentColor,
            borderRadius: BorderRadius.circular(10),
          ),
          dropdownDecoration: BoxDecoration(
            color: accentColor,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    ]);
  }
}
