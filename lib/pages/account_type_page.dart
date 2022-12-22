import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:islandmfb_flutter_version/components/account_type_page.dart/account_type_button.dart';
import 'package:islandmfb_flutter_version/components/shared/app_button.dart';
import 'package:islandmfb_flutter_version/models/create_account_form.dart';
import 'package:islandmfb_flutter_version/models/requests/account_types_response.dart';
import 'package:islandmfb_flutter_version/requests/create_account_requests.dart';
import 'package:islandmfb_flutter_version/state/signup_state_controller.dart';
import 'package:islandmfb_flutter_version/utilities/colors.dart';
import 'package:get/get.dart';

import '../models/response_model.dart';

class AccountTypePageState extends GetxController {
  var loadingAccountTypes = false.obs;
  Rxn<ResponseM<List<AccountTypesResponse>>> accountTypes =
      Rxn<ResponseM<List<AccountTypesResponse>>>();
  StreamSubscription? getAccountTypesSubscription;
  Rxn<AccountTypesResponse> selectedAccountType = Rxn<AccountTypesResponse>();
  var isCreateAccountButtonDisabled = true.obs;

  @override
  void onInit() {
    super.onInit();
    // prevent any asynchronous fetching wh
    getAccountTypesSubscription?.cancel();
    // start the data fetching for all the account types
    getAccountTypesSubscription =
        getAccountTypesProduct().asStream().listen((event) {
      accountTypes.value = event;
    });
  }

  refreshAccountTypes() {
    // cancel data fetching if refresh is clicked multiple times
    getAccountTypesSubscription?.cancel();
    // set account types to null to indicate loading
    accountTypes.value = null;
    selectedAccountType.value = null;
    // actual data fetching on refresh
    getAccountTypesSubscription =
        getAccountTypesProduct().asStream().listen((event) {
      accountTypes.value = event;
    });
  }

  setAccountTypeResponse(AccountTypesResponse newAccountType) {
    // sets the selected account type
    selectedAccountType.value = newAccountType;
    // checks to see if the selectedAccountType is null
    // if it is not null, enables the create account button
    if (selectedAccountType.value != null) {
      isCreateAccountButtonDisabled.value = false;
    }
  }
}

class AccountTypePage extends StatelessWidget {
  AccountTypePage({Key? key}) : super(key: key);

  final CreateAccountFormController createAccountFormController = Get.find();
  final AccountTypePageState accountTypePageState =
      Get.put(AccountTypePageState());

  

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
        centerTitle: true,
        elevation: 0,
        toolbarHeight: 80,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 20,
        ),
        child: Obx(
          () => AppButton(
            text: "Create Account",
            onPress: () {
              // Get.to(()=> const AccountServicesPage());
            },
            isDisabled:
                accountTypePageState.isCreateAccountButtonDisabled.value,
          ),
        ),
      ),
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 30,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...const [
                SizedBox(
                  height: 1,
                ),
                Text(
                  "Account Type",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF333333)),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.only(),
                  child: Text(
                    "Select an account type",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w100),
                  ),
                ),
                SizedBox(
                  height: 40,
                )
              ],
              Obx(
                () => accountTypePageState.accountTypes.value == null
                    ?
                    // loadding
                    Column(
                        children: const [
                          SizedBox(height: 10),
                          Center(
                              child: CircularProgressIndicator(
                            color: primaryColor,
                          ))
                        ],
                      )
                    : accountTypePageState.accountTypes.value != null &&
                            accountTypePageState
                                    .accountTypes.value!.customErrorMessage !=
                                null
                        ?
                        // Error
                        Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(height: 30),
                                Text(accountTypePageState
                                    .accountTypes.value!.customErrorMessage!),
                                const SizedBox(
                                  height: 2,
                                ),
                                TextButton(
                                    onPressed: () {
                                      accountTypePageState
                                          .refreshAccountTypes();
                                    },
                                    child: const Text(
                                      "Refresh",
                                      style: TextStyle(color: primaryColor),
                                    ))
                              ],
                            ),
                          )
                        :
                        // data
                        Column(children: [
                            ...accountTypePageState.accountTypes.value!.data!
                                .map((e) => Column(
                                      children: [
                                        AccountTypeButtons(
                                            accountType: e,
                                            onSelect: (accountTypesResponse) {
                                              accountTypePageState
                                                  .setAccountTypeResponse(
                                                      accountTypesResponse);
                                              createAccountFormController
                                                  .setAccountType(
                                                      accountTypesResponse);
                                            },
                                            selected: accountTypePageState
                                                            .selectedAccountType
                                                            .value !=
                                                        null &&
                                                    accountTypePageState
                                                            .selectedAccountType
                                                            .value!
                                                            .productcode ==
                                                        e.productcode
                                                ? true
                                                : false),
                                        const SizedBox(
                                          height: 10,
                                        )
                                      ],
                                    ))
                                .toList()
                          ]),
              ),

              // AccountTypeButtons(accountType: "Savings Account"),
              // SizedBox(
              //   height: 10,
              // ),
              // AccountTypeButtons(accountType: "Current Account"),
              // SizedBox(
              //   height: 10,
              // ),
              // AccountTypeButtons(accountType: "Esusu"),
              // SizedBox(
              //   height: 10,
              // ),
              // AccountTypeButtons(accountType: "Terms Loan"),
              // SizedBox(
              //   height: 10,
              // ),
              // AccountTypeButtons(accountType: "Staff Loan"),
              // SizedBox(
              //   height: 10,
              // ),
              // AccountTypeButtons(accountType: "Mortgage Loan"),
              // SizedBox(
              //   height: 10,
              // ),
              // AccountTypeButtons(accountType: "Call Deposit"),
              // SizedBox(
              //   height: 40,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
