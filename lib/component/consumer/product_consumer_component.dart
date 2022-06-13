import 'package:flutter/material.dart';

import 'package:pa_3/component/consumer/order/order_form_controller.dart';
import 'package:pa_3/constans/router_consumer.dart';
import 'package:pa_3/temporary_model/Product.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:singel_page_route/singel_page_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';

class ProductConsumerComponent extends StatefulWidget {
  const ProductConsumerComponent({Key? key}) : super(key: key);

  @override
  State<ProductConsumerComponent> createState() =>
      _ProductConsumerComponentState();
}

class _ProductConsumerComponentState extends State<ProductConsumerComponent> {
  final OrderController o = Get.put(OrderController());
  int activeIndex = 0;
  final sutarIndex = [0, 1, 2];
  final mozzataruIndex = [3];

  @override
  void initState() {
    o.setQuantity();
    o.setTotalPayment();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Wrap(
          spacing: 10,
          children: [
            const Text(
              "Products",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xff585858),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    color: Color(0xffEFEEEE),
                    borderRadius: BorderRadius.all(Radius.circular(6.0)),
                  ),
                  child: const Text("Susu Tarutung (Sutar)"),
                ),
                Image.asset(
                  "assets/images/botol.png",
                  width: MediaQuery.of(context).size.width / 12,
                  height: MediaQuery.of(context).size.height / 12,
                )
              ],
            ),
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 10),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: const Color(0xffE7F3FF),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    Column(
                      children: [
                        CarouselSlider.builder(
                          options: CarouselOptions(
                              height: MediaQuery.of(context).size.height / 4,
                              enableInfiniteScroll: false,
                              enlargeCenterPage: true,
                              enlargeStrategy: CenterPageEnlargeStrategy.height,
                              autoPlayInterval: const Duration(
                                seconds: 2,
                              ),
                              onPageChanged: (index, reason) => {
                                    setState(() => activeIndex = index),
                                  }),
                          itemCount: sutarIndex.length,
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Rp ${products[0].price}"),
                            ElevatedButton(
                              style: raisedButtonstyle,
                              child: const Text("ORDER NOW"),
                              onPressed: () {
                                // Navigator.pushNamed(context, routeOrderForm);
                                SingelPageRoute.pushName(routeSutar);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    color: Color(0xffEFEEEE),
                    borderRadius: BorderRadius.all(Radius.circular(6.0)),
                  ),
                  child: const Text("Mozarella Tarutung (Mozataru)"),
                ),
                Image.asset(
                  "assets/images/keju.png",
                  width: MediaQuery.of(context).size.width / 12,
                  height: MediaQuery.of(context).size.height / 12,
                )
              ],
            ),
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
                          child: Column(
                            children: [
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Image.asset(
                                      "assets/images/mozarella.png",
                                      width:
                                          MediaQuery.of(context).size.width / 4,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              5.5,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      Text(products[3].name),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Rp ${products[3].price}"),
                          ElevatedButton(
                            style: raisedButtonstyle,
                            child: const Text("ORDER NOW"),
                            onPressed: () {
                              SingelPageRoute.pushName(routeMozzataru);
                            },
                          ),
                        ],
                      ),
                    ],
                  )),
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

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: sutarIndex.length,
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
