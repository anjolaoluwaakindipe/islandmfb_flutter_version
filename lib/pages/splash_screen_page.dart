import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:islandmfb_flutter_version/pages/get_started_page.dart';
import 'package:islandmfb_flutter_version/utilities/colors.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 4),
        () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => GetStartedPage())));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child:
          Center(child: SvgPicture.asset("assets/images/splashscreenLogo.svg")),
      decoration: const BoxDecoration(
        color: blackColor,
        image: DecorationImage(
          image: AssetImage("assets/images/splashscreenbackground.png"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
