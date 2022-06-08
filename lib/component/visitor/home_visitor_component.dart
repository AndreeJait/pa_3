import 'package:flutter/material.dart';

import 'package:pa_3/constans/general_router_constant.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeVisitorComponent extends StatefulWidget {
  const HomeVisitorComponent({Key? key}) : super(key: key);

  @override
  State<HomeVisitorComponent> createState() => _HomeVisitorComponentState();
}

class _HomeVisitorComponentState extends State<HomeVisitorComponent> {
  int activeIndex = 0;
  final imageLists = [
    "assets/images/sutar_original.png",
    "assets/images/sutar_coklat.png",
    "assets/images/sutar_stroberi.png",
    "assets/images/mozarella.png",
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
      padding: const EdgeInsets.all(30),
      child: Column(
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          style: DefaultTextStyle.of(context).style,
                          children: const <TextSpan>[
                            TextSpan(
                                text: 'PT Cifa Indonesia ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 12)),
                            TextSpan(
                              text: 'produces high quality',
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      const Text(
                        "dairy cow's milk with the unique name",
                        style: TextStyle(fontSize: 12),
                      ),
                      const Text(
                        "Susu Tarutung (Sutar) and mozzarella",
                        style: TextStyle(fontSize: 12),
                      ),
                      const Text(
                        "cheese with the unique name Mozarella",
                        style: TextStyle(fontSize: 12),
                      ),
                      const Text(
                        "Tarutung (Mozzataru).",
                        style: TextStyle(fontSize: 12),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("You can buy it here!"),
                      ElevatedButton(
                        style: raisedButtonstyle,
                        child: const Text("BUY NOW"),
                        onPressed: () {
                          Navigator.pushNamed(context, routeLogin);
                        },
                      ),
                    ],
                  )
                ],
              ),
              Image.asset(
                'assets/images/sepi.png',
                width: 115,
                height: 150,
              )
            ],
          ),
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: const Color(0xffE7F3FF),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  const Text(
                    "Products",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff585858),
                    ),
                  ),
                  Column(
                    children: [
                      CarouselSlider.builder(
                        options: CarouselOptions(
                            height: 250,
                            // autoPlay: true,
                            // reverse: true,
                            // viewportFraction: 1,
                            // pageSnapping: false,
                            enableInfiniteScroll: false,
                            enlargeCenterPage: true,
                            enlargeStrategy: CenterPageEnlargeStrategy.height,
                            autoPlayInterval: const Duration(
                              seconds: 2,
                            ),
                            onPageChanged: (index, reason) => {
                                  setState(() => activeIndex = index),
                                }),
                        itemCount: imageLists.length,
                        itemBuilder: (context, index, realIndex) {
                          final imageList = imageLists[index];
                          return buildImage(imageList, index);
                        },
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      buildIndicator(),
                      ElevatedButton(
                        style: raisedButtonstyle,
                        child: const Text("ORDER NOW"),
                        onPressed: () {
                          Navigator.pushNamed(context, routeLogin);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
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

  Widget buildImage(String urlImage, int index) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 40),
        child: Image.asset(
          urlImage,
          fit: BoxFit.cover,
        ),
      );

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: imageLists.length,
        effect: const JumpingDotEffect(
          dotWidth: 10,
          dotHeight: 10,
          activeDotColor: Color(0xffF8C83F),
          dotColor: Color(0xffE0E0E0),
        ),
      );
}
