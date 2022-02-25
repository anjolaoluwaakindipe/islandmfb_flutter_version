import 'dart:convert';

import 'package:islandmfb_flutter_version/requests/request_settings.dart';

import 'package:http/http.dart' as http;

Future<Map> getAccountInfo(String customerNo) async {
  String urlString =
      accountUrl + "/getCustomerAccounts?CustomerNo=" + customerNo;
  return await http.get(
    Uri.parse(urlString),
    headers: {
      "Access-Control-Allow-Headers": "Access-Control-Allow-Origin, Accept",
      "Access-Control-Allow-Origin": "*",
    },
  ).then(
    (value) {
      print(json.decode(value.body));
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

void main() async {
  print(await getAccountInfo("0002"));
}
