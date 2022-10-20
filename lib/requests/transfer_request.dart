import 'dart:convert';

import 'package:dart_ipify/dart_ipify.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:http/http.dart' as http;
import 'package:islandmfb_flutter_version/models/bank_info_model.dart';
import 'package:islandmfb_flutter_version/models/response_model.dart';
import 'package:islandmfb_flutter_version/requests/request_settings.dart';
import 'package:short_uuids/short_uuids.dart';

Future<Map> ownAccountTransfer(
    double amount,
    String fromAccountNo,
    String narrative,
    String toAccountNo,
    String fullName,
    String customerNo,
    String reference) async {
  String urlString = isslapi + "/ownaccounttransfer";
  String ipAddress = await Ipify.ipv4();
  Map<String, dynamic> body = {
    "amount": amount,
    "fromAccountNo": fromAccountNo,
    "narrative": narrative,
    "reference": reference,
    "toAccountNo": toAccountNo,
    "user": {
      "fullName": fullName,
      "ipAddress": ipAddress,
      "screenName": customerNo
    },
    "valueDate": DateTime.now().toUtc().toIso8601String().toString()
  };

  return http.post(Uri.parse(urlString), body: jsonEncode(body), headers: {
    "Content-Type": "application/json",
    "X-TENANTID": "islandbankpoc"
  }).then(
    (value) {
      if (value.statusCode == 200 || value.statusCode == 201) {
        return {
          "success": true,
          "message": "Transfer Successful",
          "data": json.decode(value.body)
        };
      } else {
        return {
          "success": false,
          "message": "An error occured during transfer"
        };
      }
    },
  );
}

Future<Map> intraBankTransfer(
    double amount,
    String fromAccountNo,
    String narrative,
    String toAccountNo,
    String fullName,
    String customerNo,
    String reference) async {
  String urlString = isslapi + "/intrabanktransfer";
  String ipAddress = await Ipify.ipv4();

  Map<String, dynamic> body = {
    "amount": amount,
    "fromAccountNo": fromAccountNo,
    "narrative": narrative,
    "reference": reference,
    "toAccountNo": toAccountNo,
    "user": {
      "fullName": fullName,
      "ipAddress": ipAddress,
      "screenName": customerNo
    },
    "valueDate": DateTime.now().toUtc().toIso8601String().toString()
  };

  return http.post(Uri.parse(urlString), body: jsonEncode(body), headers: {
    "Content-Type": "application/json",
    "X-TENANTID": "islandbankpoc"
  }).then(
    (value) {
      if (value.statusCode == 200 || value.statusCode == 201) {
        return {
          "success": true,
          "message": "Transfer Successful",
          "data": json.decode(value.body)
        };
      } else {
        return {
          "success": false,
          "message": "An error occured during transfer"
        };
      }
    },
  );
}

Future<Map> getIslandAccountRecipientInfo(String accountNo) async {
  String urlString =
      isslapi + "/getCustomerAccount2" + "?accountno=" + accountNo;
  return http.get(Uri.parse(urlString), headers: {
    "Content-Type": "application/json",
    "X-TENANTID": xtenantid
  }).then((value) {
    if (value.statusCode == 200) {
      return {"success": true, "data": json.decode(value.body)};
    } else {
      return {"success": false, "data": "Invalid account number"};
    }
  }).catchError((_) {
    return {"success": false, "data": "Invalid account number"};
  });
}

// SEND MONEY TO ANOTHER BANK USER
Future<ResponseM> interBankTransfer({
  required double amount,
  required String bankCode,
  required String narrative,
  required String fullName,
  required String fromAccountNo,
  required String toAccountNo,
  required String customerNo,
}) async {
  String urlString = isslapi + "/interbanktransfer";
  String ipAddress = await Ipify.ipv4();

  // CHECKING FOR LOCATION
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Please enable your location service');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location must be permit before you can transfer');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  Position location = await Geolocator.getCurrentPosition();

  // BODY OF JSON REQUEST
  Map<String, dynamic> body = {
    "amount": amount,
    "bankCode": bankCode,
    "bfyNarrative": narrative,
    "channel": "mobileApp",
    "fromAccountKycLevel": "1",
    "fromAccountName": fullName,
    "fromAccountNo": fromAccountNo,
    "location": location.toString(),
    "narrative": narrative,
    "reference": ShortUuid.init().generate().substring(0, 15),
    "toAccountNo": toAccountNo,
    "user": {
      "fullName": fullName,
      "ipAddress": ipAddress,
      "screenName": customerNo
    },
    "valueDate": DateTime.now().toUtc().toIso8601String().toString()
  };

  print(body);

  // send info to api
  var reponse = await http.post(Uri.parse(urlString),
      headers: {"Content-Type": "application/json", "X-TENANTID": xtenantid},
      body: json.encode(body));

  // get reponse form api
  return ResponseM(status: HttpStatus(reponse.statusCode), data: null);
}

Future<ResponseM<List<BankInfo>>> getAllBanks() async {
  const url = isslapi + "/getallbanks";

  // get all the bank information
  var response = await http.get(Uri.parse(url),
      headers: {"Content-Type": "application/json", "X-TENANTID": xtenantid});

  // convert json to bankInfo object
  return ResponseM(
      status: HttpStatus(response.statusCode),
      data: (json.decode(response.body) as List<dynamic>)
          .map((e) => BankInfo.fromJson(e))
          .toList());
}

Future<ResponseM<String?>> getOtherBankRecipientAccountName(
    {required String bankCode, required String accountNumber}) async {
  var url = isslapi +
      "/accountnamelookup?" +
      "bankcode=" +
      bankCode +
      "&nuban=" +
      accountNumber;

  // get all the bank information
  var response = await http.get(Uri.parse(url),
      headers: {"Content-Type": "application/json", "X-TENANTID": xtenantid});

  // convert json to bankInfo object
  return ResponseM(
      status: HttpStatus(response.statusCode),
      data: (json.decode(response.body)["account_name"] as String?));
}

void main() async {
  // print(DateTime.now().toUtc().toIso8601String().toString());
  // print();
  // print(ShortUuid.init().generate().substring(0, 13));

  // print(await ownAccountTransfer(
  //     1.00,
  //     2067581.toString(),
  //     "Credit",
  //     "6767581",
  //     "Ayodele Olafoluso Bolaji Oliyide",
  //     "0002",
  //     ShortUuid.init().generate().substring(0, 15)));

  // print(await recipientInfo("6767581"));

  // print(await interBankTransfer(
  //     amount: 2000,
  //     bankCode: "hello",
  //     customerNo: "6758",
  //     fromAccountNo: "0100000174",
  //     fullName: "Anjola Akindipe",
  //     narrative: "msdf",
  //     toAccountNo: "0713145366"));

  // print(await getAllBanks());
}
