import 'package:get/get.dart';
import 'package:islandmfb_flutter_version/pages/airtime_page.dart';
import 'package:islandmfb_flutter_version/pages/home_page.dart';
import 'package:islandmfb_flutter_version/pages/transfer_page.dart';

abstract class AppRoutes {
  static const homePage = "/home";
  static const accountServicesPage = "/account-services";
  static const airtimePage = "/airtime";
  static const airtimeVerificationPage = "/airtime-verification";
  static const createAccountNewPage = "/create-account-new";
  static const failurePage = "/failure";
  static const forgotPasswordPage = "/forgot-password";
  static const forgotPasswordVerificationPage = "/forgot-password-verification";
  static const getStartedPage = "/get-started";
  static const letsGetStartedPage = "/lets-get-started";
  static const linkBVNPage = "/link-BVN";
  static const loanPage = "/loan";
  static const loginPage = "/login";
  static const personalInformationPage = "/personal-information";
  static const resetPasswordPage = "/reset-password";
  static const selfServicePage = "/self-service";
  static const signUpActivePage = "/signup-active";
  static const statementOfAccount = "/statement-of-account";
  static const successPage = "/success";
  static const transferPage = "/transfer";
  static const verificationPage = "/verification";
}

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.homePage,
      page: () => HomePage(),
    ),
    GetPage(
      name: AppRoutes.airtimePage,
      page: () => AirtimePage(),
    ),
    GetPage(
      name: AppRoutes.transferPage,
      page: () => TransferPage(),
    )
  ];
}
