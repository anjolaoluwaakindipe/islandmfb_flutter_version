import 'dart:html';

import 'package:bs_flutter/bs_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:islandmfb_flutter_version/utilities/colors.dart';

class BillPaymentPage extends StatefulWidget {
  const BillPaymentPage({Key? key}) : super(key: key);

  @override
  _BillPaymentPageState createState() => _BillPaymentPageState();
}

class _BillPaymentPageState extends State<BillPaymentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: whiteColor,
        leading: SizedBox(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                "assets/images/back.svg",
                height: 20,
              ),
            ),
          ),
        ),
        title: const Text(
          "Bill Payment",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: blackColor,
          ),
        ),
        centerTitle: true,
        toolbarHeight: 80,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 0,
        ),
        margin: const EdgeInsets.all(5),
        child: ListView(children: <Widget>[
          // Container(
          //   height: 100,
          //   padding: const EdgeInsets.symmetric(
          //     horizontal: 30,
          //   ),
          //   margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
          //   color: primaryColor,
          //   child: Center(
          //     // child: ListTile(
          //     //   leading: SvgPicture.asset("assets/images/CableTvLite.svg"),
          //     //   title: const Text(
          //     //     'Cable TV',
          //     //     textScaleFactor: 1.5,
          //     //   ),
          //     //   contentPadding: const EdgeInsets.all(5),
          //     //   iconColor: whiteColor,
          //     //   textColor: whiteColor,
          //     //   trailing: const Icon(Icons.chevron_right),
          //     // ),
          //     child: ListView.separated(
          //       padding: const EdgeInsets.all(8),
          //       itemCount: entries.length,
          //       itemBuilder: (BuildContext context, int index) {
          //         return Container(
          //           height: 50,
          //           color: Colors.amber[colorCodes[index]],
          //           child: Center(child: Text('Entry ${entries[index]}')),
          //         );
          //       },
          //       separatorBuilder: (BuildContext context, int index) =>
          //           const Divider(),
          //     ),
          //   ),
          // ),
          // Container(
          //   height: 100,
          //   padding: const EdgeInsets.symmetric(
          //     horizontal: 30,
          //   ),
          //   margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
          //   color: accentColor,
          //   child: Center(
          //     child: ListTile(
          //       leading: SvgPicture.asset("assets/images/WifiPainted.svg"),
          //       title: const Text(
          //         'Internet Service',
          //         textScaleFactor: 1.5,
          //       ),
          //       contentPadding: const EdgeInsets.all(5),
          //       iconColor: primaryColor,
          //       trailing: const Icon(Icons.chevron_right),
          //     ),
          //   ),
          // ),
          // Container(
          //   height: 100,
          //   color: accentColor,
          //   padding: const EdgeInsets.symmetric(
          //     horizontal: 30,
          //   ),
          //   margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
          //   child: Center(
          //     child: ListTile(
          //       leading: SvgPicture.asset("assets/images/UtilityPainted.svg"),
          //       hoverColor: primaryColor,
          //       focusColor: primaryColor,
          //       title: const Text(
          //         'Utility',
          //         textScaleFactor: 1.5,
          //       ),
          //       contentPadding: const EdgeInsets.all(5),
          //       iconColor: primaryColor,
          //       trailing: const Icon(Icons.chevron_right),
          //     ),
          //   ),
          // ),
          // Container(
          //   color: accentColor,
          //   height: 100,
          //   padding: const EdgeInsets.symmetric(
          //     horizontal: 30,
          //   ),
          //   margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
          //   child: const Center(
          //     child: ListTile(
          //       leading: Icon(Icons.account_balance_outlined),
          //       title: Text(
          //         'Insurance',
          //         textScaleFactor: 1.5,
          //       ),
          //       contentPadding: EdgeInsets.all(5),
          //       iconColor: primaryColor,
          //       trailing: Icon(Icons.chevron_right),
          //     ),
          //   ),
          // ),
          SizedBox(
              height: 100,
              child: Ink(
                child: ListTile(
                  title: const Text('Sun'),
                  trailing: const Icon(Icons.keyboard_arrow_right),
                  onTap: () {
                    setState(() {});
                  },
                ),
              )),
          ListTile(
            title: const Text('Moon'),
            trailing: const Icon(Icons.keyboard_arrow_right),
            onTap: () {
              print('Moon');
            },
          ),
          ListTile(
            title: const Text('Star'),
            trailing: const Icon(Icons.keyboard_arrow_right),
            onTap: () {
              print('Star');
            },
          ),
        ]),
      ),
    );
  }
}

// class MyStatefulWidget extends StatefulWidget {
//   const MyStatefulWidget({Key? key}) : super(key: key);

//   @override
//   State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
// }

// class _MyStatefulWidgetState extends State<MyStatefulWidget> {
//   int _selectedIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: 1,
//       itemBuilder: (BuildContext context, int index) {
//         return ListTile(
//           title: const Text('Item hi'),
//           selected: index == _selectedIndex,
//           selectedColor: accentColor,
//           selectedTileColor: primaryColor,
//           onTap: () {
//             setState(() {
//               _selectedIndex = index;
//             });
//           },
//         );
//       },
//     );
//   }
// }
