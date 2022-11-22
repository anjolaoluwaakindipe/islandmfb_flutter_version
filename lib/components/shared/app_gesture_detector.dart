import 'package:flutter/material.dart';

class AppGestureDetector extends StatelessWidget {
   const AppGestureDetector({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: () {
      FocusScopeNode currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
        currentFocus.focusedChild?.unfocus();
      }
      
    }, child: child  ,);
  }
}
