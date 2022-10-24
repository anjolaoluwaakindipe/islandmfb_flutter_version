import 'package:flutter/material.dart';
import 'package:islandmfb_flutter_version/utilities/colors.dart';

class AppSwitch extends StatefulWidget {
  const AppSwitch({Key? key, required this.ontoggleChange}) : super(key: key);
  final Function(bool) ontoggleChange;

  @override
  _AppSwitchState createState() => _AppSwitchState();
}

class _AppSwitchState extends State<AppSwitch> {
  bool isSwitched = false;
  // var textValue = 'Switch is OFF';

  void toggleSwitch(bool value) {
    if (isSwitched == false) {
      setState(() {
        isSwitched = true;
      });

    } else {
      setState(() {
        isSwitched = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Switch(
        onChanged: (bool value) {
          toggleSwitch(value);
          widget.ontoggleChange(value);
        },
        value: isSwitched,
        activeColor: primaryColor,
        activeTrackColor: accentColor,
        inactiveThumbColor: accentColor,
        inactiveTrackColor: accentColor,
      ),
    ]);
  }
}
