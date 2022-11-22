import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:islandmfb_flutter_version/components/shared/app_button.dart';
import 'package:islandmfb_flutter_version/utilities/colors.dart';
import 'package:get/get.dart';

class SuccessPage extends StatefulWidget {
  SuccessPage(
      {Key? key,
      this.nextPage,
      required this.buttonText,
      required this.successMessage,
      this.offAll})
      : super(key: key);

  Widget? nextPage;
  String buttonText;
  String successMessage;
  bool? offAll;

  @override
  State<SuccessPage> createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage>
    with TickerProviderStateMixin {
  late ConfettiController confettiController;

  late AnimationController animationController;
  double offsetY = 0;

  @override
  void initState() {
    // TODO: implement initState
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 300,
      ),
      lowerBound: 0.0,
      upperBound: 30.0,
    )..addListener(() {
        setState(() {});
        if (animationController.isCompleted) {
          animationController.repeat(
            reverse: true,
          );
        }
      });
    super.initState();

    animationController.forward();

    confettiController =
        ConfettiController(duration: const Duration(seconds: 3));
    confettiController.play();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    confettiController.dispose();
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: AppButton(
          text: widget.buttonText,
          onPress: () {
            if (widget.offAll != null && widget.offAll == true) {
              Get.offAll(widget.nextPage);
            } else {
              Get.off(() => widget.nextPage);
            }
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: ConfettiWidget(
                confettiController: confettiController,
                shouldLoop: true,
                blastDirection: pi / 2,
                blastDirectionality: BlastDirectionality.explosive,
                emissionFrequency: 0.018,
                particleDrag: 0.02,
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Transform.translate(
                    offset: Offset(0, -animationController.value),
                    child: SvgPicture.asset(
                      "assets/images/bi_shield-fill-check.svg",
                      semanticsLabel: 'Success',
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    "Success!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w200,
                        color: Color(0xFF333333)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 1.0),
                    child: Text(
                      widget.successMessage,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w100),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      backgroundColor: whiteColor,
    );
  }
}
