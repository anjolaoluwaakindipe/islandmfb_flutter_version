import 'package:get/get.dart';
import 'package:islandmfb_flutter_version/models/create_account_form.dart';
import 'package:islandmfb_flutter_version/models/requests/account_types_response.dart';
import 'package:islandmfb_flutter_version/models/response_model.dart';
import 'package:islandmfb_flutter_version/models/set_profile_form.dart';
import 'package:islandmfb_flutter_version/requests/auth_request.dart';
import 'package:islandmfb_flutter_version/requests/create_account_requests.dart';

class SetUpProfileFormController extends GetxController {
  final _setUpProfileFormState = SetProfileForm(
          accountNo: "",
          firstName: "",
          email: "",
          lastName: "",
          password: "",
          phoneRef: "",
          loginId: "",
          customerNo: "")
      .obs;

  setAccountNumberUsernameAndPassword(
      String accountNumber, String password, String username) {
    _setUpProfileFormState.update((val) {
      val?.accountNo = accountNumber;
      val?.password = password;
      val?.loginId = username;
    });
    _setUpProfileFormState.refresh();
  }

// send otp to user
  Future<ResponseM> sendOtp() async {
    // check if account no is empty
    if (_setUpProfileFormState.value.accountNo == "") {
      return ResponseM(customErrorMessage: "Please provide an account number");
    }

    // check if password is empty
    if (_setUpProfileFormState.value.password.isEmpty) {
      return ResponseM(customErrorMessage: "Please provide a password");
    }

    // get customer's account details through their account no
    var getCustomerAccountDetailsResponse =
        await getCustomerAccountDetailsThroughAccountNo(
            _setUpProfileFormState.value.accountNo);
    if (getCustomerAccountDetailsResponse.data == null) {
      return getCustomerAccountDetailsResponse;
    }

    // get customer's detail through the customer no gotten from getCustomerAccountDetailsResponse
    var getCustomerResponse = await getCustomerDetailsThroughtCustomerNo(
        getCustomerAccountDetailsResponse.data?.customerNo ?? "");
    if (getCustomerResponse.data == null) {
      return getCustomerResponse;
    }

    // set customer customer information from getcustomerResponse and getCustomerAccountDetailsResponse to the local _setUpProfileFormState property
    var customerData = getCustomerResponse.data!;
    _setUpProfileFormState.update((val) {
      val?.email = customerData.email ?? "";
      val?.firstName = customerData.firstName ?? "";
      val?.lastName = customerData.lastName ?? "";
      val?.phoneRef = customerData.phoneRef ?? "";
      val?.customerNo =
          getCustomerAccountDetailsResponse.data?.customerNo ?? "";
    });

    // refresh state
    _setUpProfileFormState.refresh();

    // get admin token from keycloak
    var adminTokenResponse = await getAdminToken();
    if (adminTokenResponse.data == null) return adminTokenResponse;

    // verify if email doesn't exist before progressing
    var doesEmailExistResponse =
        await doesEmailExists(customerData.email!, adminTokenResponse.data!);

    // if an error occurs
    if (doesEmailExistResponse.data == null) return doesEmailExistResponse;

    // if there is an account similar email
    if (doesEmailExistResponse.data == true) {
      return ResponseM(
          customErrorMessage: "Account already has an online profile");
    }

    // verify if login id doesn't exist before progressing
    var doesLoginIDExistResponse = await doesLoginIDExists(
        _setUpProfileFormState.value.loginId, adminTokenResponse.data!);

    // if an error occurs
    if (doesLoginIDExistResponse.data == null) return doesLoginIDExistResponse;

    // if there is an account with a similar login id
    if (doesLoginIDExistResponse.data == true) {
      return ResponseM(customErrorMessage: "Login ID already in use!");
    }

    var generateOtpResponse = await generateOtp(customerData.email ?? "");
    if (generateOtpResponse.data == null) {
      return generateOtpResponse;
    }
    var otp = generateOtpResponse.data!;
    String otpMessage =
        "Good day,\n\n This is your One-time password for your online profile creation with Island Mfb \n\n Pin: $otp";
    var sendOtpResponse = await sendOtpToEmailAndPhoneNumber(
        customerData.email ?? "",
        customerData.phoneRef ?? "",
        "Online Profile Creation",
        otpMessage,
        otpMessage);
    return sendOtpResponse;
  }

  Future<ResponseM> verifyOtpAndCreateAccount(String inputedOtp) async {
    var getOtpResponse = await getOtp(_setUpProfileFormState.value.email);

    if (getOtpResponse.data == null) {
      return getOtpResponse;
    }

    if (inputedOtp != getOtpResponse.data) {
      return ResponseM(customErrorMessage: "Incorrect Otp!");
    }

    var getAdminTokenResponse = await getAdminToken();

    if (getAdminTokenResponse.data == null) {
      return getAdminTokenResponse;
    }

    var signUpFormInfo = _setUpProfileFormState.value;

    var createAccountResponse = await registerUserKeycloak(
        signUpFormInfo.firstName,
        signUpFormInfo.lastName,
        signUpFormInfo.email,
        signUpFormInfo.loginId,
        signUpFormInfo.password,
        getAdminTokenResponse.data ?? "",
        signUpFormInfo.customerNo);

    return createAccountResponse;
  }
}

// for creating a user's account and the online profile
// can only make it create a user's account
class CreateAccountFormController extends GetxController {
  final _createAccountForm = CreateAccountForm().obs;

  void _setBvnPhoneNumberAndEmail(String bvn, String phoneNumber, String email,
      String loginId, String password) {
    _createAccountForm.update((val) {
      val?.bvn = bvn;
      val?.phoneNumber = phoneNumber;
      val?.email = email;
      val?.loginId = loginId;
      val?.password = password;
    });
  }

  String getEmail() {
    return _createAccountForm.value.email;
  }

  Future<ResponseM> setInitialInfoAndSendOtp(String bvn, String phoneNumber,
      String email, String loginId, String password) async {
    // get admin token from keycloak
    // var adminTokenResponse = await getAdminToken();
    // if (adminTokenResponse.data == null) return adminTokenResponse;

    // verify if login id doesn't exist before progressing
    // var doesLoginIDExistResponse =
    //     await doesLoginIDExists(loginId, adminTokenResponse.data!);

    // if an error occurs
    // if (doesLoginIDExistResponse.data == null) return doesLoginIDExistResponse;

    // if there is an account with a similar login id
    // if (doesLoginIDExistResponse.data == true) {
    //   return ResponseM(customErrorMessage: "Login ID already in use!");
    // }

    _setBvnPhoneNumberAndEmail(bvn, phoneNumber, email, loginId, password);

    var generateBvnResponse = await generateOtp(_createAccountForm.value.bvn);
    if (generateBvnResponse.data == null) {
      return generateBvnResponse;
    }

    String otp = generateBvnResponse.data!;
    String otpMessage =
        "Good day, \n \n Please use this One-Time Password to continue your account creation: \n\n $otp";

    var sendOtpResponse = await sendOtpToEmailAndPhoneNumber(
        _createAccountForm.value.email,
        _createAccountForm.value.phoneNumber,
        "Account Creation",
        otpMessage,
        otpMessage);

    return sendOtpResponse;
  }

  Future<ResponseM> verifyPin(String inputedOtp) async {
    var getOtpResponse = await getOtp(_createAccountForm.value.bvn);

    if (getOtpResponse.data == null) {
      return getOtpResponse;
    }

    if (inputedOtp != getOtpResponse.data) {
      return ResponseM(customErrorMessage: "Incorrect Otp!");
    }

    return ResponseM(data: true);
  }

  // sets all the information gotten from the Personal Information Page
  void setPersonalInfo(String firstName, String lastName, String middleName,
      String gender, DateTime dateofBirth) {
    _createAccountForm.update((val) {
      val?.firstName = firstName;
      val?.lastName = lastName;
      val?.middleName = middleName;
      val?.gender = gender;
      val?.dateOfBirth = dateofBirth.toIso8601String();
    });
  }

  Future<ResponseM<List<AccountTypesResponse>>> getAccounttypesProduct() async {
    return await getAccountTypesProduct();
  }

  // set account type from the AccountTypePage
  setAccountType(AccountTypesResponse selectedAccountType) {
    _createAccountForm.update((val) {
      val?.accountType = selectedAccountType;
    });
  }

  Future<ResponseM> createBasicAccount() async {
    var createBasicAccountResponse = await createBasicUserAccount(
        bvn: _createAccountForm.value.bvn,
        dateOfBirth: _createAccountForm.value.dateOfBirth,
        emailAddress: _createAccountForm.value.email,
        firstName: _createAccountForm.value.firstName,
        gender: _createAccountForm.value.gender,
        lastName: _createAccountForm.value.lastName,
        phoneNumber: _createAccountForm.value.phoneNumber,
        middleName: _createAccountForm.value.middleName);

    if (createBasicAccountResponse.data == null) {
      return createBasicAccountResponse;
    }

    if (createBasicAccountResponse.data!.accountNos.length > 1) {
      var message =
          "Thank you for creating an account with Island Microfinance bank. This is your account number: ${createBasicAccountResponse.data!.accountNos[0].number} \n\n You can use this account number to create an Online profile with us on our mobile application.";
      var sendOtpResponse = await sendOtpToEmailAndPhoneNumber(
          _createAccountForm.value.email,
          _createAccountForm.value.phoneNumber,
          "First Time Account Creation",
          message,
          message);

      return ResponseM(
          data: "Account Creation Successful!",
          customErrorMessage: sendOtpResponse.customErrorMessage);
    } else {
      return ResponseM(data: "Account Created! Please proceed to login");
    }

    // var adminTokenResponse2 = await getAdminToken();
    // if (adminTokenResponse2.data == null) return adminTokenResponse2;

    // // verify if email doesn't exist before progressing
    // var doesEmailExistResponse = await doesEmailExists(
    //     _createAccountForm.value.email, adminTokenResponse2.data!);

    // // if an error occurs
    // if (doesEmailExistResponse.data == null) return doesEmailExistResponse;

    // // if there is an account similar email
    // if (doesEmailExistResponse.data == true) {
    //   return ResponseM(data: "Account Created!!!");
    // }

    // // get admin token from keycloak
    // var adminTokenResponse3 = await getAdminToken();
    // if (adminTokenResponse3.data == null) return adminTokenResponse3;

    // // create keycloak account if no email exists
    // var createKeycloakAccount = await registerUserKeycloak(
    //     _createAccountForm.value.firstName,
    //     _createAccountForm.value.lastName,
    //     _createAccountForm.value.email,
    //     _createAccountForm.value.loginId,
    //     _createAccountForm.value.password,
    //     adminTokenResponse2.data!,
    //     createBasicAccountResponse.data!.customerNo!,
    //     successMessage:
    //         "Online Profile and Account created!!! You may please login");

    // return createKeycloakAccount;
  }

  void clearCreateAccountFormInfo() {
    _createAccountForm.update((val) {
      val?.bvn = "";
      val?.email = "";
      val?.phoneNumber = "";
    });
  }
}
