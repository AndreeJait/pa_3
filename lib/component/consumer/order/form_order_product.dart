import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:pa_3/api/request/order_request.dart';
import 'package:pa_3/api/rest_client.dart';
import 'package:pa_3/constans/api.dart';
import 'package:pa_3/constans/preferences.dart';
import 'package:pa_3/constans/router_consumer.dart';
import 'package:pa_3/model/order.dart';
import 'package:pa_3/utils/view_models.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:singel_page_route/singel_page_route.dart';

class FormOrderProduct extends StatefulWidget {
  const FormOrderProduct({Key? key}) : super(key: key);

  @override
  State<FormOrderProduct> createState() => _FormOrderProductState();
}

class _FormOrderProductState extends State<FormOrderProduct> {
  OrderTemp orderTemp = ViewModels.getState("orderProcess");
  String sentOption = SENT_AMBIL_DITEMPAT;
  String paymentMethod = PAYMENT_TRANSFER;
  int additional = 0;
  bool isLoading = false;
  bool isEditable = true;
  StreamSubscription? subscription;
  final formatCurrency =
      NumberFormat.simpleCurrency(locale: "IDR", decimalDigits: 2);
  var controllerAddress = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    ViewModels.ctrlState.sink.add([
      {"name": "paymentMethod", "value": PAYMENT_TRANSFER},
      {"name": "sentOption", "value": SENT_AMBIL_DITEMPAT},
    ]);
    subscription = ViewModels.stateStream.listen((event) {
      setState(() {
        var foundIndex =
            event.indexWhere((element) => element["name"] == "sentOption");
        if (foundIndex != -1) {
          setState(() {
            sentOption = event[foundIndex]["value"];
            additional = sentOption == SENT_DIKIRIM ? shippingCost : 0;
            if (sentOption == SENT_DIKIRIM &&
                paymentMethod == PAYMENT_BAYAR_DITEMPAT) {
              paymentMethod = PAYMENT_TRANSFER;
            }
          });
        }

        foundIndex =
            event.indexWhere((element) => element["name"] == "paymentMethod");
        if (foundIndex != -1) {
          setState(() {
            paymentMethod = event[foundIndex]["value"];
          });
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    if (subscription != null) {
      subscription!.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          Container(
            color: const Color.fromARGB(61, 196, 196, 196),
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Products"),
                ...orderTemp.quantity
                    .asMap()
                    .map((key, value) {
                      if (value > 0) {
                        return MapEntry(
                          key,
                          Container(
                              margin: const EdgeInsets.only(top: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network(
                                    "$baseUrlConstant/${orderTemp.stock.product.variantImages[orderTemp.stock.product.variantIndex[key]]}",
                                    width: 80,
                                    height: 80,
                                  ),
                                  Expanded(
                                      child: Row(
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              "${orderTemp.stock.product.name} (${orderTemp.stock.product.variant[key]})"),
                                          Text(
                                              "Quantity: ${orderTemp.quantity[key]}"),
                                          Container(
                                              margin: const EdgeInsets.only(
                                                  top: 10),
                                              child: Text(formatCurrency.format(
                                                orderTemp.stock.product
                                                    .priceVariant[key],
                                              )))
                                        ],
                                      )
                                    ],
                                  ))
                                ],
                              )),
                        );
                      }
                      return MapEntry(key, Container());
                    })
                    .values
                    .toList()
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    "Total Pemesanan (${orderTemp.quantity.where((element) => element > 0).length} Produk)"),
                Text(formatCurrency.format(orderTemp.total))
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            decoration: const BoxDecoration(
                border: Border.symmetric(
                    horizontal: BorderSide(
                        color: Colors.grey,
                        width: 1,
                        style: BorderStyle.solid))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Opsi Pengiriman",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () {
                    if (isEditable) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return SentOptional();
                          });
                    }
                  },
                  child: Text(
                    "$sentOption > ",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            decoration: const BoxDecoration(
                border: Border.symmetric(
                    horizontal: BorderSide(
                        color: Colors.grey,
                        width: 1,
                        style: BorderStyle.solid))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Metode Pembayaran",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () {
                    if (isEditable) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return PaymentOption();
                          });
                    }
                  },
                  child: Text(
                    "$paymentMethod > ",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
          if (sentOption == SENT_DIKIRIM)
            Container(
              margin: const EdgeInsets.only(top: 20),
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: TextFormField(
                enabled: isEditable,
                controller: controllerAddress,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                textAlignVertical: TextAlignVertical.center,
                decoration: const InputDecoration(
                  // border: OutlineInputBorder(
                  //   borderRadius: BorderRadius.circular(10),
                  // ),
                  hintText: 'Masukkan alamat disini',
                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                  hintStyle: const TextStyle(color: Colors.black54),
                ),
              ),
            ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Wrap(
              runSpacing: 20,
              children: [
                buildInfoBottom(
                    "Subtotal", formatCurrency.format(orderTemp.total), null),
                if (sentOption == SENT_DIKIRIM)
                  buildInfoBottom("Biaya Penanganan",
                      formatCurrency.format(shippingCost), null),
                buildInfoBottom(
                    "Total Pembayaran",
                    formatCurrency.format(orderTemp.total + additional),
                    TextStyle(fontWeight: FontWeight.bold))
              ],
            ),
          ),
          ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      const Color.fromARGB(255, 248, 200, 63))),
              onPressed: () async {
                if (!isLoading) {
                  setState(() {
                    isLoading = true;
                    isEditable = false;
                  });
                  await processOrder();
                  setState(() {
                    isLoading = false;
                    isEditable = true;
                  });
                }
              },
              child: Container(
                width: MediaQuery.of(context).size.width / 2,
                child: Column(
                  children: [
                    isLoading
                        ? const CircularProgressIndicator()
                        : const Text("Continue To Payment")
                  ],
                ),
              ))
        ],
      ),
    );
  }

  Future<void> processOrder() async {
    if (sentOption == SENT_DIKIRIM && controllerAddress.text == "") {
      Widget continueButton = TextButton(
        child: Text("Ok"),
        onPressed: () {
          setState(() {
            Navigator.of(context).pop();
          });
        },
      );
      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: Text("Alamat kosong"),
        content: Text("Alamat tidak boleh kosong"),
        actions: [
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
    } else {
      try {
        final prefs = await SharedPreferences.getInstance();
        String token = prefs.getString(prefToken)!;
        String refresh = prefs.getString(prefRefresh)!;
        Dio dio = Dio();
        dio.options.headers["Authorization"] = "Bearer $token";
        final client = RestClient(dio);

        List<int> tempQuantity = [];
        List<String> tempVariant = [];

        orderTemp.quantity.asMap().forEach((key, value) {
          if (value > 0) {
            tempQuantity.add(value);
            tempVariant.add(orderTemp.stock.product.variant[key]);
          }
        });
        var request = OrderNewRequest(
            paymentMethod: paymentMethod,
            quantity: tempQuantity,
            sentOption: sentOption,
            address: controllerAddress.text,
            status: "unpaid",
            stock: orderTemp.stock.id!,
            total: orderTemp.total + additional,
            user: ViewModels.getState("user").id,
            variant: tempVariant);

        var response = await client.createAllOrder(request);
        List<Order> orders = [...ViewModels.getState("myOrders")];
        orders.add(response.data);
        ViewModels.ctrlState.sink.add([
          {"name": "myOrders", "value": orders},
          {"name": "selectedOrder", "value": response.data}
        ]);

        Widget continueButton = TextButton(
          child: Text("Ok"),
          onPressed: () {
            setState(() {
              Navigator.of(context).pop();
              SingelPageRoute.pushAndReplaceName(routePayment);
            });
          },
        );
        // set up the AlertDialog
        AlertDialog alert = AlertDialog(
          title: Text("Success to order"),
          content: Text("Berhasil membuat pesanan segera bayar"),
          actions: [
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
            await processOrder();
            setState(() {
              isLoading = false;
              isEditable = true;
            });
          },
        );
        String message = e.message;
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
  }

  Widget buildInfoBottom(String name, String value, TextStyle? textStyle) =>
      SizedBox(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(name),
            Text(
              value,
              style: textStyle,
            )
          ],
        ),
      );
}

class SentOptional extends StatefulWidget {
  SentOptional({Key? key}) : super(key: key);

  @override
  State<SentOptional> createState() => _SentOptionalState();
}

class _SentOptionalState extends State<SentOptional> {
  List<Map<String, String>> sentOptions = [
    {
      "name": SENT_AMBIL_DITEMPAT,
      "description":
          "Pengambilan produk akan datang kedalam notifikasi Anda bahwa produk sudah dapat diambil ke peternakan."
    },
    {
      "name": SENT_DIKIRIM,
      "description":
          "(Tarutung sekitar dan optional) \n\nPengantaran produk akan datang kedalam notifikasi Anda bahwa produk akan diantar kepada lokasi tujuan. \n\nOngkos kirim ${NumberFormat.simpleCurrency(locale: "IDR", decimalDigits: 2).format(shippingCost)}"
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Opsi Pengiriman",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const FaIcon(FontAwesomeIcons.x),
                )
              ],
            ),
          ),
          ...sentOptions.map((e) => GestureDetector(
                onTap: () {
                  ViewModels.ctrlState.sink.add([
                    {"name": "sentOption", "value": e["name"]}
                  ]);
                  Navigator.pop(context);
                },
                child: Container(
                  color: const Color.fromARGB(62, 196, 196, 196),
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  margin: const EdgeInsets.only(top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        e["name"]!,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(e["description"]!)
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }
}

class PaymentOption extends StatefulWidget {
  PaymentOption({Key? key}) : super(key: key);

  @override
  State<PaymentOption> createState() => _PaymentOptionState();
}

class _PaymentOptionState extends State<PaymentOption> {
  List<Map<String, String>> sentOptions = [
    {
      "name": PAYMENT_BAYAR_DITEMPAT,
      "description":
          "Pengambilan produk akan datang kedalam notifikasi Anda bahwa produk sudah dapat diambil ke peternakan."
    },
    {
      "name": PAYMENT_TRANSFER,
      "description":
          "(Tarutung sekitar dan optional) \n\nPengantaran produk akan datang kedalam notifikasi Anda bahwa produk akan diantar kepada lokasi tujuan. \n\nOngkos kirim ${NumberFormat.simpleCurrency(locale: "IDR", decimalDigits: 2).format(shippingCost)}"
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Opsi Pembayaran",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const FaIcon(FontAwesomeIcons.x),
                )
              ],
            ),
          ),
          ...sentOptions.map((e) {
            if (e["name"]! != "Bayar ditempat") {
              return GestureDetector(
                onTap: () {
                  ViewModels.ctrlState.sink.add([
                    {"name": "paymentMethod", "value": e["name"]}
                  ]);
                  Navigator.pop(context);
                },
                child: Container(
                  color: const Color.fromARGB(62, 196, 196, 196),
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  margin: const EdgeInsets.only(top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        e["name"]!,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(e["description"]!)
                    ],
                  ),
                ),
              );
            } else if (ViewModels.getState("sentOption") != SENT_DIKIRIM) {
              return GestureDetector(
                onTap: () {
                  ViewModels.ctrlState.sink.add([
                    {"name": "paymentMethod", "value": e["name"]}
                  ]);
                  Navigator.pop(context);
                },
                child: Container(
                  color: const Color.fromARGB(62, 196, 196, 196),
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  margin: const EdgeInsets.only(top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        e["name"]!,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(e["description"]!)
                    ],
                  ),
                ),
              );
            }
            return Container();
          })
        ],
      ),
    );
  }
}
