// helper functions
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:islandmfb_flutter_version/models/response_model.dart';
import 'package:islandmfb_flutter_version/pages/login_page.dart';
import 'package:islandmfb_flutter_version/requests/request_settings.dart';
import 'package:http/http.dart' as http;
import 'package:islandmfb_flutter_version/state/token_state_controller.dart';
import 'package:islandmfb_flutter_version/storage/secure_storage.dart';

String xformurlencoder(Map<dynamic, dynamic> bodyFields) {
  String encodedStr = "";

  for (String field in bodyFields.keys) {
    if (encodedStr.isNotEmpty) {
      encodedStr += "&";
    }
    encodedStr += ("$field=" + bodyFields[field]);
  }

  return encodedStr;
}

// requests
Future<ResponseM<Map<String, dynamic>>> loginUserWithUsernameAndPassword(
    String username, String password) async {
  Map loginInfo = {
    "username": username,
    "password": password,
    "grant_type": passwordGrantType,
    "client_id": customClientId
  };

  String body = xformurlencoder(loginInfo);

  String uri =
      "$keycloakBaseUrl/auth/realms/$customRealm/protocol/openid-connect/token";

  try {
    return await http
        .post(Uri.parse(uri),
            headers: {"Content-Type": "application/x-www-form-urlencoded"},
            body: body)
        .then(
      (value) {
        // if (value.statusCode == 200 || value.statusCode == 201) {
        //   return {
        //     "success": true,
        //     "data": json.decode(value.body),
        //   };
        // } else if (value.statusCode == 401) {
        //   return {
        //     "success": true,
        //     "data": json.decode(value.body),
        //   };
        // } else if (value.statusCode == 408) {
        //   return {
        //     "success": false,
        //     "message": "Process Timeout, please try again later"
        //   };
        // }
        return ResponseM(
            status: HttpStatus(value.statusCode),
            data: json.decode(value.body) as Map<String, dynamic>);
      },
    ).timeout(
      const Duration(seconds: 60),
    );
  } on SocketException catch (_) {
    return ResponseM(
        customErrorMessage: "Not connected to internet please try again later");
    // return {
    //   "success": false,
    //   "message": "Not connected to internet please try again later"
    // };
  } on TimeoutException catch (_) {
    return ResponseM(
        customErrorMessage: "Process Timeout, please try again later");

    // return {
    //   "success": false,
    //   "message": "Process Timeout, please try again later"
    // };
  } on Error catch (_) {
    return ResponseM(
        customErrorMessage:
            'An unexpected error occured, please try again later');
  }
}

Future reLoginWithRefreshToken() async {
  String? refreshToken = await SecureStorage.readAValue("refresh_token");
  if (refreshToken != null) {
    Map loginInfo = {
      "refresh_token": refreshToken,
      "grant_type": refreshTokenGrantType,
      "client_id": customClientId
    };

    String body = xformurlencoder(loginInfo);

    String uri =
        "$keycloakBaseUrl/auth/realms/$customRealm/protocol/openid-connect/token";

    return await http
        .post(
      Uri.parse(uri),
      headers: {"Content-Type": "application/x-www-form-urlencoded"},
      body: body,
    )
        .then((value) async {
      if (value.statusCode == 200) {
        Map tokenInformation = json.decode(value.body);
        Get.put(AuthStateController()).tokenState.value =
            tokenInformation as Map<String, dynamic>;
        await SecureStorage.writeAValue(
            "refresh_token", tokenInformation["refresh_token"]);
        await SecureStorage.writeAValue(
            "access_token", tokenInformation["access_token"]);
        await getUserInfoKeycloak(tokenInformation["access_token"]);
      } else {
        SecureStorage.deleteAValue("refresh_token");
        SecureStorage.deleteAValue("access_token");
        Get.to(const LoginPage());
      }
    });
  } else {
    Get.to(const LoginPage());
  }
}

Future getUserInfoKeycloak(String token) async {
  String? refreshToken = await SecureStorage.readAValue("refresh_token");

  String uriString =
      "$keycloakBaseUrl/auth/realms/$customRealm/protocol/openid-connect/userinfo";

  return await http.get(Uri.parse(uriString), headers: {
    "Authorization": "Bearer $token",
    "Accept": "application/json"
  }).then(
    (value) {
      if (value.statusCode == 200) {
        return json.decode(value.body);
      } else if (value.statusCode == 401 && refreshToken != null) {
        reLoginWithRefreshToken();
        return;
      } else {
        Get.to(const LoginPage());
      }
    },
  );
}

Future<ResponseM<String>> getAdminToken() async {
  try {
    const adminTokenInfo = {
      "client_secret": clientSecret,
      "grant_type": clientCredientialGrantType,
      "client_id": adminClientId,
    };

    String body = xformurlencoder(adminTokenInfo);
    String urlString =
        "$keycloakBaseUrl/auth/realms/$customRealm/protocol/openid-connect/token";

    var getAdminTokenresponse = await http.post(Uri.parse(urlString),
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
        body: body);

    if (getAdminTokenresponse.statusCode == HttpStatus.internalServerError) {
      return ResponseM(
          customErrorMessage:
              "Our servers are currently down. Please try again later.");
    } else if (getAdminTokenresponse.statusCode != HttpStatus.ok) {
      return ResponseM(
          customErrorMessage:
              "An error occured while creating your online profile. Please try again later");
    }
    Map<String, dynamic> adminBody =
        json.decode(getAdminTokenresponse.body) as Map<String, dynamic>;

    return ResponseM(data: adminBody["access_token"] as String);
  } on SocketException {
    return ResponseM(
        customErrorMessage:
            "Could not connect to server. Please check your internet connection");
  } catch (e) {
    return ResponseM(
        customErrorMessage: "An error occured. Please Try again later");
  }
}

// registers user to keycloak
Future<ResponseM<String>> registerUserKeycloak(
    String firstName,
    String lastName,
    String email,
    String username,
    String password,
    String adminToken,
    String customerNo, {String? successMessage}) async {
  try {
    Map<String, dynamic> body = {
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "username": username,
      "enabled": true,
      "emailVerified": true,
      "attributes": {"customer_no": customerNo},
      "credentials": [
        {"value": password, "type": "password", "temporary": false}
      ]
    };

    String uriString = "$keycloakBaseUrl/auth/admin/realms/$customRealm/users";

    var registerResponse = await http.post(Uri.parse(uriString),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $adminToken"
        },
        body: json.encode(body));

    if (registerResponse.statusCode == HttpStatus.internalServerError) {
      return ResponseM(
          customErrorMessage:
              "Our servers are currently down. Please try again later.");
    } else if (registerResponse.statusCode == HttpStatus.conflict) {
      return ResponseM(customErrorMessage: "Sorry user already exists with login id or email");
    } else if (registerResponse.statusCode != HttpStatus.created) {
      return ResponseM(
          customErrorMessage:
              "An error occured while registering your online profile. Please try again later.");
    }

    return ResponseM(data: successMessage ?? "Online Profile Created!!!");
  } on SocketException {
    return ResponseM(
        customErrorMessage:
            "Could not connect to server. Please check your internet connection");
  } catch (e) {
    return ResponseM(
        customErrorMessage:
            "An unexpected error occured while registering your online profile. Please try again later.");
  }
}

// check if email exists
Future<ResponseM<bool>> doesLoginIDExists(
    String loginID, String adminToken) async {
  try {
    var loginIdCheckResponse = await http.get(
        Uri.parse(
            "$keycloakBaseUrl/auth/admin/realms/$customRealm/users?username=$loginID&exact=true"),
        headers: {"Authorization": "Bearer $adminToken"});

    if (loginIdCheckResponse.statusCode == HttpStatus.internalServerError) {
      return ResponseM(
          customErrorMessage:
              "Something is currently wrong with our servers. Please try again later.");
    } else if (loginIdCheckResponse.statusCode == HttpStatus.unauthorized) {
      return ResponseM(
          customErrorMessage: "Request timed out! Please try again later");
    } else if (loginIdCheckResponse.statusCode != HttpStatus.ok) {
      return ResponseM(
          customErrorMessage: "An error occured while processing this request");
    }

    var loginIdCheckBody =
        json.decode(loginIdCheckResponse.body) as List<dynamic>;

    if (loginIdCheckBody.isEmpty) {
      return ResponseM(data: false);
    }
    return ResponseM(data: true);
  } on SocketException {
    return ResponseM(
        customErrorMessage: "Please check your network connection");
  } catch (_) {
    return ResponseM(
        customErrorMessage:
            "An unexpectd error occured while setting up your online profile. Please try again later.");
  }
}

// check if email exists
Future<ResponseM<bool>> doesEmailExists(String email, String adminToken) async {
  try {
    var emailCheckResponse = await http.get(
        Uri.parse(
            "$keycloakBaseUrl/auth/admin/realms/$customRealm/users?email=$email&exact=true"),
        headers: {"Authorization": "Bearer $adminToken"});

    if (emailCheckResponse.statusCode == HttpStatus.internalServerError) {
      return ResponseM(
          customErrorMessage:
              "Something is currently wrong with our servers. Please try again later.");
    } else if (emailCheckResponse.statusCode == HttpStatus.unauthorized) {
      return ResponseM(
          customErrorMessage: "Request timed out! Please try again later");
    } else if (emailCheckResponse.statusCode != HttpStatus.ok) {
      return ResponseM(
          customErrorMessage: "An error occured while processing this request");
    }

    var emailCheckBody = json.decode(emailCheckResponse.body) as List<dynamic>;

    if (emailCheckBody.isEmpty) {
      return ResponseM(data: false);
    }
    return ResponseM(data: true);
  } on SocketException {
    return ResponseM(
        customErrorMessage: "Please check your network connection");
  } catch (_) {
    return ResponseM(
        customErrorMessage:
            "An unexpectd error occured while setting up your online profile. Please try again later.");
  }
}

Future logoutUser(String refreshToken) async {
  Map<String, String> logoutInfo = {
    "client_id": customClientId,
    "refresh_token": refreshToken,
  };

  String body = xformurlencoder(logoutInfo);
  String urlString =
      "$keycloakBaseUrl/auth/realms/$customRealm/protocol/openid-connect/logout";

  return await http
      .post(
    Uri.parse(urlString),
    headers: {"Content-Type": "application/x-www-form-urlencoded"},
    body: body,
  )
      .then(
    (value) {
      if (value.statusCode == 204) {
        return {"sucess": true, "msg": "User Logged Out"};
      } else {
        return {"success": false, "msg": json.decode(value.body)};
      }
    },
  );
}

// void main() async {
//   var tokenInfo = await loginUserWithUsernameAndPassword("aji", "test1234");
//   print(tokenInfo);
//   var user = await getUserInfo(tokenInfo["access_token"]);

//   print(await logoutUser(tokenInfo["refresh_token"]));
//   // var adminToken = await getAdminToken();
//   // print(adminToken);
//   // print(await registerUser("Anjy", "Olamide", "email@gsd.com", "aji",
//   //     "test1234", adminToken["access_token"]));
// }
