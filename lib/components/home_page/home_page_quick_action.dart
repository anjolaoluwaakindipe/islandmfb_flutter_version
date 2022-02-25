import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:islandmfb_flutter_version/utilities/colors.dart';

class HomePageQuicActionButtons extends StatelessWidget {
  const HomePageQuicActionButtons(
      {Key? key,
      required this.name,
      required this.onTap,
      required this.svgUrlString})
      : super(key: key);

  final void Function() onTap;
  final String name;
  final String svgUrlString;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: whiteColor,
      onTap: onTap,
      child: Ink(
        height: 80,
        width: 80,
        decoration: BoxDecoration(
          color: accentColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                svgUrlString,
                height: 20,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                name,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
