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

  return http.post(Uri.parse(urlString), body: json.encode(body),).then((value) {
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
  print(await getProductList("+22347030444529"));
}
