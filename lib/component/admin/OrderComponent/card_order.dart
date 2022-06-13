import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pa_3/constans/api.dart';
import 'package:pa_3/model/Product.dart';
import 'package:pa_3/model/order.dart';

class CardOrder extends StatelessWidget {
  Order order;
  CardOrder({Key? key, required this.order}) : super(key: key);

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
            offset: Offset(0, 2), // changes position of shadow
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
                      "$baseUrlConstant/${order.stock[0].product.variantImages[0]}",
                      height: 30,
                    ),
                  ),
                  Text(order.user == null ? "" : order.user!.name)
                ],
              ),
              Text(order.status)
            ],
          ),
          ...order.variant
              .asMap()
              .map((key, value) {
                int foundIndex = order.stock[0].product.variant.indexWhere(
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
                                "$baseUrlConstant/${order.stock[0].product.variantImages[foundIndex]}",
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
                                            "${order.stock[0].product.name} ($value)",
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
                                                .format(order.stock[0].product
                                                    .priceVariant[foundIndex])),
                                          )
                                        ],
                                      ),
                                    ),
                                    Text("Quantity : ${order.quantity[key]}"),
                                    Text(
                                        "Price : ${(NumberFormat.simpleCurrency(locale: "IDR", decimalDigits: 2).format((order.quantity[key]) * (order.stock[0].product.priceVariant[foundIndex])))}"),
                                  ]),
                            )),
                      ],
                    ),
                  ),
                );
              })
              .values
              .toList(),
          Container(
            child: Text(
                "Total Price : ${NumberFormat.simpleCurrency(locale: "IDR", decimalDigits: 2).format(order.total)}"),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: !(order.status == "Done" || order.status == "Canceled")
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: Text("View Detail"),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text("Update Status"),
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
                          onPressed: () {}, child: Text("View Detail")),
                    ],
                  ),
          )
        ],
      ),
    );
  }
}
