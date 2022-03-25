import 'package:flutter/material.dart';
import 'package:islandmfb_flutter_version/utilities/colors.dart';

class AppAlertDialogue extends StatelessWidget {
  const AppAlertDialogue(
      {Key? key,
      this.content = "",
      this.title = "",
      this.contentColor = blackColor,
      required this.actions})
      : super(key: key);

  final String content;
  final String title;
  final Color contentColor;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        elevation: 2,
        title: Text(title, style: const TextStyle(fontSize: 8)),
        content: Text(content, style: TextStyle(color: contentColor)),
        actions: actions);
  }
}
