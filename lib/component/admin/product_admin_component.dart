import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pa_3/component/admin/ProductContainer/product_card.dart';
import 'package:pa_3/model/product.dart';

class ProductAdminComponent extends StatefulWidget {
  ProductAdminComponent({Key? key}) : super(key: key);

  @override
  State<ProductAdminComponent> createState() => _ProductAdminComponentState();
}

class _ProductAdminComponentState extends State<ProductAdminComponent> {
  bool isVisible = false;
  List<Product> products = [
    Product(
        id: "12314124",
        image: "https://picsum.photos/250?image=9",
        expiredDate: "11 Januari 2023",
        name: "Example Product",
        price: 17000,
        stock: 100,
        weight: 100),
    Product(
        id: "12314124",
        image: "https://picsum.photos/250?image=9",
        expiredDate: "11 Januari 2023",
        name: "Example Product",
        price: 17000,
        stock: 100,
        weight: 100),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  changeVisibleModal(bool value) {
    setState(() {
      isVisible = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Wrap(
              direction: Axis.horizontal,
              spacing: 20,
              children: [
                ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.blue[300]),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ))),
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 10,
                      children: const [
                        Text(
                          "Tambah Produk",
                          style: TextStyle(fontSize: 13),
                        ),
                        FaIcon(
                          FontAwesomeIcons.plus,
                          size: 15,
                        )
                      ],
                    )),
                ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.blue[300]),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ))),
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 10,
                      children: const [
                        Text(
                          "Tambah Stok Produk",
                          style: TextStyle(fontSize: 13),
                        ),
                        FaIcon(
                          FontAwesomeIcons.plus,
                          size: 15,
                        )
                      ],
                    ))
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                          top: 20,
                        ),
                        child: Column(
                          children: [
                            Wrap(
                              runSpacing: 20,
                              children: [
                                ...products.map((e) => CardProduct(
                                      product: e,
                                      changeVisible: changeVisibleModal,
                                    ))
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
        if (isVisible)
          GestureDetector(
            onTap: () {
              changeVisibleModal(false);
            },
            child: Container(
              width: double.infinity,
              color: const Color.fromARGB(118, 0, 0, 0),
              child: Center(
                child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 20),
                      padding: const EdgeInsets.all(30),
                      child: Wrap(
                          direction: Axis.horizontal,
                          spacing: 20,
                          alignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            const Text("Delete Product"),
                            const Text(
                                "Are you sure want to remove this product ?"),
                            Container(
                              margin: EdgeInsets.only(top: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {},
                                    child: Text("Yes"),
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.red),
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                        ))),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      changeVisibleModal(false);
                                    },
                                    child: Text("No"),
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.blue[300]),
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                        ))),
                                  )
                                ],
                              ),
                            )
                          ]),
                    )),
              ),
            ),
          )
      ],
    );
  }
}
