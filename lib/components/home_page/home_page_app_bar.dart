  import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:islandmfb_flutter_version/utilities/colors.dart';

AppBar homePageAppBar(Function() alertButtonHandler) {
    return AppBar(
      backgroundColor: whiteColor,
      elevation: 0,
      titleSpacing: 0,
      toolbarHeight: 80,
      leading: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: Builder(builder: (context) {
          return IconButton(
            icon: SizedBox(
              height: 15,
              width: 15,
              child: SvgPicture.asset(
                "assets/images/menuNav.svg",
                fit: BoxFit.cover,
              ),
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          );
        }),
      ),
      actions: [
        IconButton(
          icon: SvgPicture.asset(
            "assets/images/alertNav.svg",
            height: 20,
          ),
          onPressed: alertButtonHandler,
        ),
        const SizedBox(
          width: 18,
        ),
      ],
    );
  }

