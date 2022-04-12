import 'package:crypto/crypto.dart';
import 'dart:convert';

String sha512hasher(String token, String email, String username) {
  List<int> byte = utf8.encode(token + email + username);
  Digest sha512Result = sha512.convert(byte);

  return sha512Result.toString();
}

void main() {}
