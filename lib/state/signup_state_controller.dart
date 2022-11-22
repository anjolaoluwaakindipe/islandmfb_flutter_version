import 'package:get/get.dart';
import 'package:islandmfb_flutter_version/models/create_account_form.dart';
import 'package:islandmfb_flutter_version/models/requests/getcustomeraccount_response.dart';
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

  Future<ResponseM> sendOtp() async {
    if (_setUpProfileFormState.value.accountNo == "") {
      return ResponseM(customErrorMessage: "Please provide an account number");
    }
    if (_setUpProfileFormState.value.password.isEmpty) {
      return ResponseM(customErrorMessage: "Please provide a password");
    }

    var getCustomerAccountDetailsResponse =
        await getCustomerAccountDetailsThroughAccountNo(
            _setUpProfileFormState.value.accountNo);
    if (getCustomerAccountDetailsResponse.data == null) {
      return getCustomerAccountDetailsResponse;
    }

    var getCustomerResponse = await getCustomerDetailsThroughtCustomerNo(
        getCustomerAccountDetailsResponse.data?.customerNo ?? "");
    if (getCustomerResponse.data == null) {
      return getCustomerResponse;
    }

    var customerData = getCustomerResponse.data!;
    _setUpProfileFormState.update((val) {
      val?.email = customerData.email ?? "";
      val?.firstName = customerData.firstName ?? "";
      val?.lastName = customerData.lastName ?? "";
      val?.phoneRef = customerData.phoneRef ?? "";
      val?.customerNo =
          getCustomerAccountDetailsResponse.data?.customerNo ?? "";
    });

    _setUpProfileFormState.refresh();

    var adminTokenResponse = await getAdminToken();

    if (adminTokenResponse.data == null) return adminTokenResponse;

    var doesEmailExistResponse =
        await doesEmailExists(customerData.email!, adminTokenResponse.data!);

    if (doesEmailExistResponse.data == null) return doesEmailExistResponse;

    if (doesEmailExistResponse.data == true) {
      return ResponseM(
          customErrorMessage: "Account already has an online profile");
    }

    var doesLoginIDExistResponse = await doesLoginIDExists(
        _setUpProfileFormState.value.loginId, adminTokenResponse.data!);

    if (doesLoginIDExistResponse.data == null) return doesLoginIDExistResponse;

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

    var createAccountResponse = await registerUser(
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

class CreateAccountFormController extends GetxController {
  final _createAccountForm = CreateAccountForm().obs;

  void _setBvnPhoneNumberAndEmail(
      String bvn, String phoneNumber, String email) {
    _createAccountForm.update((val) {
      val?.bvn = bvn;
      val?.phoneNumber = phoneNumber;
      val?.email = email;
    });
  }

  Future<ResponseM> setInitialInfoAndSendOtp(
      String bvn, String phoneNumber, String email) async {
    _setBvnPhoneNumberAndEmail(bvn, phoneNumber, email);

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

    print(sendOtpResponse.toString());

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

  void setPersonalInfo(
      String firstName, String lastName, String gender, DateTime dateofBirth) {
    _createAccountForm.update((val) {
      val?.firstName = firstName;
      val?.lastName = lastName;
      val?.gender = gender;
      val?.dateOfBirth = dateofBirth.toIso8601String();
    });
  }

  void clearCreateAccountFormInfo() {
    _createAccountForm.update((val) {
      val?.bvn = "";
      val?.email = "";
      val?.phoneNumber = "";
    });
  }
}
