import 'package:get/get_connect/http/src/status/http_status.dart';

class ResponseM<T> {
  final HttpStatus? status;
  final T? data;
  String? customErrorMessage;

  ResponseM({this.status, this.data, this.customErrorMessage});
}
