import 'package:flutter/material.dart';

import 'package:pa_3/constans/router_marketing.dart';
import 'package:pa_3/model/Product.dart';
import 'package:pa_3/model/Order.dart';

class HomeMarketingComponent extends StatefulWidget {
  const HomeMarketingComponent({Key? key}) : super(key: key);

  @override
  State<HomeMarketingComponent> createState() => _HomeMarketingComponentState();
}

class _HomeMarketingComponentState extends State<HomeMarketingComponent> {
  var foundOrders = orders;
  int _selectedPage = 0;
  PageController _pageController = PageController();
  Product findProduct(id) => products.firstWhere((product) => product.id == id);

  void _changePage(int pageNum) {
    setState(() {
      _selectedPage = pageNum;
      _pageController.animateToPage(pageNum,
          duration: const Duration(milliseconds: 500),
          curve: Curves.fastLinearToSlowEaseIn);
    });
  }

  void findOrder(String status) {
    setState(() {
      foundOrders = orders.where((order) => order.status == status).toList();
    });
  }

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TabButton(
                  title: "Ordered",
                  pageNumber: 0,
                  selectedPage: _selectedPage,
                  onPressed: () {
                    _changePage(0);
                  },
                ),
                TabButton(
                  title: "History",
                  pageNumber: 1,
                  selectedPage: _selectedPage,
                  onPressed: () {
                    _changePage(1);
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _selectedPage = page;
                });
              },
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                    itemCount: foundOrders.length,
                    itemBuilder: (context, index) {
                      return Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              border: Border.all(
                                color: const Color(0xffE0E0E0),
                                width: 2,
                              )),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(foundOrders[index].buyer),
                                  Text(
                                    foundOrders[index].status,
                                    style: const TextStyle(color: Colors.green),
                                  )
                                ],
                              ),
                              const Divider(
                                height: 30,
                              ),
                              Row(
                                children: [
                                  ConstrainedBox(
                                    constraints: const BoxConstraints(
                                      minWidth: 64,
                                      minHeight: 64,
                                      maxWidth: 84,
                                      maxHeight: 84,
                                    ),
                                    child: Image.asset(
                                        foundOrders[index].imageUrl,
                                        fit: BoxFit.cover),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(findProduct(foundOrders[index]
                                              .products
                                              .toString())
                                          .name),
                                      // findProduct(orders[index].products.toString()).name
                                      // findProduct(foundOrders[index].products.toString()).name
                                      Text(
                                        'Quantity: ${foundOrders[index].quantity}',
                                      ),
                                      Text(
                                        'Total Payment: ${foundOrders[index].totalPayment}',
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ElevatedButton(
                                    style: raisedButtonstyle,
                                    child: const Text("Update Status"),
                                    onPressed: () {
                                      Navigator.pushNamed(context, routeAbout);
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ));
                    },
                  ),
                ),
                ListView.builder(
                  itemCount: foundOrders.length,
                  itemBuilder: (context, index) {
                    return Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            border: Border.all(
                              color: const Color(0xffE0E0E0),
                              width: 2,
                            )),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(foundOrders[index].buyer),
                                Text(
                                  foundOrders[index].status,
                                  style: const TextStyle(color: Colors.green),
                                )
                              ],
                            ),
                            const Divider(
                              height: 30,
                            ),
                            Row(
                              children: [
                                ConstrainedBox(
                                  constraints: const BoxConstraints(
                                    minWidth: 64,
                                    minHeight: 64,
                                    maxWidth: 84,
                                    maxHeight: 84,
                                  ),
                                  child: Image.asset(
                                      foundOrders[index].imageUrl,
                                      fit: BoxFit.cover),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(findProduct(foundOrders[index]
                                            .products
                                            .toString())
                                        .name),
                                    // findProduct(orders[index].products.toString()).name
                                    // findProduct(foundOrders[index].products.toString()).name
                                    Text(
                                      'Quantity: ${foundOrders[index].quantity}',
                                    ),
                                    Text(
                                      'Total Payment: ${foundOrders[index].totalPayment}',
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                  style: raisedButtonstyle,
                                  child: const Text("Update Status"),
                                  onPressed: () {
                                    Navigator.pushNamed(context, routeAbout);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ));
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class TabButton extends StatelessWidget {
  final String title;
  final int selectedPage;
  final int pageNumber;
  final VoidCallback onPressed;

  const TabButton(
      {Key? key,
      required this.title,
      required this.selectedPage,
      required this.pageNumber,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 1000),
        curve: Curves.fastLinearToSlowEaseIn,
        decoration: BoxDecoration(
          color: selectedPage == pageNumber
              ? const Color(0xffF8C83F)
              : const Color(0xffF0F0F0),
          borderRadius: BorderRadius.circular(100),
        ),
        padding: EdgeInsets.symmetric(
          vertical: selectedPage == pageNumber ? 12.0 : 6.0,
          horizontal: selectedPage == pageNumber ? 20.0 : 10.0,
        ),
        margin: EdgeInsets.symmetric(
          vertical: selectedPage == pageNumber ? 6.0 : 12.0,
          horizontal: selectedPage == pageNumber ? 10.0 : 20.0,
        ),
        child: Text(
          title,
          style: TextStyle(
            color: selectedPage == pageNumber
                ? Colors.white
                : const Color(0xff585858),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
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
