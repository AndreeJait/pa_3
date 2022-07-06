import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pa_3/constans/router_consumer.dart';
import 'package:pa_3/model/order.dart';
import 'package:pa_3/model/product_stock.dart';
import 'package:pa_3/utils/view_models.dart';
import 'package:pa_3/constans/api.dart';
import 'package:singel_page_route/singel_page_route.dart';

class OrderConsumerComponent extends StatefulWidget {
  const OrderConsumerComponent({Key? key}) : super(key: key);

  @override
  State<OrderConsumerComponent> createState() => _OrderConsumerComponentState();
}

class _OrderConsumerComponentState extends State<OrderConsumerComponent> {
  ProductStock selectedStock = ViewModels.getState("selectedStock");
  final format = NumberFormat.simpleCurrency(locale: "IDR", decimalDigits: 2);
  List<List<Map<String, String>>> info = [];
  int selectedIndex = 0;
  int countIndex = -1;

  List<TextEditingController> controllers = [];

  @override
  void initState() {
    // TODO: implement initState

    selectedStock.product.variant.asMap().forEach((key, value) {
      controllers.add(TextEditingController());
      controllers[controllers.length - 1].text = "0";
      info.add([
        {"name": "Stock", "value": "${selectedStock.stock[key]}"},
        {"name": "Weight", "value": "${selectedStock.product.weight}"},
        {
          "name": "Expired Date",
          "value": DateFormat("yyyy-MM-dd").format(selectedStock.outDate)
        },
        {
          "name": "Storage Temperature",
          "value": "${selectedStock.product.temperatureStorage}"
        },
      ]);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: CarouselSlider.builder(
                  itemCount: selectedStock.product.variant.length,
                  itemBuilder: (context, index, realIndex) {
                    final imageList = selectedStock.product.variantImages[
                        selectedStock.product.variantIndex[index]];
                    final itemName = selectedStock.product.variant[index];
                    return buildProductCard(imageList, itemName, index);
                  },
                  options: CarouselOptions(
                    height: MediaQuery.of(context).size.height / 4,
                    enableInfiniteScroll: false,
                    enlargeCenterPage: true,
                    enlargeStrategy: CenterPageEnlargeStrategy.height,
                    autoPlayInterval: const Duration(seconds: 2),
                    onPageChanged: (index, reason) {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                  )),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${selectedStock.product.name} ( ${selectedStock.product.variant[selectedIndex]} )",
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(format.format(
                      selectedStock.product.priceVariant[selectedIndex]))
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...info[selectedIndex].map((e) => Wrap(
                        spacing: 20,
                        children: [
                          SizedBox(
                            width: 150,
                            child: Text(e["name"]!),
                          ),
                          Text(e["value"]!)
                        ],
                      ))
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  ...selectedStock.product.variantIndex
                      .asMap()
                      .map((key, value) => MapEntry(
                          key,
                          Container(
                            margin: const EdgeInsets.only(top: 20),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(
                                    "$baseUrlConstant/${selectedStock.product.variantImages[value]}",
                                    width: 80,
                                    height: 80,
                                  ),
                                ),
                                Expanded(
                                    child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ElevatedButton(
                                        style: ButtonStyle(
                                            padding: MaterialStateProperty.all(
                                                const EdgeInsets.symmetric(
                                                    horizontal: 0,
                                                    vertical: 0))),
                                        onPressed: () {
                                          if (controllers[key].text == "" ||
                                              controllers[key].text == "0") {
                                            controllers[key].text = "0";
                                          } else {
                                            controllers[key].text =
                                                "${int.parse(controllers[key].text) - 1}";
                                          }
                                        },
                                        child: const Text("-")),
                                    SizedBox(
                                      width: 50,
                                      height: 40,
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        controller: controllers[key],
                                        textAlign: TextAlign.center,
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          hintText: '0',
                                          contentPadding:
                                              const EdgeInsets.all(0),
                                          hintStyle: const TextStyle(
                                              color: Colors.black54),
                                        ),
                                      ),
                                    ),
                                    ElevatedButton(
                                        style: ButtonStyle(
                                            padding: MaterialStateProperty.all(
                                                const EdgeInsets.symmetric(
                                                    horizontal: 0,
                                                    vertical: 0))),
                                        onPressed: () {
                                          if (controllers[key].text == "" ||
                                              controllers[key].text == "0") {
                                            controllers[key].text = "1";
                                          } else {
                                            int current = int.parse(
                                                controllers[key].text);
                                            if (current <
                                                selectedStock.stock[key]) {
                                              controllers[key].text =
                                                  "${current + 1}";
                                            }
                                          }
                                        },
                                        child: const Text("+"))
                                  ],
                                ))
                              ],
                            ),
                          )))
                      .values
                      .toList()
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: ElevatedButton(
                  onPressed: () {
                    processOrder();
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 248, 200, 63))),
                  child: Column(
                    children: const [
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          "Pesanan",
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }

  void processOrder() {
    var doProcess = false;
    for (var element in controllers) {
      if (element.text != "0") {
        doProcess = true;
      }
    }
    if (doProcess) {
      List<int> quantities = controllers.map((e) => int.parse(e.text)).toList();
      double total = 0;
      quantities.asMap().forEach((key, value) {
        total += value * selectedStock.product.priceVariant[key];
      });
      OrderTemp temp =
          OrderTemp(total: total, quantity: quantities, stock: selectedStock);
      ViewModels.ctrlState.sink.add([
        {"name": "orderProcess", "value": temp}
      ]);
      SingelPageRoute.pushName(routeOrderForm);
    }
  }

  Widget buildProductCard(String urlImage, String itemName, int index) => Card(
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
