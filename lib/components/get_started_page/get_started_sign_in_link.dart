import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
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
          children: const <TextSpan>[
            TextSpan(
              text: "Have an account? ",
              style: TextStyle(
                color: Color(0xFF333333),
              ),
            ),
            TextSpan(
              text: "Sign in",
              style: TextStyle(color: successColor),
            ),
          ],
        ),
      ),
    );
  }
}
