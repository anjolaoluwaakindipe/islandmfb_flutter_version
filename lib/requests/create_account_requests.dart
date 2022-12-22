import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:http/http.dart' as http;
import 'package:islandmfb_flutter_version/models/requests/account_types_response.dart';
import 'package:islandmfb_flutter_version/models/requests/create_basic_account_response.dart';
import 'package:islandmfb_flutter_version/models/requests/get_customer_response.dart';
import 'package:islandmfb_flutter_version/models/requests/getcustomeraccount_response.dart';
import 'package:islandmfb_flutter_version/models/requests/sent_sms_reponse.dart';
import 'package:islandmfb_flutter_version/models/response_model.dart';
import 'package:islandmfb_flutter_version/requests/request_settings.dart';

Future<ResponseM<GetCustomerAccountResponseBody>>
    getCustomerAccountDetailsThroughAccountNo(String accountNumber) async {
  try {
    var getCustomerAccountResponse = await http.get(
        Uri.parse("$isslapi/getCustomerAccount?AccountNo=$accountNumber"),
        headers: {"X-TENANTID": xtenantid});

    var errResponse = badStatusCheck<GetCustomerAccountResponseBody>(
        getCustomerAccountResponse);

    if (errResponse != null) return errResponse;

    var getCustomerAccountResponseBody =
        GetCustomerAccountResponseBody.fromJson(
            getCustomerAccountResponse.body);

    if (getCustomerAccountResponseBody.customerNo == null) {
      return ResponseM(
          customErrorMessage:
              "Account nunber not registered. Please create an account");
    }

    return ResponseM(data: getCustomerAccountResponseBody);
  } catch (err) {
    return ResponseM(
        customErrorMessage:
            "An error occured while getting your account details please try again");
  }
}

Future<ResponseM<GetCustomerResponseBody>> getCustomerDetailsThroughtCustomerNo(
    String customerNo) async {
  try {
    var getCustomerResponse = await http.get(
        Uri.parse("$isslapi/getCustomer?customerno=$customerNo"),
        headers: {"X-TENANTID": xtenantid});

    var errResponse =
        badStatusCheck<GetCustomerResponseBody>(getCustomerResponse);
    if (errResponse != null) return errResponse;
    if (getCustomerResponse.body.isEmpty) {
      return ResponseM(customErrorMessage: "Invalid Customer number");
    }

    var getCustomerResponseBody =
        GetCustomerResponseBody.fromJson(getCustomerResponse.body);
    return ResponseM(data: getCustomerResponseBody);
  } catch (_) {
    return ResponseM(
        customErrorMessage:
            "An error occured while getting your account info. Please try again later");
  }
}

Future<ResponseM<String>> generateOtp(String email) async {
  try {
    var generatetOtpResponse =
        await http.get(Uri.parse("$isslapi/generateotp?userId=$email"));

    var errResponse = badStatusCheck<String>(generatetOtpResponse,
        notOkErrMsg: "Could not generate Otp");
    if (errResponse != null) return errResponse;

    return ResponseM(data: generatetOtpResponse.body);
  } catch (_) {
    return ResponseM(
        customErrorMessage:
            "An error occured while generating your otp. Please try again later");
  }
}

Future<ResponseM<bool>> sendOtpToEmailAndPhoneNumber(
    String email,
    String phoneNumber,
    String emailSubject,
    String emailMessage,
    String smsMessage) async {
  Map<String, dynamic> emailBody = {
    "attachments": [{}],
    "body": emailMessage,
    "from": "devops@issl.ng",
    "subject": emailSubject,
    "to": email,
  };

  String phoneNumberCheck =
      phoneNumber.startsWith("+") ? phoneNumber.substring(1) : phoneNumber;

  // http response variables
  http.Response? emailResponse;
  http.Response? smsResponse;

  // result variables
  String errorMessage = "";
  ResponseM<bool> result = ResponseM();
  SentSmsResponse smsBodyResponse = SentSmsResponse(sentOK: false);

  // email response
  try {
    // make the email request
    emailResponse = await http.post(Uri.parse("$isslapi/sendmail"),
        headers: {"X-TENANTID": xtenantid, "Content-Type": "application/json"},
        body: json.encode(emailBody));

    // check if request was okay or not
    var errResponse = badStatusCheck(emailResponse,
        notOkErrMsg: "An error occured while sending otp to your email");

    // if there was an error response assign it to the error message
    if (errResponse != null && errResponse.customErrorMessage != null) {
      errorMessage = errResponse.customErrorMessage!;
    }
  } catch (_) {}

  // sms response
  try {
    // make sms request
    smsResponse = await http.get(
        Uri.parse(
            "$isslapi/sendsms?message=$smsMessage&recipient=$phoneNumberCheck"),
        headers: {"X-TENANTID": xtenantid});

    // check if request is good or bad
    var errResponse = badStatusCheck(smsResponse,
        notOkErrMsg: "An error occured while sending otp as sms");

    // check if an error occured while sending token as sms
    if (errResponse != null && errResponse.customErrorMessage != null) {
      // if error message does not have a 500 error append addition messages to it
      if (!errorMessage.contains("servers")) {
        if (errorMessage.isNotEmpty) {
          errorMessage += " and ";
        }
        errorMessage += errResponse.customErrorMessage!;
      }
    } else {
      smsBodyResponse = SentSmsResponse.fromJson(smsResponse.body);
      if (smsBodyResponse.sentOK == false) {
        if (errorMessage.isNotEmpty) {
          errorMessage += " and ";
        }

        errorMessage += "could not send sms to phone number.";
      }
    }
  } catch (_) {}

  // collect formulated error message into result
  result.customErrorMessage = errorMessage;
  print(smsBodyResponse.toString());
  // check if either smsResponse or emailResponse was okay and assign the result a data value
  if ((smsResponse != null &&
          smsResponse.statusCode == HttpStatus.ok &&
          smsBodyResponse.sentOK == true) ||
      (emailResponse != null && emailResponse.statusCode == HttpStatus.ok)) {
    result = result.copyWith(data: true);
  }

  return result;
}

Future<ResponseM<String>> getOtp(String email) async {
  try {
    var getOtpResponse =
        await http.get(Uri.parse("$isslapi/getotp?userId=$email"));
    var errResponse = badStatusCheck<String>(getOtpResponse,
        notOkErrMsg: "An error occured while processing your request.");

    if (errResponse != null) {
      return errResponse;
    }
    if (getOtpResponse.body == "0") {
      return ResponseM(
          customErrorMessage: "Otp expired! Please resend another otp.");
    }
    return ResponseM(data: getOtpResponse.body);
  } catch (e) {
    return ResponseM(
        customErrorMessage: "Something went wrong while verifying pin");
  }
}

Future<ResponseM<List<AccountTypesResponse>>> getAccountTypesProduct() async {
  try {
    var accountTypeResponse = await http.get(
        Uri.parse("$isslapiDomain/onboarding-api/1.0/getProducts"),
        headers: {
          "X-TENANTID": xtenantid
        }).timeout(const Duration(seconds: 10));

    var errResponse = badStatusCheck<List<AccountTypesResponse>>(
        accountTypeResponse,
        notOkErrMsg:
            "An error occured while getting account products! Please try again later");

    if (errResponse != null) {
      return errResponse;
    }

    List<AccountTypesResponse> accountTypeResponseBody =
        (json.decode(accountTypeResponse.body) as List)
            .map((e) => AccountTypesResponse.fromMap(e))
            .toList();

    return ResponseM(data: accountTypeResponseBody);
  } on SocketException {
    return ResponseM(customErrorMessage: "Please check your connection.");
  } on TimeoutException {
    return ResponseM(customErrorMessage: "Request Timeout.");
  } catch (err) {
    return ResponseM(customErrorMessage: "An Unexpected error occured!");
  }
}

// create basic user account
Future<ResponseM<CreateBasicAccountResponse>> createBasicUserAccount(
    {required String bvn,
    required String dateOfBirth,
    required String emailAddress,
    required String firstName,
    required String gender,
    required String lastName,
    required String phoneNumber,
    required String middleName}) async {
  Map<String, String> queryParams = {
    "BVN": bvn,
    "DateofBirth": dateOfBirth,
    "EMailAddress": emailAddress,
    "FirstName": firstName,
    "Gender": gender,
    "LastName": lastName,
    "MobilePhoneNo": phoneNumber,
    "OtherNames": middleName
  };

  var createBasicUserResponse = await http.get(
      Uri(
          scheme: "http",
          host: isslapiHost,
          path: "/ibank/api/v1/createBasicAccount",
          queryParameters: queryParams),
      headers: {"X-TENANTID": xtenantid});

  var errResponse = badStatusCheck<CreateBasicAccountResponse>(
      createBasicUserResponse,
      notOkErrMsg:
          "An error occured while creating your account. Please try again later!");

  if (errResponse != null) return errResponse;

  var createBasicUserResponseBody = ResponseM(
      data: CreateBasicAccountResponse.fromJson(createBasicUserResponse.body));

  return createBasicUserResponseBody;
}

ResponseM<T>? badStatusCheck<T>(http.Response response,
    {notOkErrMsg =
        "An error occured while getting your account information. Please try again later"}) {
  if (response.statusCode == HttpStatus.internalServerError) {
    return ResponseM(
        customErrorMessage:
            "Something is currently wrong with our servers. Please try again later");
  } else if (response.statusCode != HttpStatus.ok) {
    return ResponseM(customErrorMessage: notOkErrMsg);
  } else {
    return null;
  }
}
