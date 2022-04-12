import 'dart:convert';

import 'package:http/http.dart' as http;

const devAirtimeUsername = "Anjolaoluwaakindipe";
const devAirtimeCountry = "Nigeria";

Future<Map> getProductList(String phoneNumber) {
  Map<String, String> body = {
    "username": devAirtimeCountry,
    "hash": "",
    "phone": phoneNumber,
    "country": devAirtimeCountry,
  };

  String urlString = "https://estoresms.com/network_list/v/2";

  return http.post(Uri.parse(urlString), body: body).then((value) {
    if (value.statusCode == 200) {
      return {"success": true, "data": json.decode(value.body)};
    }
    return {"success": false, "data": json.decode(value.body)};
  }).catchError((_) {
    return {
      "success": false,
      "data": "An error occured please try again later"
    };
  });
}

void main() async {
  print(await getProductList("+23470444529"));
}
