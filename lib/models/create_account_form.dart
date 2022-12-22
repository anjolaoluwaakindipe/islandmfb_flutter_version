import 'package:islandmfb_flutter_version/models/requests/account_types_response.dart';

class CreateAccountForm {
  String bvn;
  String phoneNumber;
  String email;
  String firstName;
  String lastName;
  String gender;
  String dateOfBirth;
  String middleName;
  String loginId;
  String password;
  AccountTypesResponse? accountType;

  CreateAccountForm(
      {this.bvn = "",
      this.phoneNumber = "",
      this.email = "",
      this.firstName = "",
      this.middleName = "",
      this.lastName = "",
      this.gender = "",
      this.dateOfBirth = "",
      this.loginId = "",
      this.password = ""});
}
