// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class AccountNo {
  String? number;
  String? type;

  AccountNo({
    this.number,
    this.type,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'number': number,
      'type': type,
    };
  }

  factory AccountNo.fromMap(Map<String, dynamic> map) {
    return AccountNo(
      number: map['_number'] != null ? map['_number'] as String : null,
      type: map['_type'] != null ? map['_type'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AccountNo.fromJson(String source) =>
      AccountNo.fromMap(json.decode(source) as Map<String, dynamic>);
}

class CreateBasicAccountResponse {
  String? customerNo;
  List<AccountNo> accountNos;

  CreateBasicAccountResponse({
    this.customerNo,
    this.accountNos = const [],
  });

  

  CreateBasicAccountResponse copyWith({
    String? customerNo,
    List<AccountNo>? accountNos,
  }) {
    return CreateBasicAccountResponse(
      customerNo: customerNo ?? this.customerNo,
      accountNos: accountNos ?? this.accountNos,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'customerNo': customerNo,
      'accountNos': accountNos.map((x) => x.toMap()).toList(),
    };
  }

  factory CreateBasicAccountResponse.fromMap(Map<String, dynamic> map) {
    return CreateBasicAccountResponse(
      customerNo: map['customerNo'] != null ? map['customerNo'] as String : null,
      accountNos: List<AccountNo>.from((map['accountNos'] as List<int>).map<AccountNo>((x) => AccountNo.fromMap(x as Map<String,dynamic>),),),
    );
  }

  String toJson() => json.encode(toMap());

  factory CreateBasicAccountResponse.fromJson(String source) => CreateBasicAccountResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'CreateBasicAccountResponse(customerNo: $customerNo, accountNos: $accountNos)';

  @override
  bool operator ==(covariant CreateBasicAccountResponse other) {
    if (identical(this, other)) return true;
  
    return 
      other.customerNo == customerNo &&
      listEquals(other.accountNos, accountNos);
  }

  @override
  int get hashCode => customerNo.hashCode ^ accountNos.hashCode;
}
