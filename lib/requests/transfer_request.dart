import 'dart:convert';

import 'package:dart_ipify/dart_ipify.dart';
import 'package:http/http.dart' as http;
import 'package:islandmfb_flutter_version/requests/request_settings.dart';
import 'package:short_uuids/short_uuids.dart';
import 'package:uuid/uuid.dart';

Future<Map> ownAccountTransfer(
    double amount,
    String fromAccountNo,
    String narrative,
    String toAccountNo,
    String fullName,
    String customerNo,
    String reference) async {
  String urlString = accountUrl + "/ownaccounttransfer";
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
      print(json.decode(value.body));
      if (value.statusCode == 200 || value.statusCode == 201) {
        return {"success": true, "message": "Transfer Successful", "data": json.decode(value.body)};
      } else {
        return {
          "success": false,
          "message": "An error occured during transfer"
        };
      }
    },
  );
}

void main() async {
  // print(DateTime.now().toUtc().toIso8601String().toString());
  // print();
  print(ShortUuid.init().generate().substring(0, 13));
  

  print(await ownAccountTransfer(1.00, 2067581.toString(), "Credit", "6767581",
      "Ayodele Olafoluso Bolaji Oliyide", "0002", ShortUuid.init().generate().substring(0, 15)));
}
