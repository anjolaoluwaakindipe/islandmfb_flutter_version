import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:islandmfb_flutter_version/pages/lets_get_started_page.dart';
import 'package:islandmfb_flutter_version/pages/login_page.dart';
import 'package:islandmfb_flutter_version/utilities/colors.dart';
import 'package:get/get.dart';

class GetStartedSignInLink extends StatelessWidget {
  const GetStartedSignInLink({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        text: TextSpan(
          style: GoogleFonts.poppins(fontSize: 15),
          children: <TextSpan>[
            const TextSpan(
              text: "Have an account? ",
              style: TextStyle(
                color: Color(0xFF333333),
              ),
            ),
            TextSpan(
              text: "Sign in",
              style: const TextStyle(color: successColor),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Get.to(const LetsGetStartedPage());
                },
            ),
          ],
        ),
      ),
    );
  }
}
