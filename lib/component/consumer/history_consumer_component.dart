import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pa_3/api/request/order_request.dart';
import 'package:pa_3/api/response/order_response.dart';
import 'package:pa_3/api/rest_client.dart';
import 'package:pa_3/component/consumer/order/card_order.dart';
import 'package:pa_3/constans/preferences.dart';
import 'package:pa_3/model/order.dart';
import 'package:pa_3/utils/view_models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryConsumerComponent extends StatefulWidget {
  const HistoryConsumerComponent({Key? key}) : super(key: key);

  @override
  State<HistoryConsumerComponent> createState() =>
      _HistoryConsumerComponentState();
}

class _HistoryConsumerComponentState extends State<HistoryConsumerComponent> {
  List<String> orderedFilter = ["all", "done", "canceled"];
  StreamSubscription? subscription;
  List<Order> tempOrders = [];
  List<Order> orders = [];
  bool getData = true;
  String dropdownValue = "all";
  @override
  void initState() {
    // TODO: implement initState

    subscription = ViewModels.stateStream.listen((event) {
      var foundIndex =
          event.indexWhere((element) => element["name"] == "myOrders");
      print("Here 2");
      if (foundIndex != -1) {
        setState(() {
          tempOrders = event[foundIndex]["value"];
          orders = [
            ...tempOrders.where((element) =>
                element.status == "done" || element.status == "canceled")
          ];
        });
      }
    });
    getOrders().then((value) {
      setState(() {
        getData = false;
      });
    });
    super.initState();
  }

  Future<void> getOrders() async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString(prefToken)!;
    String refresh = prefs.getString(prefRefresh)!;
    Dio dio = Dio();
    dio.options.headers["Authorization"] = "Bearer $token";
    final client = RestClient(dio);
    if (ViewModels.state.containsKey("myOrders")) {
      print("Here");
      List<Order> current = ViewModels.getState("myOrders");
      setState(() {
        tempOrders = current;
      });
      OrderRequest request = OrderRequest(skip: current.length);
      print(current.length);
      print(ViewModels.getState("user").id);
      OrderResponse response =
          await client.getMyOrder(ViewModels.getState("user").id, request);
      print(response.data.length);
      var temp = [...current, ...response.data];
      temp.sort(((a, b) => b.createdAt!.microsecondsSinceEpoch
          .compareTo(a.createdAt!.microsecondsSinceEpoch)));
      ViewModels.ctrlState.sink.add([
        {"name": "myOrders", "value": temp},
      ]);
    } else {
      try {
        OrderRequest request = OrderRequest();
        OrderResponse response =
            await client.getMyOrder(ViewModels.getState("user").id, request);
        response.data.sort(((a, b) => b.createdAt!.microsecondsSinceEpoch
            .compareTo(a.createdAt!.microsecondsSinceEpoch)));
        ViewModels.ctrlState.sink.add([
          {"name": "myOrders", "value": response.data},
        ]);
        print(response.data.length);
      } on DioError catch (e) {
        print(e);
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    if (subscription != null) {
      subscription!.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: getData
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Center(
                  child: CircularProgressIndicator(),
                )
              ],
            )
          : Column(
              children: [
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 20, bottom: 20),
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: dropdownValue,
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
                        dropdownValue = data!;
                        setState(() {
                          orders = [
                            ...tempOrders.where((element) =>
                                element.status == data || data == "all")
                          ];
                        });
                      });
                    },
                    items: [
                      ...orderedFilter.map((e) => DropdownMenuItem(
                            child: Text(e),
                            value: e,
                          ))
                    ],
                  ),
                ),
                ...orders.map((e) => CardOrderConsumer(order: e))
              ],
            ),
    );
  }

  final ButtonStyle raisedButtonstyle = ElevatedButton.styleFrom(
    onPrimary: Colors.white,
    primary: const Color(0xffF8C83F),
    minimumSize: const Size(88, 36),
    padding: const EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
  );
}
