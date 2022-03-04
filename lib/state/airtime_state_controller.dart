import 'package:get/get.dart';

class AirtimeStateController extends GetxController {
  RxMap<String, dynamic> airtimeState = <String, dynamic>{
    "biller": "",
    "product": "",
    "amount": 0,
    "mobileNumber": "",
    "narration": "",
  }.obs;

  void setAirtimeState(
      {String? biller,
      String? product,
      double? amount,
      String? mobileNumber,
      String? narration}) {
    airtimeState.value = {
      ...airtimeState,
      "biller": biller ?? airtimeState["biller"],
      "product": product ?? airtimeState["product"],
      "amount": amount ?? airtimeState["amount"],
      "mobileNumber": mobileNumber ?? airtimeState["mobileNumber"],
      "narration": narration ?? airtimeState["narration"]
    };
  }
}
