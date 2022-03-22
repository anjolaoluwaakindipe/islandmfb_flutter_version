import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:islandmfb_flutter_version/pages/cable_tv_page.dart';
import 'package:islandmfb_flutter_version/pages/home_page.dart';
import 'package:islandmfb_flutter_version/pages/insurance_page.dart';
import 'package:islandmfb_flutter_version/pages/internet_service_page.dart';
import 'package:islandmfb_flutter_version/pages/utility_page.dart';
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
              onPressed: () {
                Get.to(const HomePage());
              },
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
      backgroundColor: whiteColor,
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
        ),
        child: ListView(children: <Widget>[
          ListTile(
            leading: SvgPicture.asset("assets/images/CableTvLite.svg",
                color: primaryColor),
            title: const Text('Cable TV', style: TextStyle(fontSize: 15)),
            contentPadding: const EdgeInsets.all(5),
            iconColor: blackColor,
            textColor: blackColor,
            trailing: const Icon(Icons.chevron_right),
            visualDensity: const VisualDensity(vertical: 3),
            tileColor: accentColor,
            onTap: () {
              Get.to(const CableTvPage());
            },
          ),
          const SizedBox(
            height: 10,
          ),
          ListTile(
            leading: SvgPicture.asset("assets/images/WifiPainted.svg"),
            title:
                const Text('Internet Service', style: TextStyle(fontSize: 15)),
            contentPadding: const EdgeInsets.all(5),
            iconColor: primaryColor,
            trailing: const Icon(Icons.chevron_right),
            visualDensity: const VisualDensity(vertical: 3),
            tileColor: accentColor,
            onTap: () {
              Get.to(const InternetServicePage());
            },
          ),
          const SizedBox(
            height: 10,
          ),
          ListTile(
            leading: SvgPicture.asset("assets/images/UtilityPainted.svg"),
            hoverColor: primaryColor,
            focusColor: primaryColor,
            title: const Text('Utility', style: TextStyle(fontSize: 15)),
            contentPadding: const EdgeInsets.all(5),
            iconColor: primaryColor,
            visualDensity: const VisualDensity(vertical: 3),
            tileColor: accentColor,
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Get.to(const UtilityPage());
            },
          ),
          const SizedBox(
            height: 10,
          ),
          ListTile(
            leading: const Icon(Icons.account_balance_outlined),
            title: const Text('Insurance', style: TextStyle(fontSize: 15)),
            contentPadding: const EdgeInsets.all(5),
            iconColor: primaryColor,
            visualDensity: const VisualDensity(vertical: 3),
            tileColor: accentColor,
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Get.to(InsurancePage());
            },
          ),
          const SizedBox(
            height: 40,
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
