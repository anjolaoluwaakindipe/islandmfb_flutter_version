import 'package:get/get.dart';
import 'package:islandmfb_flutter_version/models/transfer.dart';
import 'package:islandmfb_flutter_version/pages/failure_page.dart';
import 'package:islandmfb_flutter_version/pages/home_page.dart';
import 'package:islandmfb_flutter_version/pages/login_page.dart';
import 'package:islandmfb_flutter_version/pages/mfb_account_transfer_page.dart';
import 'package:islandmfb_flutter_version/pages/own_account_transfer_page.dart';
import 'package:islandmfb_flutter_version/pages/success_page.dart';
import 'package:islandmfb_flutter_version/requests/transfer_request.dart';
import 'package:islandmfb_flutter_version/state/account_state_controller.dart';
import 'package:islandmfb_flutter_version/state/user_state_controller.dart';
import 'package:short_uuids/short_uuids.dart';

class TransferStateController extends GetxController {
  // INITIAL STATE
  final transferToOwnAccountState = Transfer.toOwnAccount().obs;
  final transferToMFBAccountState = Transfer.toMFBAccount().obs;
  final transferToOtherBanksState = Transfer.otherBanks().obs;

  // SET EACH TRANSFER TYPE TO FIELDS
  void setTransfertoField(TransferType transferType,
      {String accountNumber = ""}) {
    switch (transferType) {
      case TransferType.toOwnAccount:
        {
          transferToOwnAccountState.value.toAccountNo = accountNumber;
          transferToOwnAccountState.refresh();
        }
        break;
      case TransferType.toMFBAccount:
        {
          transferToMFBAccountState.value.toAccountNo =
              Get.put(AccountStateController())
                  .selectedAccount
                  .value
                  .primaryAccountNo!["_number"];
          transferToMFBAccountState.refresh();
        }
        break;
      case TransferType.toOtherBanks:
        {
          transferToOtherBanksState.value.toAccountNo = accountNumber;
          transferToOtherBanksState.refresh();
        }
        break;
      default:
        {}
        break;
    }
  }

  // MAKE TRANSFER REQUEST
  Future makeTransaction(TransferType transferType) async {
    switch (transferType) {
      case TransferType.toOwnAccount:
        {
          transferToOwnAccountState.value.reference =
              ShortUuid.init().generate().substring(0, 13);

          var transferResponse = await ownAccountTransfer(
              transferToOwnAccountState.value.amount!,
              transferToOwnAccountState.value.fromAccountNo!,
              transferToOwnAccountState.value.narration!,
              transferToOwnAccountState.value.toAccountNo!,
              transferToOwnAccountState.value.fullname!,
              transferToOwnAccountState.value.customerNo!,
              transferToOwnAccountState.value.reference!);

          if (transferResponse["success"] == true &&
              transferResponse["data"]!["postedOK"] == true) {
            clearTransferState(TransferType.toOwnAccount);
            Get.to(SuccessPage(
                buttonText: "Continue",
                successMessage: "Transfer was successfull!!!",
                nextPage: const HomePage()));
          } else {
            Get.to(FailurePage(
              buttonText: "Continue",
              failureMessage: "Unsuccessful Transaction",
              nextPage: OwnAccountTransferPage(),
            ));
          }
        }
        break;
      case TransferType.toMFBAccount:
        {
          transferToMFBAccountState.value.reference =
              ShortUuid.init().generate().substring(0, 13);
          var transferResponse = await intraBankTransfer(
              transferToMFBAccountState.value.amount!,
              transferToMFBAccountState.value.fromAccountNo!,
              transferToMFBAccountState.value.narration!,
              transferToMFBAccountState.value.toAccountNo!,
              transferToMFBAccountState.value.fullname!,
              transferToMFBAccountState.value.customerNo!,
              transferToMFBAccountState.value.reference!);

          if (transferResponse["success"] == true &&
              transferResponse["data"]!["postedOK"] == true) {
            clearTransferState(TransferType.toMFBAccount);
            Get.to(SuccessPage(
                buttonText: "Continue",
                successMessage: "Transfer was successfull!!!",
                nextPage: const HomePage()));
          } else {
            Get.to(FailurePage(
              buttonText: "Continue",
              failureMessage: "Unsuccessful Transaction",
              nextPage: MfbAccountTransferPage(),
            ));
          }
        }
        break;
      case TransferType.toOtherBanks:
        {}
        break;
      default:
        {}
        break;
    }
  }

  // SET FULL NAME AND CUSTOMER NUMBER
  void setfullNameAndCustomerNoAutomatically() {
    final customerNo = Get.put(UserStateController()).user["customer_no"];
    final fullName = Get.put(AccountStateController()).customerDetails["name"];

    if (customerNo == null || fullName == null) {
      Get.offAll(const LoginPage());
    } else {
      transferToMFBAccountState.value.customerNo = customerNo;
      transferToOtherBanksState.value.customerNo = customerNo;
      transferToOwnAccountState.value.customerNo = customerNo;
      transferToMFBAccountState.value.fullname = fullName;
      transferToOtherBanksState.value.fullname = fullName;
      transferToOwnAccountState.value.fullname = fullName;
    }
  }

  // SET EACH TRANSFER TYPE FROM FIELDS
  void setTransferFromField(TransferType transferType,
      {String accountNumber = ""}) {
    switch (transferType) {
      case TransferType.toOwnAccount:
        {
          transferToOwnAccountState.value.fromAccountNo = accountNumber;
          transferToOwnAccountState.refresh();
        }
        break;
      case TransferType.toMFBAccount:
        {
          transferToMFBAccountState.value.fromAccountNo = accountNumber;
          transferToMFBAccountState.refresh();
        }
        break;
      case TransferType.toOtherBanks:
        {
          transferToOtherBanksState.value.fromAccountNo = accountNumber;
          transferToOtherBanksState.refresh();
        }
        break;
      default:
        {}
        break;
    }
  }

  // SET NARRATION, PIN AND AMOUNT OF EACH TRANSFER TYPE
  void setAmountNarrationPinField(TransferType transferType,
      {double amount = 0.00, String narration = "", String pin = ""}) {
    switch (transferType) {
      case TransferType.toOwnAccount:
        {
          transferToOwnAccountState.value.amount = amount;
          transferToOwnAccountState.value.narration = narration;
          transferToOwnAccountState.value.pin = pin;
        }
        break;
      case TransferType.toMFBAccount:
        {
          transferToMFBAccountState.value.amount = amount;
          transferToMFBAccountState.value.narration = narration;
          transferToMFBAccountState.value.pin = pin;
        }
        break;
      case TransferType.toOtherBanks:
        {
          transferToOtherBanksState.value.amount = amount;
          transferToOtherBanksState.value.narration = narration;
          transferToOtherBanksState.value.pin = pin;
        }
        break;
      default:
        {}
        break;
    }
  }

  // LOAD RECIPIENT NAME
  Future loadRecipientName(TransferType transferType, String accountNo) async {
    switch (transferType) {
      case TransferType.toMFBAccount:
        {
          transferToMFBAccountState.value.receipientName = null;
          transferToMFBAccountState.refresh();
          final response = await recipientInfo(accountNo);

          if (response["success"] == true) {
            final accountName = response["data"]!["customerName"];
            transferToMFBAccountState.value.receipientName = accountName;
            transferToMFBAccountState.refresh();
            return;
          } else {
            transferToMFBAccountState.value.receipientName = null;
            transferToMFBAccountState.refresh();
            return response["data"];
          }
        }
      default:
        {
          return "";
        }
    }
  }

  // CLEAR EACH TRANSFER REQUEST
  void clearTransferState(TransferType transferType) {
    switch (transferType) {
      case TransferType.toOwnAccount:
        {
          transferToOwnAccountState.value.amount = null;
          transferToOwnAccountState.value.toAccountNo = null;
          transferToOwnAccountState.value.fromAccountNo = null;
          transferToOwnAccountState.value.narration = null;
          transferToOwnAccountState.value.pin = null;
          transferToOwnAccountState.value.reference = null;
          transferToOwnAccountState.refresh();
        }
        break;
      case TransferType.toMFBAccount:
        {
          transferToMFBAccountState.value.amount = null;
          transferToMFBAccountState.value.toAccountNo = null;
          transferToMFBAccountState.value.fromAccountNo = null;
          transferToMFBAccountState.value.narration = null;
          transferToMFBAccountState.value.pin = null;
          transferToMFBAccountState.value.reference = null;
          transferToMFBAccountState.value.receipientName = null;

          transferToMFBAccountState.refresh();
        }
        break;
      case TransferType.toOtherBanks:
        {
          transferToOtherBanksState.value.amount = null;
          transferToOtherBanksState.value.toAccountNo = null;
          transferToOtherBanksState.value.fromAccountNo = null;
          transferToOtherBanksState.value.narration = null;
          transferToOtherBanksState.value.pin = null;
          transferToOtherBanksState.value.reference = null;
          transferToOtherBanksState.refresh();
        }
        break;
      default:
        {}
        break;
    }
  }
}
