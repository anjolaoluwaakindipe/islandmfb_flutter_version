import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class GetCustomerAccountResponseBody {
  String? customerNo;
  GetCustomerAccountResponseBody({
    this.customerNo,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'customerNo': customerNo,
    };
  }

  factory GetCustomerAccountResponseBody.fromMap(Map<String, dynamic> map) {
    return GetCustomerAccountResponseBody(
      customerNo:
          map['customerNo'] != null ? map['customerNo'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory GetCustomerAccountResponseBody.fromJson(String source) =>
      GetCustomerAccountResponseBody.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
