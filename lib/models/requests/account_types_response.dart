// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AccountTypesResponse {
  String? productcode;
  String? description;
  AccountTypesResponse({
    this.productcode,
    this.description,
  });

  AccountTypesResponse copyWith({
    String? productcode,
    String? description,
  }) {
    return AccountTypesResponse(
      productcode: productcode ?? this.productcode,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productcode': productcode,
      'description': description,
    };
  }

  factory AccountTypesResponse.fromMap(Map<String, dynamic> map) {
    return AccountTypesResponse(
      productcode: map['productcode'] != null ? map['productcode'] as String : null,
      description: map['description'] != null ? map['description'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AccountTypesResponse.fromJson(String source) =>
      AccountTypesResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'AccountTypesResponse(productcode: $productcode, description: $description)';

  @override
  bool operator ==(covariant AccountTypesResponse other) {
    if (identical(this, other)) return true;

    return other.productcode == productcode && other.description == description;
  }

  @override
  int get hashCode => productcode.hashCode ^ description.hashCode;
}
