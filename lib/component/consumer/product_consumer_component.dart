import 'package:flutter/material.dart';
import 'package:pa_3/component/admin/ContainerDashboard/header_dashboard.dart';
import 'package:pa_3/component/consumer/product/product_card.dart';
import 'package:pa_3/model/product_stock.dart';
import 'package:pa_3/utils/view_models.dart';

class ProductConsumerComponent extends StatefulWidget {
  const ProductConsumerComponent({Key? key}) : super(key: key);

  @override
  State<ProductConsumerComponent> createState() =>
      _ProductConsumerComponentState();
}

class _ProductConsumerComponentState extends State<ProductConsumerComponent> {
  List<ProductStock> stocks = ViewModels.getState("activeProducts");
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          const HeaderDashboard(),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: const Text(
              "Products",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
              child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              margin: const EdgeInsets.only(top: 10),
              child: Column(
                children: [...stocks.map((e) => CardProduct(stock: e))],
              ),
            ),
          ))
        ],
      ),
    );
  }
}
