import 'package:flutter/material.dart';

import 'package:pa_3/constans/router_consumer.dart';
import 'package:pa_3/model/Product.dart';
import 'package:pa_3/model/Order.dart';

class PurchaseConsumerComponent extends StatefulWidget {
  const PurchaseConsumerComponent({Key? key}) : super(key: key);

  @override
  State<PurchaseConsumerComponent> createState() =>
      _PurchaseConsumerComponentState();
}

class _PurchaseConsumerComponentState extends State<PurchaseConsumerComponent> {
  Product findProduct(id) => products.firstWhere((product) => product.id == id);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Wrap(
          spacing: 10,
          children: [
            const Text(
              "Purchases",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xff585858),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200, mainAxisSpacing: 50),
                itemCount: orders.length,
                itemBuilder: (BuildContext ctx, index) {
                  return Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 10,
                      children: [
                        Image.asset(
                          orders[index].imageUrl,
                          width: MediaQuery.of(context).size.width / 4,
                          height: MediaQuery.of(context).size.height / 5.5,
                        ),
                        Text(findProduct(orders[index].products.toString())
                            .name),
                        ElevatedButton(
                          style: raisedButtonstyle,
                          child: Text(orders[index].status),
                          onPressed: () {
                            Navigator.pushNamed(context, routeProduct);
                          },
                        ),
                      ],
                    ),
                  );
                },
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
}
