import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pa_3/api/request/order_request.dart';
import 'package:pa_3/api/response/order_response.dart';
import 'package:pa_3/api/rest_client.dart';
import 'package:pa_3/component/admin/OrderComponent/card_order.dart';
import 'package:pa_3/component/admin/OrderComponent/tabbar_custom.dart';
import 'package:pa_3/constans/preferences.dart';
import 'package:pa_3/model/order.dart';
import 'package:pa_3/model/product.dart';
import 'package:pa_3/model/user.dart';
import 'package:pa_3/utils/view_models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderedAdminComponent extends StatefulWidget {
  OrderedAdminComponent({Key? key}) : super(key: key);

  @override
  State<OrderedAdminComponent> createState() => _OrderedAdminComponentState();
}

class _OrderedAdminComponentState extends State<OrderedAdminComponent>
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
  String dropDownValue = "All";
  List<String> spinnerItems = ["All", "Two"];

  List<Product> products = [];
  List<Order> tempOrders = [];
  List<Order> orders = [];

  @override
  void initState() {
    // TODO: implement initState
    tabController = TabController(length: tabs.length, vsync: this);
    super.initState();
    getOrders().then((value) {
      if (tabController?.index == 0) {
        orders = [
          ...tempOrders.where((element) =>
              element.status != "done" && element.status != "canceled")
        ];
      } else {
        orders = [
          ...tempOrders.where((element) =>
              !(element.status != "done" && element.status != "canceled"))
        ];
      }
    });

    tabController?.addListener(() {
      if (tabController?.index == 0) {
        setState(() {
          orders = [
            ...tempOrders.where((element) =>
                element.status != "done" && element.status != "canceled")
          ];
        });
      } else {
        setState(() {
          orders = [
            ...tempOrders.where((element) =>
                !(element.status != "done" && element.status != "canceled"))
          ];
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
      // ViewModels.ctrlState.sink.add([
      //   {
      //     "name": "allorders",
      //     "value": [...current, ...response.data]
      //   },
      // ]);
      setState(() {
        tempOrders = [...current, ...response.data];
      });
    } else {
      try {
        OrderRequest request = OrderRequest();
        OrderResponse response = await client.getAllOrder(request);
        ViewModels.ctrlState.sink.add([
          {"name": "allorders", "value": response.data},
        ]);
        setState(() {
          tempOrders = response.data;
        });
      } on DioError catch (e) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
