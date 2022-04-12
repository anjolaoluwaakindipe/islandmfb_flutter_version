import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:islandmfb_flutter_version/components/home_page/home_page_transaction_history_buttons.dart';
import 'package:islandmfb_flutter_version/pages/home_page.dart';
import 'package:islandmfb_flutter_version/requests/account_request.dart';
import 'package:islandmfb_flutter_version/state/account_state_controller.dart';
import 'package:islandmfb_flutter_version/utilities/colors.dart';

class TransactionHistoryPage extends StatefulWidget {
  TransactionHistoryPage({Key? key}) : super(key: key);

  @override
  State<TransactionHistoryPage> createState() => _TransactionHistoryPageState();
}

class _TransactionHistoryPageState extends State<TransactionHistoryPage> {
  static const _pageSize = 2;
  Map<String, dynamic> transactionPeriod = {
    "endDate": DateTime.now(),
    "startDate": null,
  };

  final selectedAccount = Get.put(AccountStateController()).selectedAccount;

  final _pageController = PagingController(
    firstPageKey: 0,
  );
  final nairaFormat = NumberFormat.currency(name: "N  ");

  @override
  void initState() {
    _pageController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });

    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await getCustomerTransactionsSpecifically(
              DateFormat("yyyyMMdd").format(transactionPeriod["endDate"]),
              selectedAccount.value.primaryAccountNo["_number"],
              page: pageKey,
              size: 10,
              startDate: transactionPeriod["startDate"] != null
                  ? DateFormat("yyyyMMdd")
                      .format(transactionPeriod["startDate"]!)
                  : "19500101")
          .then((data) => data["data"]["content"]);

      final isLastPage = newItems.length < _pageSize;

      if (isLastPage) {
        _pageController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        _pageController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pageController.error = error;
    }
  }

  _selectDate(
      BuildContext context, String selectedDate, StateSetter updater) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate:
          transactionPeriod[selectedDate] ?? transactionPeriod["endDate"],
      firstDate:
          selectedDate == "startDate" || transactionPeriod["startDate"] == null
              ? DateTime(DateTime.now().year - 150)
              : transactionPeriod["startDate"],
      lastDate: selectedDate == "endDate"
          ? DateTime(
              DateTime.now().year, DateTime.now().month, DateTime.now().day)
          : DateTime(
              transactionPeriod["endDate"]?.year,
              transactionPeriod["endDate"]?.month,
              transactionPeriod["endDate"]?.day),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: primaryColor, // header background color
              onPrimary: whiteColor, // header text color
              onSurface: lightextColor, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: primaryColor, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (selected != null) {
      updater(() {
        transactionPeriod[selectedDate] = selected;
      });
      print(transactionPeriod[selectedDate]);
      _pageController.refresh();
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: IconButton(
            onPressed: () {
              Get.to(const HomePage());
            },
            icon: SvgPicture.asset(
              "assets/images/back.svg",
              height: 20,
            ),
          ),
        ),
        backgroundColor: whiteColor,
        title: const Text(
          "Transaction History",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: blackColor,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        toolbarHeight: 80,
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet<void>(
                  context: context,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  builder: (BuildContext context1) {
                    return StatefulBuilder(
                        builder: (context, StateSetter updater) {
                      return transactionPageBottomFilter(
                          context,
                          transactionPeriod["startDate"],
                          transactionPeriod["endDate"],
                          _selectDate,
                          updater);
                    });
                  });
            },
            icon: SvgPicture.asset("assets/images/transactionhistoryFilter.svg",
                height: 50, fit: BoxFit.cover),
          ),
          const SizedBox(width: 20)
        ],
      ),
      backgroundColor: whiteColor,
      body: RefreshIndicator(
        onRefresh: () => Future.sync(() => _pageController.refresh()),
        backgroundColor: primaryColor,
        triggerMode: RefreshIndicatorTriggerMode.onEdge,
        color: whiteColor,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                PagedListView(
                  pagingController: _pageController,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  builderDelegate: PagedChildBuilderDelegate(
                    itemBuilder: (context, item, index) {
                      final newItem = item as Map;
                      return HomePageTransactionHistoryButtons(
                        nairaFormat: nairaFormat,
                        moneyAmount: newItem["amount"],
                        narrative: newItem["narrative"],
                        date: newItem["postDate"],
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 40,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget transactionPageBottomFilter(BuildContext context, DateTime? startDate,
      DateTime endDate, selectDate, StateSetter updater) {
    return Container(
      height: 600,
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const SizedBox(
            height: 30,
          ),
          Container(
            width: 40,
            height: 3,
            decoration: BoxDecoration(
                color: blackColor, borderRadius: BorderRadius.circular(10)),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 30, right: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Transaction Period",
                    style: TextStyle(
                        fontSize: 14,
                        color: blackColor,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "from:",
                    style: TextStyle(
                        fontSize: 12,
                        color: blackColor,
                        fontWeight: FontWeight.w200),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      selectDate(context, "startDate", updater);
                    },
                    child: Container(
                      height: 50,
                      padding: const EdgeInsets.only(left: 10, right: 20),
                      decoration: BoxDecoration(
                        color: accentColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  startDate != null
                                      ? DateFormat("dd/MM/yyyy")
                                          .format(startDate)
                                      : "dd/mm/yy",
                                  style: const TextStyle(color: lightextColor)),
                              const Icon(
                                Icons.arrow_drop_down,
                                color: greyColor,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "to:",
                    style: TextStyle(
                        fontSize: 12,
                        color: blackColor,
                        fontWeight: FontWeight.w200),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      selectDate(context, "endDate", updater);
                    },
                    child: Container(
                      height: 50,
                      padding: const EdgeInsets.only(left: 10, right: 20),
                      decoration: BoxDecoration(
                        color: accentColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(DateFormat("dd/MM/yyyy").format(endDate),
                                  style: const TextStyle(color: lightextColor)),
                              const Icon(
                                Icons.arrow_drop_down,
                                color: greyColor,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
