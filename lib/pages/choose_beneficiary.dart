import 'package:flutter/material.dart';
import 'package:flutter_initicon/flutter_initicon.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:islandmfb_flutter_version/components/shared/app_textfield.dart';
import 'package:islandmfb_flutter_version/models/beneficiary.dart';
import 'package:islandmfb_flutter_version/pages/home_page.dart';
import 'package:islandmfb_flutter_version/utilities/colors.dart';

class ChooseBeneficiary extends StatefulWidget {
  ChooseBeneficiary({Key? key}) : super(key: key);

  @override
  State<ChooseBeneficiary> createState() => _ChooseBeneficiaryState();
}

class _ChooseBeneficiaryState extends State<ChooseBeneficiary> {
  // state
  bool isSearching = false;

  List<Beneficiary> beneficiaries = [
    Beneficiary(
        accountNumber: "3110777062",
        bank: "United Bank of Afica",
        name: "Anjolaoluwa Akindipe"),
    Beneficiary(
        accountNumber: "3110777062", bank: "GT Bank", name: "Damilare Adeniyi"),
    Beneficiary(
        accountNumber: "3110777062", bank: "Zenith Bank", name: "Jason Osoba"),
    Beneficiary(
        accountNumber: "3110777062", bank: "EcoBank", name: "Osih Osemeke"),
  ];

  List<Beneficiary>? copyBeneficiaries;

  void onSearchButtonHandler(String searchValue) {
    if (searchValue.trim() != "") {
      setState(() {
        beneficiaries = copyBeneficiaries!
            .where(
              (element) => element.name
                  .toLowerCase()
                  .contains(searchValue.trim().toLowerCase()),
            )
            .toList();
      });
    } else {
      setState(() {
        beneficiaries = copyBeneficiaries!;
      });
    }
  }

  // Text Controllers
  TextEditingController chooseBeneficiarySearchController =
      TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    copyBeneficiaries = beneficiaries;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: SvgPicture.asset(
              "assets/images/back.svg",
              height: 20,
            ),
          ),
        ),
        backgroundColor: whiteColor,
        title: const Text(
          "Choose Beneficiary",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: blackColor,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        toolbarHeight: 80,
      ),
      backgroundColor: whiteColor,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              // Top Component
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "BENEFICIARIES",
                    style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        letterSpacing: 0.9),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        isSearching = !isSearching;
                      });
                      if (!isSearching) {
                        setState(() {
                          beneficiaries = copyBeneficiaries!;
                        });
                      }
                    },
                    icon: isSearching
                        ? const Icon(Icons.cancel)
                        : const Icon(Icons.search),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Search Bar
              isSearching
                  ? Column(
                      children: [
                        AppTextField(
                          textController: chooseBeneficiarySearchController,
                          hint: "Search for beneficiary...",
                          onChanged: (value) {
                            onSearchButtonHandler(value);
                          },
                        ),
                        const SizedBox(height: 10),
                      ],
                    )
                  : Container(),

              // List of Beneficiaries
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: beneficiaries.length,
                separatorBuilder: (context, integer) => const SizedBox(
                  height: 20,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return ChooseBeneficiaryBeneficiaryButtons(
                      accountNo: beneficiaries[index].accountNumber,
                      bank: beneficiaries[index].bank,
                      name: beneficiaries[index].name);
                },
              ),

              const SizedBox(
                height: 40,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ChooseBeneficiaryBeneficiaryButtons extends StatelessWidget {
  ChooseBeneficiaryBeneficiaryButtons(
      {Key? key, this.accountNo = "", this.bank = "", this.name = ""})
      : super(key: key);

  String name;
  String accountNo;
  String bank;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Ink(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        decoration: BoxDecoration(
            color: accentColor, borderRadius: BorderRadius.circular(5)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Initicon(
              text: name,
              color: whiteColor,
              backgroundColor: primaryColor,
            ),
            const SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.w600)),
                Text(
                  "Account #" + accountNo,
                  style: const TextStyle(
                      fontSize: 12, color: lightextColor, letterSpacing: 0.8),
                ),
                Text(
                  bank,
                  style: const TextStyle(
                    fontSize: 12,
                    color: lightextColor,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
