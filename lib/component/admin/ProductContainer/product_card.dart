import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:pa_3/component/admin/ProductContainer/list_detail_product.dart';
import 'package:pa_3/constans/api.dart';
import 'package:pa_3/model/product.dart';
import 'package:pa_3/model/product_stock.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CardProduct extends StatefulWidget {
  ProductStock stock;
  Function changeVisible;
  CardProduct({Key? key, required this.stock, required this.changeVisible})
      : super(key: key);

  @override
  State<CardProduct> createState() => _CardProductState();
}

class _CardProductState extends State<CardProduct> {
  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CarouselSlider.builder(
                  options: CarouselOptions(
                    height: MediaQuery.of(context).size.height / 4,
                    enableInfiniteScroll: false,
                    enlargeCenterPage: true,
                    enlargeStrategy: CenterPageEnlargeStrategy.height,
                    autoPlayInterval: const Duration(seconds: 2),
                    onPageChanged: (index, reason) {
                      setState(() {
                        activeIndex = index;
                      });
                    },
                  ),
                  itemCount: widget.stock.product.variant.length,
                  itemBuilder: (context, index, realIndex) {
                    final imageList = widget.stock.product.variantImages[
                        widget.stock.product.variantIndex[index]];
                    final itemName = widget.stock.product.variant[index];
                    return buildproductCard(imageList, itemName, index);
                  },
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                      color: Colors.indigo[100],
                      borderRadius: const BorderRadius.all(Radius.circular(5))),
                  child: Text(widget.stock.product.name),
                )
              ],
            ),
          ),
          ListDetailProduct(
              value:
                  NumberFormat.simpleCurrency(locale: "IDR", decimalDigits: 2)
                      .format(widget.stock.product.priceVariant[activeIndex]),
              name: "Price"),
          ListDetailProduct(
              value: widget.stock.stock[activeIndex].toString(), name: "Stock"),
          ListDetailProduct(
              value: widget.stock.product.weight.toString(), name: "Weight"),
          ListDetailProduct(
              value:
                  "${widget.stock.outDate.day}-${widget.stock.outDate.month}-${widget.stock.outDate.year}",
              name: "Expired Date"),
          Container(
            margin: const EdgeInsets.only(top: 20),
            width: double.infinity,
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.end,
              alignment: WrapAlignment.end,
              runAlignment: WrapAlignment.end,
              spacing: 10,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.yellow[700]),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ))),
                  child: const FaIcon(
                    FontAwesomeIcons.penToSquare,
                    size: 20,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    widget.changeVisible(true);
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ))),
                  child: const FaIcon(
                    FontAwesomeIcons.trash,
                    size: 20,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: widget.stock.product.variant.length,
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
            child: Image.network(
              "$baseUrlConstant/$urlImage",
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
              height: 20,
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
