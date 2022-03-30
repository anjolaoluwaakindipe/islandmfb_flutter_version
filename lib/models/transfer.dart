class Transfer {
  String? toAccountNo;

  String? fromAccountNo;

  double? amount;

  String? narration;

  String? pin;

  String? fullname;

  String? customerNo;
  
  String? reference;

  Transfer._toOwnAccountConstructor();

  static final Transfer _toOwnAccount = Transfer._toOwnAccountConstructor();

  factory Transfer.toOwnAccount() {
    return _toOwnAccount;
  }

  Transfer._toMFBAccountConstructor();

  static final Transfer _toMFBAccount = Transfer._toMFBAccountConstructor();

  factory Transfer.toMFBAccount() {
    return _toMFBAccount;
  }

  Transfer._toOtherBanksConstructor();

  static final Transfer _otherBanks = Transfer._toOtherBanksConstructor();

  factory Transfer.otherBanks() {
    return _otherBanks;
  }
}

enum TransferType {
  toOwnAccount,
  toMFBAccount,
  toOtherBanks,
}
