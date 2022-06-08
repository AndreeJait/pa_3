import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pa_3/component/admin/ProductContainer/list_detail_product.dart';
import 'package:pa_3/model/product.dart';

class CardProduct extends StatelessWidget {
  Product product;
  Function changeVisible;
  CardProduct({Key? key, required this.product, required this.changeVisible})
      : super(key: key);

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
            margin: EdgeInsets.only(bottom: 20),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  product.image,
                  height: 100,
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                      color: Colors.indigo[100],
                      borderRadius: const BorderRadius.all(Radius.circular(5))),
                  child: Text(product.name),
                )
              ],
            ),
          ),
          ListDetailProduct(value: product.price.toString(), name: "Price"),
          ListDetailProduct(value: product.stock.toString(), name: "Stock"),
          ListDetailProduct(value: product.weight.toString(), name: "Weight"),
          ListDetailProduct(value: product.expiredDate, name: "Expired Date"),
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
                  child: const FaIcon(
                    FontAwesomeIcons.penToSquare,
                    size: 20,
                  ),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.yellow[700]),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ))),
                ),
                ElevatedButton(
                  onPressed: () {
                    changeVisible(true);
                  },
                  child: const FaIcon(
                    FontAwesomeIcons.trash,
                    size: 20,
                  ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ))),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
