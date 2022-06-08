import 'package:flutter/material.dart';

import 'package:pa_3/constans/general_router_constant.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';

class PurchaseVisitorComponent extends StatefulWidget {
  const PurchaseVisitorComponent({Key? key}) : super(key: key);

  @override
  State<PurchaseVisitorComponent> createState() =>
      _PurchaseVisitorComponentState();
}

class _PurchaseVisitorComponentState extends State<PurchaseVisitorComponent> {
  int activeIndex = 0;
  final sutarImageLists = [
    "assets/images/sutar_original.png",
    "assets/images/sutar_coklat.png",
    "assets/images/sutar_stroberi.png",
  ];
  final sutarVariants = ["Sutar Original", "Sutar Coklat", "Sutar Strawberry"];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            // First Row
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                textList(
                  "Come join so you can place\n an order for the product!",
                ),
                const SizedBox(
                  width: 10,
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
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Our Pricing",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xff585858),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xffE7F3FF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CarouselSlider.builder(
                    options: CarouselOptions(
                      height: 280,
                      enableInfiniteScroll: false,
                      enlargeCenterPage: true,
                      enlargeStrategy: CenterPageEnlargeStrategy.height,
                      onPageChanged: (index, reason) => {
                        setState(() => activeIndex = index),
                      },
                    ),
                    itemCount: sutarImageLists.length,
                    itemBuilder: (context, index, realIndex) {
                      final sutarImageList = sutarImageLists[index];
                      final sutarVariant = sutarVariants[index];
                      return buildImage(sutarImageList, sutarVariant, index);
                    },
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Rp. 17.000"),
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
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xffE7F3FF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 50,
                    ),
                    child: Image.asset(
                      "assets/images/mozarella.png",
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                  const Text("Mozzataru"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Rp. 27.000"),
                      ElevatedButton(
                        style: raisedButtonstyle,
                        child: const Text("Order"),
                        onPressed: () {
                          Navigator.pushNamed(context, routeRegister);
                        },
                      ),
                    ],
                  ),
                ],
              ),
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

  Widget textList(String text) => Text(
        text,
        maxLines: 2,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 11, color: Color(0xff585858)),
      );

  Widget buildImage(String urlImage, String name, int index) => Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 50,
            ),
            child: Image.asset(
              urlImage,
              fit: BoxFit.scaleDown,
            ),
          ),
          Text(name),
        ],
      );

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: sutarImageLists.length,
        effect: const JumpingDotEffect(
          dotWidth: 10,
          dotHeight: 10,
          activeDotColor: Color(0xffF8C83F),
          dotColor: Color(0xffE0E0E0),
        ),
      );
}
