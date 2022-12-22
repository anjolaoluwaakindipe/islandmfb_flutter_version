import 'package:flutter/material.dart';
import 'package:islandmfb_flutter_version/utilities/colors.dart';

class AppButton extends StatefulWidget {
  const AppButton(
      {Key? key,
      required this.text,
      required this.onPress,
      this.isDisabled = false,
      this.iconic})
      : super(key: key);

  final String text;
  final IconData? iconic;
  final void Function() onPress;
  final bool isDisabled;

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: widget.isDisabled ? null : widget.onPress,
        style: ButtonStyle(
          backgroundColor: widget.isDisabled
              ? MaterialStateProperty.all<Color>(disabledColor)
              : MaterialStateProperty.all<Color>(primaryColor),
          elevation: MaterialStateProperty.all(1),
        ),
        child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              widget.text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.3,
                  color: whiteColor),
            )),
      ),
    );
  }

  void naviGate() {}
}
