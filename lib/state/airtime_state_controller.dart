import 'package:get/get.dart';
import 'package:islandmfb_flutter_version/pages/airtime_page.dart';
import 'package:islandmfb_flutter_version/pages/failure_page.dart';
import 'package:islandmfb_flutter_version/pages/home_page.dart';
import 'package:islandmfb_flutter_version/pages/success_page.dart';
import 'package:islandmfb_flutter_version/requests/airtime_request.dart';

class AirtimeStateController extends GetxController {
  final biller = "".obs;
  final product = "".obs;
  final amount = RxDouble(0);
  final mobileNumber = "".obs;
  final narration = "".obs;
  final productId = "".obs;

  void setAirtimeState(
      {String? biller,
      String? product,
      double? amount,
      String? mobileNumber,
      String? narration}) {
    this.biller.value = biller ?? this.biller.value;
    this.product.value = product ?? this.product.value;
    this.amount.value = amount ?? this.amount.value;
    this.mobileNumber.value = mobileNumber ?? this.mobileNumber.value;
    this.narration.value = narration ?? this.narration.value;
    refresh();
  }

  Future getAirtimeProductId() async {
    final productListResponse = await getProductList(mobileNumber.value);
    if (productListResponse["success"] == true) {
      product.value = productListResponse["data"]?["product"]["id"];
      refresh();
    } else {
      Get.to(FailurePage(
        buttonText: "Continue",
        failureMessage:
            "An error occured in loading airtime, Please try again later!",
        nextPage: const AirtimePage(),
      ));
    }

    return "";
  }

  Future purchaseAirtime(String productID) async {
    if (mobileNumber.value.isEmpty) return;

    Map purchaseResponse =
        await makeAirtimePurchase(mobileNumber.value, productID);

    if (purchaseResponse["success"] == true) {
      clearAirtimeState();
      Get.to(SuccessPage(
          buttonText: "Continue",
          successMessage: "Airtime was successfully loaded!!!",
          nextPage: const HomePage()));
    } else {
      Get.to(FailurePage(
        buttonText: "Continue",
        failureMessage: "Airtime could not be loaded Successfully.",
        nextPage: const AirtimePage(),
      ));
    }
  }

  clearAirtimeState() {
    biller.value = "";
    product.value = "";
    amount.value = 0;
    mobileNumber.value = "";
    narration.value = "";
    refresh();
  }
}
