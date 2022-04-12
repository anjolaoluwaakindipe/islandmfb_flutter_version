import 'dart:convert';

class Account {
  final dynamic primaryAccountNo;
  final dynamic accountNos;
  final String? customerNo;
  final String? customerName;
  final String? accountName;
  final String? productCode;
  final String? product;
  final String? ledgerCode;
  final String? ledger;
  final String? ccy;
  final String? ccyCode;
  final String? ccyName;
  final String? lastMovementDate;
  final double? availableBalance;
  final double? clearedBalance;
  final double? bookBalance;

  const Account(
      {this.primaryAccountNo = const {},
      this.accountNos = const [],
      this.customerNo,
      this.customerName,
      this.accountName,
      this.productCode,
      this.product,
      this.ledgerCode,
      this.ledger,
      this.ccy,
      this.ccyCode,
      this.ccyName,
      this.lastMovementDate,
      this.availableBalance,
      this.clearedBalance,
      this.bookBalance});

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
        accountName: json["accountName"],
        accountNos: json["accountNos"],
        availableBalance: json["availableBalance"],
        bookBalance: json["bookBalance"],
        ccy: json["ccy"],
        ccyCode: json["ccyCode"],
        ccyName: json["ccyName"],
        clearedBalance: json["clearedBalance"],
        customerName: json["customerName"],
        customerNo: json["customerNo"],
        lastMovementDate: json["lastMovementDate"],
        ledger: json["ledger"],
        ledgerCode: json["ledgerCode"],
        primaryAccountNo: json["primaryAccountNo"],
        product: json["product"],
        productCode: json["productCode"]);
  }
}
