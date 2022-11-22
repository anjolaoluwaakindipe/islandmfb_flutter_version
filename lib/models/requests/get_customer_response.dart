// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class GetCustomerResponseBody {
  String? email;
  String? firstName;
  String? lastName;
  String? phoneRef;
  GetCustomerResponseBody({
    this.email,
    this.firstName,
    this.lastName,
    this.phoneRef,
  });

  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'phoneRef': phoneRef,
    };
  }

  factory GetCustomerResponseBody.fromMap(Map<String, dynamic> map) {
    return GetCustomerResponseBody(
      email: map['email'] != null ? map['email'] as String : null,
      firstName: map['firstName'] != null ? map['firstName'] as String : null,
      lastName: map['lastName'] != null ? map['lastName'] as String : null,
      phoneRef: map['phoneRef'] != null ? map['phoneRef'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory GetCustomerResponseBody.fromJson(String source) => GetCustomerResponseBody.fromMap(json.decode(source) as Map<String, dynamic>);
}
