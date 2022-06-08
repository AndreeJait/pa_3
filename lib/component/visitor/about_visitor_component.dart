import 'package:flutter/material.dart';

import 'package:pa_3/utils/strings.dart';

import 'package:carousel_slider/carousel_slider.dart';

class AboutVisitorComponent extends StatelessWidget {
  const AboutVisitorComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final users = [
      Strings.aboutPageTestimonialUsers,
      Strings.aboutPageTestimonialUsers,
      Strings.aboutPageTestimonialUsers,
    ];
    final testimonials = [
      Strings.aboutPageTestimony,
      Strings.aboutPageTestimony,
      Strings.aboutPageTestimony
    ];

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              decoration: BoxDecoration(
                  color: const Color(0xffE7F3FF),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  const Text(Strings.aboutPageWhyUs),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/male.png',
                        width: 80,
                        height: 200,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          aboutList(Strings.aboutPageAboutList1),
                          aboutList(Strings.aboutPageAboutList2),
                          aboutList(Strings.aboutPageAboutList3),
                          aboutList(Strings.aboutPageAboutList4),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                  top: 20, bottom: 20, right: 10, left: 10),
              margin: const EdgeInsets.only(top: 30),
              decoration: BoxDecoration(
                  color: const Color(0xffE7F3FF),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  const Text(
                    Strings.aboutPageTestimonies,
                    style: TextStyle(
                        fontSize: 20,
                        color: Color(0xff585858),
                        fontWeight: FontWeight.bold),
                  ),
                  textList(Strings.aboutPageDescription),
                  Wrap(
                    spacing: 10,
                    children: [
                      CarouselSlider.builder(
                        options: CarouselOptions(
                          height: 190,
                          autoPlay: true,
                          enableInfiniteScroll: true,
                          enlargeCenterPage: true,
                          enlargeStrategy: CenterPageEnlargeStrategy.height,
                          autoPlayInterval: const Duration(
                            seconds: 4,
                          ),
                        ),
                        itemCount: users.length,
                        itemBuilder: (context, index, realIndex) {
                          final user = users[index];
                          final testimonial = testimonials[index];
                          return buildTestimonials(user, testimonial, index);
                        },
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget textList(String text) => Text(
        text,
        maxLines: 3,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 11, color: Color(0xff585858)),
      );

  Widget aboutList(String text) => Row(
        children: [
          Image.asset(
            'assets/images/check.png',
            width: 40,
            height: 40,
          ),
          textList(text),
        ],
      );

  Widget buildTestimonials(String user, String testimonial, int index) =>
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        height: 50,
        child: Container(
          margin: const EdgeInsets.only(top: 10),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
              color: const Color(0xffFFFBE7),
              borderRadius: BorderRadius.circular(10)),
          child: Wrap(
            alignment: WrapAlignment.center,
            children: [
              Text(user),
              const SizedBox(
                height: 10,
              ),
              textList(testimonial),
              Image.asset(
                'assets/images/testimonial.png',
                fit: BoxFit.cover,
              )
            ],
          ),
        ),
      );
}
