import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:islandmfb_flutter_version/models/account.dart';
import 'package:islandmfb_flutter_version/requests/request_settings.dart';

import 'package:http/http.dart' as http;

Future<Map> getCustomerAccounts(String customerNo) async {
  String urlString = isslapi + "/getCustomerAccounts?CustomerNo=" + customerNo;
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
        return {
          "success": false,
          "error":
              "An error occured while getting your account information, please try again later"
        };
      }
    },
  );
}

Future<Map> getCustomerDetails(String customerNo) async {
  String urlString = isslapi + "/getCustomerDetails?CustomerNo=" + customerNo;

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
  String urlString = isslapi + "/getAccountRecentTxns?AccountNo=" + accountNo;

  return await http.get(Uri.parse(urlString)).then((value) {
    if (value.statusCode == 200) {
      return {"success": true, "data": json.decode(value.body)};
    } else {
      return {"success": false, "statusCode": value.statusCode};
    }
  });
}

Future<Map> getCustomerTransactionsSpecifically(
    String endDate, String accountNo,
    {int page = 0, int size = 0, String startDate = "19500101"}) async {
  String urlStrinng = isslapi +
      "/getAccountTransactionsPaged?accountno=" +
      accountNo +
      "&fromdate=" +
      startDate +
      "&todate=" +
      endDate +
      "&page=" +
      (page != 0 ? page.toString() : "") +
      "&size=" +
      (size != 0 ? size.toString() : "");
  return await http.get(Uri.parse(urlStrinng)).then((value) {
    if (value.statusCode == 200) {
      return {"success": true, "data": json.decode(value.body)};
    } else {
      return {"success": false, "statusCode": value.statusCode};
    }
  });
}

void main() async {
  // print(await getCustomerAccounts("0002"));
  // print(await getCustomerRecentTransactions(1000021.toString()));

  var ans = await getCustomerTransactionsSpecifically(
          20200923.toString(), 1000021.toString(),
          page: 1, size: 1)
      .then((value) => value["data"]["content"]);
  print(ans.length);

  // print(DateFormat("yyyyMMdd").format(DateTime.now()));
}
