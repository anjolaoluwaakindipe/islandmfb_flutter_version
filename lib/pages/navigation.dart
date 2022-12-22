import 'package:get/get.dart';
import 'package:islandmfb_flutter_version/pages/account_type_page.dart';
import 'package:islandmfb_flutter_version/pages/airtime_page.dart';
import 'package:islandmfb_flutter_version/pages/airtime_verification.dart';
import 'package:islandmfb_flutter_version/pages/create_account_new_page.dart';
import 'package:islandmfb_flutter_version/pages/get_started_page.dart';
import 'package:islandmfb_flutter_version/pages/home_page.dart';
import 'package:islandmfb_flutter_version/pages/lets_get_started_page.dart';
import 'package:islandmfb_flutter_version/pages/login_page.dart';
import 'package:islandmfb_flutter_version/pages/personal_informaton_page.dart';
import 'package:islandmfb_flutter_version/pages/sign_up_active_page.dart';
import 'package:islandmfb_flutter_version/pages/splash_screen_page.dart';
import 'package:islandmfb_flutter_version/pages/transfer_to_other_banks_page.dart';
import 'package:islandmfb_flutter_version/pages/verification_page.dart';

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
  static const splashScreenPage = "/splash-screen";
  static const accountTypePage = "/account-type";
}

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.homePage,
      page: () => const HomePage(),
    ),
    GetPage(
      name: AppRoutes.airtimePage,
      page: () => const AirtimePage(),
    ),
    GetPage(
      name: AppRoutes.transferPage,
      page: () => const TransferToOtherBanksPage(),
    ),
    GetPage(
        name: AppRoutes.airtimeVerificationPage,
        page: () => const AirtimeVerificationPage()),
    GetPage(
        name: AppRoutes.splashScreenPage, page: () => const SplashScreenPage()),
    GetPage(name: AppRoutes.getStartedPage, page: () => GetStartedPage()),
    GetPage(
        name: AppRoutes.letsGetStartedPage,
        page: () => const LetsGetStartedPage()),
    GetPage(
        name: AppRoutes.signUpActivePage, page: () => const SignUpActivePage()),
    GetPage(name: AppRoutes.verificationPage, page: () => const VerificationPage()),
    GetPage(
        name: AppRoutes.createAccountNewPage,
        page: () => const CreateAccountNewPage()),
    GetPage(
        name: AppRoutes.personalInformationPage,
        page: () => const PersonalInformationPage()),
    GetPage(name: AppRoutes.loginPage, page: () => const LoginPage()),
    GetPage(name: AppRoutes.accountTypePage, page: () => AccountTypePage())
  ];
}
