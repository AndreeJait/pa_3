import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pa_3/api/request/order_request.dart';
import 'package:pa_3/api/response/order_response.dart';
import 'package:pa_3/api/rest_client.dart';
import 'package:pa_3/component/marketing/OrderComponent/card_order.dart';
import 'package:pa_3/component/marketing/OrderComponent/tabbar_custom.dart';
import 'package:pa_3/constans/preferences.dart';
import 'package:pa_3/model/order.dart';
import 'package:pa_3/model/product.dart';
import 'package:pa_3/utils/view_models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeMarketingComponent extends StatefulWidget {
  HomeMarketingComponent({Key? key}) : super(key: key);

  @override
  State<HomeMarketingComponent> createState() => _HomeMarketingComponentState();
}

class _HomeMarketingComponentState extends State<HomeMarketingComponent>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  List<Tab> tabs = const [
    Tab(
      text: "Ordered",
    ),
    Tab(
      text: "History",
    )
  ];
  List<String> orderedFilter = [
    "all",
    "packing",
    "waiting_confirmation",
    "accepted",
    "waiting_user_confirmation",
    "unpaid",
    "sent",
    "receive_by_user",
  ];
  List<String> historyFilter = ["all", "done", "canceled"];
  String dropDownValue = "all";
  List<String> spinnerItems = [];

  List<Product> products = [];
  List<Order> tempOrders = [];
  List<Order> orders = [];
  bool getData = true;
  StreamSubscription? subscription;

  @override
  void initState() {
    // TODO: implement initState
    subscription = ViewModels.stateStream.listen((event) {
      var foundIndex =
          event.indexWhere((element) => element["name"] == "allorders");
      if (foundIndex != -1) {
        setState(() {
          tempOrders = event[foundIndex]["value"];
          if (tabController?.index == 0) {
            orders = [
              ...tempOrders.where((element) =>
                  element.status != "done" && element.status != "canceled")
            ];
            dropDownValue = "all";
            spinnerItems = orderedFilter;
          } else {
            orders = [
              ...tempOrders.where((element) =>
                  !(element.status != "done" && element.status != "canceled"))
            ];
            dropDownValue = "all";
            spinnerItems = historyFilter;
          }
        });
      }
    });
    tabController = TabController(length: tabs.length, vsync: this);
    super.initState();
    getOrders().then((value) {
      setState(() {
        getData = false;
      });
    });

    tabController?.addListener(() {
      if (tabController?.index == 0) {
        setState(() {
          orders = [
            ...tempOrders.where((element) =>
                element.status != "done" && element.status != "canceled")
          ];
          dropDownValue = "all";
          spinnerItems = orderedFilter;
        });
      } else {
        setState(() {
          orders = [
            ...tempOrders.where((element) =>
                !(element.status != "done" && element.status != "canceled"))
          ];
          dropDownValue = "all";
          spinnerItems = historyFilter;
        });
      }
    });
  }

  Future<void> getOrders() async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString(prefToken)!;
    String refresh = prefs.getString(prefRefresh)!;
    Dio dio = Dio();
    dio.options.headers["Authorization"] = "Bearer $token";
    final client = RestClient(dio);
    if (ViewModels.state.containsKey("allorders")) {
      print("Here");
      List<Order> current = ViewModels.getState("allorders");
      setState(() {
        tempOrders = current;
      });
      OrderRequest request = OrderRequest(skip: 20);
      print(current.length);
      OrderResponse response = await client.getAllOrder(request);
      print(response.data.length);
      ViewModels.ctrlState.sink.add([
        {
          "name": "allorders",
          "value": [...current, ...response.data]
        },
      ]);
    } else {
      try {
        OrderRequest request = OrderRequest();
        OrderResponse response = await client.getAllOrder(request);
        ViewModels.ctrlState.sink.add([
          {"name": "allorders", "value": response.data},
        ]);
      } on DioError catch (e) {
        print(e);
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if (subscription != null) {
      subscription!.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return getData
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              children: [
                TabBarCustom(tabController: tabController!, tabs: tabs),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 20, bottom: 20),
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: dropDownValue,
                    icon: const Icon(
                      Icons.arrow_drop_down,
                    ),
                    iconSize: 24,
                    elevation: 16,
                    style: const TextStyle(color: Colors.black, fontSize: 18),
                    underline: Container(
                      height: 1,
                      color: Colors.black,
                    ),
                    onChanged: (String? data) {
                      setState(() {
                        dropDownValue = data!;
                        if (tabController?.index == 0) {
                          orders = [
                            ...tempOrders.where((element) =>
                                element.status != "done" &&
                                element.status != "canceled" &&
                                (element.status == dropDownValue ||
                                    dropDownValue == "all"))
                          ];
                        } else {
                          orders = [
                            ...tempOrders.where((element) =>
                                !(element.status != "done" &&
                                    element.status != "canceled") &&
                                (element.status == dropDownValue ||
                                    dropDownValue == "all"))
                          ];
                        }
                      });
                    },
                    items: [
                      ...spinnerItems.map((e) => DropdownMenuItem(
                            child: Text(e),
                            value: e,
                          ))
                    ],
                  ),
                ),
                Expanded(
                    child: TabBarView(
                  controller: tabController,
                  children: [
                    SingleChildScrollView(
                        child: Column(
                      children: [...orders.map((e) => CardOrder(order: e))],
                    )),
                    SingleChildScrollView(
                        child: Column(
                      children: [...orders.map((e) => CardOrder(order: e))],
                    )),
                  ],
                ))
              ],
            ),
          );
  }
}
