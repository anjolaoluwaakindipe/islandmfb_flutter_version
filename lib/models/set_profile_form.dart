// ignore_for_file: public_member_api_docs, sort_constructors_first
class SetProfileForm {
  String accountNo;
  String password;
  String firstName;
  String lastName;
  String phoneRef;
  String email;
  String loginId;
  String customerNo;

  SetProfileForm({
    required this.accountNo,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.phoneRef,
    required this.email,
    required this.loginId,
    required this.customerNo,
  });

  @override
  String toString() {
    return 'SetProfileForm(accountNo: $accountNo, password: $password, firstName: $firstName, lastName: $lastName, phoneRef: $phoneRef, email: $email, loginId: $loginId, customerNo: $customerNo)';
  }

  SetProfileForm copyWith({
    String? accountNo,
    String? password,
    String? firstName,
    String? lastName,
    String? phoneRef,
    String? email,
    String? loginId,
    String? customerNo,
  }) {
    return SetProfileForm(
      accountNo: accountNo ?? this.accountNo,
      password: password ?? this.password,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phoneRef: phoneRef ?? this.phoneRef,
      email: email ?? this.email,
      loginId: loginId ?? this.loginId,
      customerNo: customerNo ?? this.customerNo,
    );
  }
}
