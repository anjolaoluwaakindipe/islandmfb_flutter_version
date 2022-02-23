import 'package:flutter/material.dart';
import 'package:islandmfb_flutter_version/utilities/colors.dart';

class AppButton extends StatelessWidget {
  const AppButton({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            text,
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.w700, letterSpacing: 1.3),
          ),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(primaryColor),
          elevation: MaterialStateProperty.all(2),
        ),
      ),
    );
  }
}
