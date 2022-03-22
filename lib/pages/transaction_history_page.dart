import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:islandmfb_flutter_version/components/home_page/home_page_transaction_history_buttons.dart';
import 'package:islandmfb_flutter_version/pages/home_page.dart';
import 'package:islandmfb_flutter_version/requests/account_request.dart';
import 'package:islandmfb_flutter_version/utilities/colors.dart';

class TransactionHistoryPage extends StatefulWidget {
  TransactionHistoryPage({Key? key}) : super(key: key);

  @override
  State<TransactionHistoryPage> createState() => _TransactionHistoryPageState();
}

class _TransactionHistoryPageState extends State<TransactionHistoryPage> {
  static const _pageSize = 2;
  DateTime startDate = DateTime.now();
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
              DateFormat("yyyyMMdd").format(DateTime.now()), "1000021",
              page: pageKey, size: 10)
          .then((data) => data["data"]["content"]);

      final previouslyFetched = _pageController.itemList?.length ?? 0;

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
            onPressed: () {},
            icon: SvgPicture.asset("assets/images/transactionhistoryFilter.svg",
                height: 50, fit: BoxFit.cover),
          ),
          const SizedBox(width: 20)
        ],
      ),
      backgroundColor: whiteColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
        ),
        child: RefreshIndicator(
          onRefresh: () => Future.sync(() => _pageController.refresh()),
          backgroundColor: primaryColor,
          color: whiteColor,
          child: PagedListView(
              pagingController: _pageController,
              shrinkWrap: true,
              builderDelegate: PagedChildBuilderDelegate(
                itemBuilder: (context, item, index) {
                  print(item);
                  final newItem = item as Map;
                  return HomePageTransactionHistoryButtons(
                    nairaFormat: nairaFormat,
                    moneyAmount: newItem["amount"],
                    narrative: newItem["narrative"],
                    date: newItem["postDate"],
                  );
                },
              )),
        ),
      ),
    );
  }
}
