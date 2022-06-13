import 'package:flutter/material.dart';

import 'package:pa_3/component/consumer/order/order_form_controller.dart';
import 'package:pa_3/constans/router_consumer.dart';
import 'package:pa_3/temporary_model/Product.dart';
import 'package:pa_3/temporary_model/User.dart';

import 'package:singel_page_route/singel_page_route.dart';
import 'package:get/get.dart';

class OrderConsumerComponent extends StatefulWidget {
  const OrderConsumerComponent({Key? key}) : super(key: key);

  @override
  State<OrderConsumerComponent> createState() => _OrderConsumerComponentState();
}

class _OrderConsumerComponentState extends State<OrderConsumerComponent> {
  final OrderController o = Get.put(OrderController());

  get products => null;

  get users => null;

  @override
  Widget build(BuildContext context) {
    var index = 0;
    index = index = o.getIndex(o.variant);
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: subtitle("Address"),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: detailText(users[0].address),
          ),
          const Divider(),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: subtitle("Product"),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              children: [
                Image.asset(
                  products[index].imageUrl,
                  width: MediaQuery.of(context).size.width / 4,
                  height: MediaQuery.of(context).size.height / 5.5,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    detailText(products[index].name),
                    detailText('Rp. ${products[index].price.toString()}'),
                  ],
                ),
              ],
            ),
          ),
          const Divider(),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total Quantity:'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                        onPressed: () {
                          o.addQuantity();
                          o.addPrice(products[index].price);
                        },
                        icon: const Icon(Icons.add)),
                    Obx(() => Text(o.quantity.toString())),
                    IconButton(
                        onPressed: () {
                          if (o.quantity <= 1) {
                            null;
                          } else {
                            o.decQuantity();
                            o.decPrice(products[index].price);
                          }
                        },
                        icon: const Icon(Icons.remove)),
                  ],
                )
              ],
            ),
          ),
          const Divider(),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                subtitle("Shipment"),
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                  onPressed: () {
                    SingelPageRoute.pushName(routeShipment);
                  },
                  child: Text(o.shipment),
                ),
              ],
            ),
          ),
          const Divider(),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                detailText("Total Payment"),
                Obx(() => Text('${o.totalPayment}')),
              ],
            ),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                style: raisedButtonstyle,
                child: const Text("Back"),
                onPressed: () {
                  SingelPageRoute.pushName(routeSutar);
                },
              ),
              ElevatedButton(
                style: raisedButtonstyle,
                child: const Text("Continue to Payment"),
                onPressed: () {
                  SingelPageRoute.pushName(routePayment);
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}

final ButtonStyle raisedButtonstyle = ElevatedButton.styleFrom(
  onPrimary: Colors.white,
  primary: const Color(0xffF8C83F),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
  ),
);

final ButtonStyle addDecQuantity = ElevatedButton.styleFrom(
  onPrimary: Colors.white,
  primary: const Color(0xffF8C83F),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
  ),
);

Widget fullname(text) => Text(
      text,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Color(0xff585858),
      ),
    );

Widget subtitle(text) => Text(
      text,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Color(0xff585858),
      ),
    );

Widget detailText(text) => Text(
      text,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.normal,
        color: Color(0xff585858),
      ),
    );
