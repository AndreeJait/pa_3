import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pa_3/api/rest_client.dart';
import 'package:pa_3/component/admin/ProductContainer/product_card.dart';
import 'package:pa_3/constans/preferences.dart';
import 'package:pa_3/constans/router_admin.dart';
import 'package:pa_3/model/product_stock.dart';
import 'package:pa_3/utils/view_models.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:singel_page_route/singel_page_route.dart';

class ProductAdminComponent extends StatefulWidget {
  ProductAdminComponent({Key? key}) : super(key: key);

  @override
  State<ProductAdminComponent> createState() => _ProductAdminComponentState();
}

class _ProductAdminComponentState extends State<ProductAdminComponent> {
  bool isVisible = false;
  List<ProductStock> products = ViewModels.getState("activeProducts");
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    print(products.length);
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
                    onPressed: () {
                      SingelPageRoute.pushName(routeFormProduct);
                    },
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
                    onPressed: () {
                      SingelPageRoute.pushName(routeFormProductStock);
                    },
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
                                      stock: e,
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
                              margin: const EdgeInsets.only(top: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () async {
                                      setState(() {
                                        isLoading = true;
                                      });
                                      ProductStock stock =
                                          ViewModels.getState("currentStock");
                                      final prefs =
                                          await SharedPreferences.getInstance();
                                      String token =
                                          prefs.getString(prefToken)!;
                                      String refresh =
                                          prefs.getString(prefRefresh)!;
                                      Dio dio = Dio();
                                      dio.options.headers["Authorization"] =
                                          "Bearer $token";
                                      final client = RestClient(dio);
                                      try {
                                        await client
                                            .deleteProductStock(stock.id!);
                                        List<ProductStock> old = [
                                          ...ViewModels.getState(
                                              "activeProducts")
                                        ];
                                        old.removeWhere((element) =>
                                            element.id == stock.id);
                                        ViewModels.ctrlState.sink.add([
                                          {
                                            "name": "activeProducts",
                                            "value": old
                                          }
                                        ]);
                                        setState(() {
                                          products = old;
                                        });
                                        changeVisibleModal(false);
                                      } on DioError catch (e) {
                                        Widget cancelButton = TextButton(
                                          child: Text("Cancel"),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        );
                                        String message = e.message;
                                        AlertDialog alert = AlertDialog(
                                          title: Text("AlertDialog"),
                                          content: Text(message),
                                          actions: [
                                            cancelButton,
                                          ],
                                        );

                                        // show the dialog
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return alert;
                                          },
                                        );
                                      }
                                      setState(() {
                                        isLoading = false;
                                      });
                                    },
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
                                    child: isLoading
                                        ? const CircularProgressIndicator()
                                        : const Text("Yes"),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      changeVisibleModal(false);
                                    },
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
                                    child: const Text("No"),
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
