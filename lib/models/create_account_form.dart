
class CreateAccountForm {
  String bvn;
  String phoneNumber;
  String email;
  String firstName;
  String lastName;
  String gender;
  String dateOfBirth;

  CreateAccountForm(
      {this.bvn = "",
      this.phoneNumber = "",
      this.email = "",
      this.firstName = "",
      this.lastName = "",
      this.gender = "",
      this.dateOfBirth = ""});
}
