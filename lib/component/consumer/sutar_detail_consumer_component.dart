import 'package:flutter/material.dart';

import 'package:pa_3/component/consumer/order/order_form_controller.dart';
import 'package:pa_3/constans/router_consumer.dart';
import 'package:pa_3/temporary_model/Product.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:singel_page_route/singel_page_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

class SutarDetailConsumerComponent extends StatefulWidget {
  final int? productIndex;
  const SutarDetailConsumerComponent({Key? key, this.productIndex})
      : super(key: key);

  @override
  State<SutarDetailConsumerComponent> createState() =>
      _SutarDetailConsumerComponentState();
}

class _SutarDetailConsumerComponentState
    extends State<SutarDetailConsumerComponent> {
  final controller = CarouselController();
  int activeIndex = 0;
  String expiredDate =
      DateFormat.yMMMd().format(DateTime.now().add(const Duration(days: 3)));
  final OrderController o = Get.put(OrderController());

  @override
  void initState() {
    o.addPrice(products[0].price);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Column(
          children: [
            Column(
              children: [
                CarouselSlider.builder(
                  carouselController: controller,
                  options: CarouselOptions(
                    height: MediaQuery.of(context).size.height / 4,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    enlargeCenterPage: true,
                    enlargeStrategy: CenterPageEnlargeStrategy.height,
                    onPageChanged: (index, reason) => {
                      setState(() => activeIndex = index),
                    },
                  ),
                  itemCount: products.length - 1,
                  itemBuilder: (context, index, realIndex) {
                    final imageList = products[index].imageUrl;
                    final itemName = products[index].name;
                    return buildproductCard(imageList, itemName, index);
                  },
                ),
                const SizedBox(
                  height: 32,
                ),
                buildIndicator(),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                subtitle("Sutar Milk (1 Liter)"),
                subtitle("Rp.${products[0].price.toString()}")
              ],
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                detailText("Stock: 50"),
                detailText("Weight: 1 Litre"),
                detailText("Expired Date: $expiredDate"),
                detailText("Send from: PT. Cifa Indonesia"),
              ],
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                subtitle("Variants"),
                const SizedBox(height: 10),
                Row(
                  children: [
                    buildRadio(0, "Original"),
                    buildRadio(1, "Stroberi"),
                    buildRadio(2, "Coklat"),
                  ],
                ),
              ],
            ),
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
                        o.addPrice(products[0].price);
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
                          o.decPrice(products[0].price);
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

  Widget buildRadio(int index, String variant) => GestureDetector(
        onTap: () {
          controller.jumpToPage(index);
          o.setVariant(products[activeIndex].variant);
          print(o.variant);
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: const Color(0xffE0E0E0),
              border: Border.all(
                color: index == activeIndex
                    ? const Color(0xffF8C83F)
                    : Colors.transparent,
                width: 3,
              )),
          height: 56,
          width: 56,
          child: Image.asset(
            products[index].imageUrl,
            height: 50,
            width: 50,
          ),
        ),
      );

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: products.length - 1,
        effect: const JumpingDotEffect(
          dotWidth: 10,
          dotHeight: 10,
          activeDotColor: Color(0xffF8C83F),
          dotColor: Color(0xffE0E0E0),
        ),
      );

  Widget buildproductCard(String urlImage, String itemName, int index) => Card(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Image.asset(
              urlImage,
              width: MediaQuery.of(context).size.width / 4,
              height: MediaQuery.of(context).size.height / 5.5,
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.indigo[100],
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(itemName),
                ],
              ),
            ),
          ),
        ]),
      );
}
