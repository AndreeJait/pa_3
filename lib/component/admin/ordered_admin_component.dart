import 'package:flutter/material.dart';
import 'package:pa_3/component/admin/OrderComponent/card_order.dart';
import 'package:pa_3/component/admin/OrderComponent/tabbar_custom.dart';
import 'package:pa_3/model/_order.dart';
import 'package:pa_3/model/product.dart';
import 'package:pa_3/model/user.dart';

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
    tempOrders = [];
    if (tabController?.index == 0) {
      orders = [
        ...tempOrders.where((element) =>
            element.status != "Done" && element.status != "Canceled")
      ];
    } else {
      orders = [
        ...tempOrders.where((element) =>
            !(element.status != "Done" && element.status != "Canceled"))
      ];
    }

    tabController?.addListener(() {
      if (tabController?.index == 0) {
        setState(() {
          orders = [
            ...tempOrders.where((element) =>
                element.status != "Done" && element.status != "Canceled")
          ];
        });
      } else {
        setState(() {
          orders = [
            ...tempOrders.where((element) =>
                !(element.status != "Done" && element.status != "Canceled"))
          ];
        });
      }
    });
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
            controller: tabController,
          ))
        ],
      ),
    );
  }
}
