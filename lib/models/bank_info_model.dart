class BankInfo {
  final String name;
  final String code;

  BankInfo(this.name, this.code);

  factory BankInfo.fromJson(Map<String, dynamic> json) {
    return BankInfo(json["name"] as String, json["code"] as String);
  }
}
