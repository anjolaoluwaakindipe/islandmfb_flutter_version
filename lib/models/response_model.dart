// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:get/get_connect/http/src/status/http_status.dart';

class ResponseM<T> {
  final HttpStatus? status;
  final T? data;
  String? customErrorMessage;

  ResponseM({this.status, this.data, this.customErrorMessage});

  ResponseM<T> copyWith({
    HttpStatus? status,
    T? data,
    String? customErrorMessage,
  }) {
    return ResponseM<T>(
      status: status ?? this.status,
      data: data ?? this.data,
      customErrorMessage: customErrorMessage ?? this.customErrorMessage,
    );
  }

  @override
  String toString() => 'ResponseM(status: $status, data: $data, customErrorMessage: $customErrorMessage)';
}
