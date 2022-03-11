import 'dart:convert';

import 'package:islandmfb_flutter_version/requests/request_settings.dart';

import 'package:http/http.dart' as http;

Future<Map> getCustomerAccounts(String customerNo) async {
  String urlString =
      accountUrl + "/getCustomerAccounts?CustomerNo=" + customerNo;
  return await http
      .get(
    Uri.parse(urlString),
  )
      .then(
    (value) {
      if (value.statusCode == 200) {
        return {
          "success": true,
          "data": json.decode(value.body),
          "msg": "Account Info Generated"
        };
      } else {
        return {"success": false, "msg": "An error occured please try again"};
      }
    },
  );
}

Future<Map> getCustomerDetails(String customerNo) async {
  String urlString =
      accountUrl + "/getCustomerDetails?CustomerNo=" + customerNo;

  return await http.get(Uri.parse(urlString)).then((value) {
    if (value.statusCode == 200) {
      return {
        "success": true,
        "data": json.decode(value.body),
      };
    } else {
      return {
        "success": false,
      };
    }
  });
}

Future<Map> getCustomerRecentTransactions(String accountNo) async {
  String urlString =
      accountUrl + "/getAccountRecentTxns?AccountNo=" + accountNo;

  return await http.get(Uri.parse(urlString)).then((value) {
    if (value.statusCode == 200) {
      return {"success": true, "data": json.decode(value.body)};
    } else {
      return {"success": false, "statusCode": value.statusCode};
    }
  });
}

void main() async {
  print(await getCustomerAccounts("0002"));
  print(await getCustomerRecentTransactions(1000021.toString()));
}
