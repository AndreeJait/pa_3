import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:pa_3/api/request/order_request.dart';
import 'package:pa_3/api/rest_client.dart';
import 'package:pa_3/constans/api.dart';
import 'package:pa_3/constans/preferences.dart';
import 'package:pa_3/model/order.dart';
import 'package:pa_3/model/product.dart';
import 'package:pa_3/utils/view_models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CardOrder extends StatefulWidget {
  Order order;
  CardOrder({Key? key, required this.order}) : super(key: key);

  @override
  State<CardOrder> createState() => _CardOrderState();
}

class _CardOrderState extends State<CardOrder> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      margin: const EdgeInsets.only(bottom: 20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Wrap(
                spacing: 10,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  ClipOval(
                    child: Image.network(
                      "$baseUrlConstant/${widget.order.stock[0].product.variantImages[0]}",
                      height: 30,
                    ),
                  ),
                  Text(widget.order.user == null ? "" : widget.order.user!.name)
                ],
              ),
              Text(widget.order.status)
            ],
          ),
          ...widget.order.variant
              .asMap()
              .map((key, value) {
                int foundIndex =
                    widget.order.stock[0].product.variant.indexWhere(
                  (element) {
                    return element == value;
                  },
                );
                return MapEntry(
                  key,
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                            flex: 1,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                "$baseUrlConstant/${widget.order.stock[0].product.variantImages[foundIndex]}",
                                width: 100,
                              ),
                            )),
                        Expanded(
                            flex: 2,
                            child: Container(
                              margin: const EdgeInsets.only(left: 10),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 20),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Flexible(
                                              child: Text(
                                            "${widget.order.stock[0].product.name} ($value)",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          )),
                                          Container(
                                            margin:
                                                const EdgeInsets.only(left: 10),
                                            child: Text(NumberFormat
                                                    .simpleCurrency(
                                                        locale: "IDR",
                                                        decimalDigits: 2)
                                                .format(widget
                                                    .order
                                                    .stock[0]
                                                    .product
                                                    .priceVariant[foundIndex])),
                                          )
                                        ],
                                      ),
                                    ),
                                    Text(
                                        "Quantity : ${widget.order.quantity[key]}"),
                                    Text(
                                        "Price : ${(NumberFormat.simpleCurrency(locale: "IDR", decimalDigits: 2).format((widget.order.quantity[key]) * (widget.order.stock[0].product.priceVariant[foundIndex])))}"),
                                  ]),
                            )),
                      ],
                    ),
                  ),
                );
              })
              .values
              .toList(),
          Text(
              "Total Price : ${NumberFormat.simpleCurrency(locale: "IDR", decimalDigits: 2).format(widget.order.total)}"),
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: !(widget.order.status == "done" ||
                    widget.order.status == "canceled")
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          await showDialog(
                              context: context,
                              builder: (context) {
                                return DetailOrder(order: widget.order);
                              });
                        },
                        child: const Text("View Detail"),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          await showDialog(
                              context: context,
                              builder: (context) {
                                return SelectStatus(
                                  order: widget.order,
                                );
                              });
                        },
                        child: const Text("Update Status"),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                const Color.fromARGB(255, 248, 200, 63))),
                      )
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ElevatedButton(
                          onPressed: () async {
                            await showDialog(
                                context: context,
                                builder: (context) {
                                  return DetailOrder(order: widget.order);
                                });
                          },
                          child: const Text("View Detail")),
                    ],
                  ),
          )
        ],
      ),
    );
  }
}

class DetailOrder extends StatefulWidget {
  Order order;
  DetailOrder({Key? key, required this.order}) : super(key: key);

  @override
  State<DetailOrder> createState() => _DetailOrderState();
}

class _DetailOrderState extends State<DetailOrder> {
  NumberFormat format =
      NumberFormat.simpleCurrency(locale: "IDR", decimalDigits: 2);
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            width: double.infinity,
            color: Colors.white,
            child: Wrap(
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Detail Order",
                          style: TextStyle(fontSize: 18),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: FaIcon(FontAwesomeIcons.x),
                        ),
                      ],
                    ),
                    ...widget.order.stock.map((e) => Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 20),
                              width: double.infinity,
                              child: Text(
                                e.product.name,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                            ...widget.order.variant
                                .asMap()
                                .map((key, value) {
                                  int foundIndex = e.product.variant.indexWhere(
                                      (element) => element == value);
                                  Product p = e.product;
                                  Order o = widget.order;
                                  return MapEntry(
                                      key,
                                      Container(
                                        color:
                                            Color.fromARGB(255, 231, 243, 255),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 5),
                                        child: Row(
                                          children: [
                                            Image.network(
                                              "$baseUrlConstant/${p.variantImages[p.variantIndex[foundIndex]]}",
                                              width: 100,
                                              height: 100,
                                            ),
                                            Expanded(
                                                child: Wrap(
                                              runSpacing: 10,
                                              children: [
                                                Text(
                                                    "Variant $value (${format.format(e.product.priceVariant[foundIndex])})"),
                                                Container(
                                                  width: double.infinity,
                                                  child: Text(
                                                      "Quantity : ${o.quantity[key]}"),
                                                ),
                                                Text(
                                                    "${o.quantity[key]} x ${format.format(e.product.priceVariant[foundIndex])}"),
                                                Text(
                                                    "Total : ${format.format((o.quantity[key] * e.product.priceVariant[foundIndex]))}")
                                              ],
                                            ))
                                          ],
                                        ),
                                      ));
                                })
                                .values
                                .toList(),
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              width: double.infinity,
                              child: Text(
                                "Status : ${widget.order.status}",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              width: double.infinity,
                              child: Text(
                                "Metode pengemabilan : ${widget.order.sentOption}",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              width: double.infinity,
                              child: Text(
                                "Metode pembayaran : ${widget.order.paymentMethod}",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              width: double.infinity,
                              child: Text(
                                "Alamat : ${widget.order.address}",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              width: double.infinity,
                              child: Text(
                                "Total must paid : ${format.format(widget.order.total)}",
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                            if (widget.order.proof.isNotEmpty)
                              Container(
                                margin: EdgeInsets.only(top: 20),
                                width: double.infinity,
                                child: Image.network(
                                  "$baseUrlConstant/${widget.order.proof}",
                                  fit: BoxFit.fitWidth,
                                ),
                              )
                          ],
                        ))
                  ],
                )
              ],
            ),
          ),
        ));
  }
}

class SelectStatus extends StatefulWidget {
  Order order;
  SelectStatus({Key? key, required this.order}) : super(key: key);

  @override
  State<SelectStatus> createState() => _SelectStatusState();
}

class _SelectStatusState extends State<SelectStatus> {
  bool isLoading = false;
  List<String> options = ["sent", "receive_by_user", "done"];
  String selected = "";
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Update Status"),
      content: Wrap(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...options.map((e) => Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Radio(
                          value: e,
                          groupValue: selected,
                          onChanged: (String? value) {
                            if (!isLoading) {
                              setState(() {
                                selected = value!;
                              });
                            }
                          }),
                      Text(e)
                    ],
                  ))
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    await changeStatusApi();
                    setState(() {
                      isLoading = false;
                    });
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 248, 200, 63))),
                  child: isLoading
                      ? const CircularProgressIndicator()
                      : const Text("Save Changed"),
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            const Color.fromARGB(255, 248, 63, 63))),
                    child: const Text("Cancel")),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> changeStatusApi() async {
    setState(() {
      isLoading = true;
    });
    try {
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString(prefToken)!;
      String refresh = prefs.getString(prefRefresh)!;
      Dio dio = Dio();
      dio.options.headers["Authorization"] = "Bearer $token";
      final client = RestClient(dio);
      OrderStatusRequest request =
          OrderStatusRequest(id: widget.order.id!, status: selected);
      print(widget.order.id);
      var response = await client.changeStatusOrder(request);
      List<Order> orders = [...ViewModels.getState("allorders")];
      int foundIndex =
          orders.indexWhere((element) => element.id! == response.data.id);
      orders[foundIndex] = response.data;
      ViewModels.ctrlState.sink.add([
        {"name": "allorders", "value": orders},
      ]);
      setState(() {
        Navigator.of(context).pop();
      });
    } on DioError catch (e) {
      Widget cancelButton = TextButton(
        child: const Text("Cancel"),
        onPressed: () {
          Navigator.of(context).pop();
        },
      );
      Widget continueButton = TextButton(
        child: const Text("Try Again"),
        onPressed: () async {
          Navigator.of(context).pop();
          await changeStatusApi();
          setState(() {
            isLoading = false;
          });
        },
      );
      String message = e.message;

      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: const Text("AlertDialog"),
        content: Text(message),
        actions: [
          cancelButton,
          continueButton,
        ],
      );

      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }
  }
}
