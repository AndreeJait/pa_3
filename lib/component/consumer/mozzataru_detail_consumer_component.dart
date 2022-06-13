import 'package:flutter/material.dart';

import 'package:pa_3/component/consumer/order/order_form_controller.dart';
import 'package:pa_3/constans/router_consumer.dart';
import 'package:pa_3/temporary_model/Product.dart';

import 'package:singel_page_route/singel_page_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

class MozzataruDetailConsumerComponent extends StatefulWidget {
  final int? productIndex;
  const MozzataruDetailConsumerComponent({Key? key, this.productIndex})
      : super(key: key);

  @override
  State<MozzataruDetailConsumerComponent> createState() =>
      _MozzataruDetailConsumerComponentState();
}

class _MozzataruDetailConsumerComponentState
    extends State<MozzataruDetailConsumerComponent> {
  final controller = CarouselController();
  int activeIndex = 0;
  String expiredDate =
      DateFormat.yMMMd().format(DateTime.now().add(const Duration(days: 3)));
  final OrderController o = Get.put(OrderController());

  @override
  void initState() {
    o.addPrice(products[3].price);
    o.setVariant("Mozzarella");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Column(
          children: [
            Center(
              child: Container(
                  margin: const EdgeInsets.only(top: 10),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: const Color(0xffE7F3FF),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Card(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Image.asset(
                            "assets/images/mozarella.png",
                            width: MediaQuery.of(context).size.width / 2,
                            height: MediaQuery.of(context).size.height / 3.5,
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                subtitle("Mozzataru (250 gram)"),
                subtitle("Rp.${products[3].price.toString()}")
              ],
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                detailText("Stock: 79"),
                detailText("Weight: 250 grams"),
                detailText("Expired Date: $expiredDate"),
                detailText("Send from: PT. Cifa Indonesia"),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(
                  () => Text('Total Quantity: ${o.quantity}'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FloatingActionButton.small(
                      heroTag: 1,
                      onPressed: () {
                        o.addQuantity();
                        o.addPrice(products[3].price);
                      },
                      child: const Icon(Icons.add),
                    ),
                    FloatingActionButton.small(
                      heroTag: 2,
                      onPressed: () {
                        if (o.quantity <= 1) {
                          null;
                        } else {
                          o.decQuantity();
                          o.decPrice(products[3].price);
                        }
                      },
                      child: const Icon(Icons.remove),
                    )
                  ],
                )
              ],
            ),
            ElevatedButton(
              style: raisedButtonstyle,
              child: const Text("Order"),
              onPressed: () {
                SingelPageRoute.pushName(routeOrder);
              },
            ),
          ],
        ),
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
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: Color(0xff585858),
        ),
      );
}
