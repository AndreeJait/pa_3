import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pa_3/constans/api.dart';

import 'package:pa_3/constans/general_router_constant.dart';
import 'package:pa_3/model/product_stock.dart';
import 'package:pa_3/utils/view_models.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';

class PurchaseVisitorComponent extends StatefulWidget {
  const PurchaseVisitorComponent({Key? key}) : super(key: key);

  @override
  State<PurchaseVisitorComponent> createState() =>
      _PurchaseVisitorComponentState();
}

class _PurchaseVisitorComponentState extends State<PurchaseVisitorComponent> {
  Map<String, int> activesIndex = {};
  List<ProductStock> stocks = ViewModels.state["activeProducts"];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          // First Row
          Wrap(
            runAlignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 10,
            children: [
              textList(
                "Come join so you can place\n an order for the product!",
              ),
              Wrap(
                spacing: 10,
                direction: Axis.horizontal,
                children: [
                  ElevatedButton(
                    style: raisedButtonstyle,
                    child: const Text("Login"),
                    onPressed: () {
                      Navigator.pushNamed(context, routeLogin);
                    },
                  ),
                  ElevatedButton(
                    style: raisedButtonstyle,
                    child: const Text("Register"),
                    onPressed: () {
                      Navigator.pushNamed(context, routeRegister);
                    },
                  ),
                ],
              )
            ],
          ),
          Container(
            margin: EdgeInsets.only(bottom: 20, top: 20),
            child: const Text(
              "Our Pricing",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xff585858),
              ),
            ),
          ),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: [
                ...stocks.map((e) => Container(
                      margin: EdgeInsets.only(bottom: 20),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 0),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(231, 243, 255, 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          CarouselSlider.builder(
                            options: CarouselOptions(
                              height: 280,
                              enableInfiniteScroll: false,
                              enlargeCenterPage: true,
                              enlargeStrategy: CenterPageEnlargeStrategy.height,
                              onPageChanged: (index, reason) => {
                                setState(() {
                                  activesIndex[e.product.name] = index;
                                }),
                              },
                            ),
                            itemCount: e.product.variantImages.length,
                            itemBuilder: (context, index, realIndex) {
                              final sutarImageList = e.product
                                  .variantImages[e.product.variantIndex[index]];
                              final sutarVariant = e.product.variant[index];
                              return buildImage(
                                  sutarImageList, sutarVariant, index);
                            },
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                if (activesIndex.containsKey(e.product.name))
                                  Text(NumberFormat.simpleCurrency(
                                          locale: "IDR", decimalDigits: 2)
                                      .format(e.product.priceVariant[
                                          activesIndex[e.product.name]!]))
                                else
                                  Text(NumberFormat.simpleCurrency(
                                          locale: "IDR", decimalDigits: 2)
                                      .format(e.product.priceVariant[0])),
                                ElevatedButton(
                                  style: raisedButtonstyle,
                                  child: const Text("Order"),
                                  onPressed: () {
                                    Navigator.pushNamed(context, routeRegister);
                                  },
                                ),
                              ]),
                        ],
                      ),
                    )),
              ],
            ),
          ))
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

  Widget textList(String text) => Text(
        text,
        maxLines: 2,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 11, color: Color(0xff585858)),
      );

  Widget buildImage(String urlImage, String name, int index) => Wrap(
        runAlignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        alignment: WrapAlignment.center,
        direction: Axis.vertical,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 50,
            ),
            child: Image.network(
              "$baseUrlConstant/$urlImage",
              fit: BoxFit.fitWidth,
              width: 180,
              height: 180,
            ),
          ),
          Text(name),
        ],
      );

  // Widget buildIndicator() => AnimatedSmoothIndicator(
  //       activeIndex: activeIndex,
  //       count: sutarImageLists.length,
  //       effect: const JumpingDotEffect(
  //         dotWidth: 10,
  //         dotHeight: 10,
  //         activeDotColor: Color(0xffF8C83F),
  //         dotColor: Color(0xffE0E0E0),
  //       ),
  //     );
}
