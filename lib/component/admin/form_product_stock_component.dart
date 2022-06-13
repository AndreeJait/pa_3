import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:pa_3/api/request/product_request.dart';
import 'package:pa_3/api/rest_client.dart';
import 'package:pa_3/constans/api.dart';
import 'package:pa_3/constans/preferences.dart';
import 'package:pa_3/model/product.dart';
import 'package:pa_3/model/product_stock.dart';
import 'package:pa_3/utils/view_models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FormProductStock extends StatefulWidget {
  FormProductStock({Key? key}) : super(key: key);

  @override
  State<FormProductStock> createState() => _FormProductStockState();
}

class _FormProductStockState extends State<FormProductStock> {
  List<Product> products = [...ViewModels.getState("products")];
  Product selectedProduct = ViewModels.getState("products")[0];
  List<TextEditingController> editingControllers = [
    ...ViewModels.getState("products")[0]
        .variant
        .map((e) => TextEditingController())
  ];
  final GlobalKey<FormState> _formKey = GlobalKey();

  DateTime selectedDate = DateTime.now();
  DateTime outDate = DateTime.now();
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(products.length);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
          key: _formKey,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: DropdownButton<Product>(
                    isExpanded: true,
                    itemHeight: 80,
                    value: selectedProduct,
                    items: [
                      ...products.map((e) => DropdownMenuItem(
                            value: e,
                            child: Row(
                              children: [
                                Image.network(
                                  "$baseUrlConstant/${e.variantImages[0]}",
                                  width: 50,
                                  height: 50,
                                ),
                                Expanded(
                                    child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(e.name),
                                  ],
                                ))
                              ],
                            ),
                          ))
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          editingControllers = [
                            ...value.variant.map((e) => TextEditingController())
                          ];
                          selectedProduct = value;
                        });
                      }
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: Column(
                    children: [
                      ...editingControllers
                          .asMap()
                          .map((key, value) => MapEntry(
                              key,
                              Container(
                                width: double.infinity,
                                margin: EdgeInsets.only(bottom: 10),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        "$baseUrlConstant/${selectedProduct.variantImages[key]}",
                                        width: 80,
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 10),
                                      child: Column(
                                        children: [
                                          Text(
                                            selectedProduct.variant[key],
                                            style: TextStyle(fontSize: 18),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    if (value.text.isNotEmpty) {
                                                      int current =
                                                          int.parse(value.text);
                                                      if (current > 0) {
                                                        setState(() {
                                                          value.text =
                                                              (current - 1)
                                                                  .toString();
                                                        });
                                                      }
                                                    } else {
                                                      setState(() {
                                                        value.text = "0";
                                                      });
                                                    }
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors.blue,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    width: 40,
                                                    height: 30,
                                                    child: const Center(
                                                        child: FaIcon(
                                                      FontAwesomeIcons.minus,
                                                      color: Colors.white,
                                                    )),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 100,
                                                  child: TextFormField(
                                                    validator: (value) {
                                                      if (value!.isEmpty) {
                                                        return "Stock tidak boleh kosong";
                                                      }
                                                      return null;
                                                    },
                                                    keyboardType:
                                                        TextInputType.number,
                                                    textAlign: TextAlign.center,
                                                    decoration:
                                                        const InputDecoration(
                                                            hintText: "0",
                                                            border: InputBorder
                                                                .none,
                                                            contentPadding:
                                                                EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            5,
                                                                        vertical:
                                                                            5)),
                                                    controller: value,
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    if (value.text.isNotEmpty) {
                                                      int current =
                                                          int.parse(value.text);
                                                      setState(() {
                                                        value.text =
                                                            (current + 1)
                                                                .toString();
                                                      });
                                                    } else {
                                                      setState(() {
                                                        value.text = "1";
                                                      });
                                                    }
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors.blue,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    width: 40,
                                                    height: 30,
                                                    child: const Center(
                                                        child: FaIcon(
                                                      FontAwesomeIcons.plus,
                                                      color: Colors.white,
                                                    )),
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )))
                          .values
                          .toList()
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        "Tanggal Jual",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                      Text(DateFormat("dd-MM-yyyy").format(selectedDate)),
                      ElevatedButton(
                          onPressed: () async {
                            final picked = await showDatePicker(
                                context: context,
                                initialDate: selectedDate,
                                firstDate: DateTime(DateTime.now().year,
                                    DateTime.now().month - 5),
                                lastDate: DateTime(DateTime.now().year + 3));
                            if (picked != null) {
                              setState(() {
                                selectedDate = picked;
                              });
                            }
                          },
                          child: const FaIcon(FontAwesomeIcons.calendar))
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 20, bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        "Tanggal Kadaluarsa",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                      Text(DateFormat("dd-MM-yyyy").format(outDate)),
                      ElevatedButton(
                          onPressed: () async {
                            final picked = await showDatePicker(
                                context: context,
                                initialDate: selectedDate,
                                firstDate: DateTime(DateTime.now().year,
                                    DateTime.now().month - 5),
                                lastDate: DateTime(DateTime.now().year + 3));
                            if (picked != null) {
                              setState(() {
                                outDate = picked;
                              });
                            }
                          },
                          child: const FaIcon(FontAwesomeIcons.calendar))
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.green[400])),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await createNewStockProduct();
                            setState(() {
                              isLoading = false;
                            });
                          }
                        },
                        child: isLoading
                            ? CircularProgressIndicator()
                            : Wrap(
                                spacing: 20,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: const [
                                  Text("Tambahkan Stock"),
                                  FaIcon(FontAwesomeIcons.plus)
                                ],
                              ))
                  ],
                )
              ],
            ),
          )),
    );
  }

  Future<void> createNewStockProduct() async {
    setState(() {
      isLoading = true;
    });
    try {
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString(prefToken)!;
      String refresh = prefs.getString(prefRefresh)!;
      Dio dio = Dio();
      dio.options.headers["Authorization"] = "Bearer $token";
      final client = RestClient(dio);
      var formatter = DateFormat("yyyy-MM-dd");
      List<int> stock = [...editingControllers.map((e) => int.parse(e.text))];
      ProductStockRequest request = ProductStockRequest(
          outDate: formatter.format(outDate),
          stock: stock,
          product: selectedProduct.id!,
          saleDate: formatter.format(selectedDate));
      var response = await client.createProductStock(request);
      List<ProductStock> products = [...ViewModels.getState("activeProducts")];
      products.add(response.data);
      ViewModels.ctrlState.sink.add([
        {"name": "activeProducts", "value": products}
      ]);
      Widget continueButton = TextButton(
        child: Text("Ok"),
        onPressed: () {
          setState(() {
            clearForm();
            Navigator.of(context).pop();
          });
        },
      );
      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: Text("Success to create"),
        content: Text("Berhasil menambahkan ${response.data.product.name}"),
        actions: [
          continueButton,
        ],
      );
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    } on DioError catch (e) {
      Widget cancelButton = TextButton(
        child: Text("Cancel"),
        onPressed: () {
          Navigator.of(context).pop();
        },
      );
      Widget continueButton = TextButton(
        child: Text("Try Again"),
        onPressed: () async {
          Navigator.of(context).pop();
          await createNewStockProduct();
          setState(() {
            isLoading = false;
          });
        },
      );
      String message = e.message;
      if (e.response!.statusCode == 400) {
        message = "Nama produk sudah ada atau ada field kosong";
      }

      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: Text("AlertDialog"),
        content: Text(message),
        actions: [
          cancelButton,
          continueButton,
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
  }

  void clearForm() {
    setState(() {
      editingControllers.forEach((element) {
        element.text = "";
      });
    });
  }
}
