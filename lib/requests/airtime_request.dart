import 'package:crypto/crypto.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

const devAirtimeUsername = "Anjolaoluwaakindipe";
const devAirtimeCountry = "NG";
const devtoken = "vjBwgBcDn5jUWFMz4AeEtVM5fHH3P";

String sha512hasher(String token, String email, String username) {
  List<int> byte = utf8.encode(token + email + username);
  Digest sha512Result = sha512.convert(byte);

  return sha512Result.toString();
}

Future<Map> makeAirtimePurchase(String phoneNumber, String id) {
  String hash =
      sha512hasher(devtoken, "anjyakindipe@gmail.com", "Anjolaoluwaakindipe");
  Map<String, dynamic> body = {
    "username": devAirtimeUsername,
    "hash": hash,
    "request": [
      {
        "product": id,
        "phone": phoneNumber,
        "amount": 50,
        "country": devAirtimeCountry
      },
    ]
  };
  String urlString = "https://estoresms.com/network_processing/v/2";

  return http
      .post(
    Uri.parse(urlString),
    body: json.encode(body),
  )
      .then((value) {
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

Future<Map> getProductList(String phoneNumber) {
  String hash =
      sha512hasher(devtoken, "anjyakindipe@gmail.com", "Anjolaoluwaakindipe");
  Map<String, String> body = {
    "username": devAirtimeUsername,
    "hash": hash,
    "phone": phoneNumber,
    "country": devAirtimeCountry,
  };

  String urlString = "https://estoresms.com/network_list/v/2";

  return http
      .post(
    Uri.parse(urlString),
    body: json.encode(body),
  )
      .then((value) {
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
  print(await makeAirtimePurchase("+2347030444529", "MFIN-5-OR"));
}
