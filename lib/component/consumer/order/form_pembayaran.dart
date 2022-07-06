import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:pa_3/api/request/order_request.dart';
import 'package:pa_3/api/response/order_response.dart';
import 'package:pa_3/api/rest_client.dart';
import 'package:pa_3/constans/api.dart';
import 'package:pa_3/constans/preferences.dart';
import 'package:pa_3/constans/router_consumer.dart';
import 'package:pa_3/model/order.dart';
import 'package:pa_3/utils/view_models.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:singel_page_route/singel_page_route.dart';

class FormPembayaran extends StatefulWidget {
  const FormPembayaran({Key? key}) : super(key: key);

  @override
  State<FormPembayaran> createState() => _FormPembayaranState();
}

class _FormPembayaranState extends State<FormPembayaran> {
  Order order = ViewModels.getState("selectedOrder");
  bool isLoading = false;
  final ImagePicker _picker = ImagePicker();
  XFile? proof;
  Map<String, String> tutorial = {
    PAYMENT_BAYAR_DITEMPAT:
        "Metode bayar ditempat:\n 1. Pihak marketing telah sampai di tempat dan produk telah sampai kepada pelanggan\n2. Lakukan pembayaran kepada marketing sesuai nominal pesanan",
    PAYMENT_TRANSFER:
        "Metode pembayara\nVia Atm\n1. Pilih bahasa\n2. Masukkan sandi\n3. Pilih jenis\n transaksi yaitu transfer\n4. Pilih bank tujuan (bank bri) \n5. Masukkan kode bank dan no rekening (002-1234-1234-1324-1235)\n6. Isikan nominal pembayaran \n7. Jika nominal dan tujuan yang ditampilkan benar klik benar"
  };
  final formatCurrency =
      NumberFormat.simpleCurrency(locale: "IDR", decimalDigits: 2);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: const Text(
              "Pembayran",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Total Pembayaran"),
                Text(formatCurrency.format(order.total)),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20, bottom: 20),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            decoration: const BoxDecoration(
                border: Border.symmetric(
                    horizontal: BorderSide(
                        color: Colors.grey,
                        width: 1,
                        style: BorderStyle.solid))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                    child: Text(
                  "Bayar sebelum tanggal ${DateFormat("yyyy-MM-dd HH:mm").format(order.expiredAt!)} dengan metode pembayaran '${order.paymentMethod}'",
                  softWrap: true,
                )),
              ],
            ),
          ),
          if (order.paymentMethod == PAYMENT_TRANSFER)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  color: Colors.blue[300],
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Transfer Bank \n\n1234 - 1234 -1324 - 1235\n\nA.N Nama Pemilik Bak",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          Container(
            margin: const EdgeInsets.only(top: 20, bottom: 20),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue, width: 1),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: const Text(
                      "Cara Pembayaran",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Text(tutorial[order.paymentMethod]!)
                ],
              ),
            ),
          ),
          if (order.paymentMethod == PAYMENT_TRANSFER)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Bukti Pembayaran",
                      style: TextStyle(
                          color: Colors.blue[300], fontWeight: FontWeight.bold),
                    ),
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white)),
                        onPressed: () async {
                          await onUploadButtonClick();
                        },
                        child: Wrap(
                          spacing: 20,
                          alignment: WrapAlignment.start,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: const [
                            FaIcon(
                              FontAwesomeIcons.image,
                              color: Colors.black,
                            ),
                            Text(
                              "Unggah",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        )),
                    if (proof != null)
                      Image.file(
                        File(proof!.path),
                        height: 400,
                      )
                  ]),
            ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
                onPressed: () async {
                  if (!isLoading) {
                    setState(() {
                      isLoading = true;
                    });
                    await processPaid();
                    setState(() {
                      isLoading = false;
                    });
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      const Color.fromARGB(255, 228, 169, 8)),
                  padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10)),
                ),
                child: isLoading
                    ? const CircularProgressIndicator()
                    : Wrap(
                        spacing: 10,
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: const [
                          FaIcon(FontAwesomeIcons.telegram),
                          Text("Kirim"),
                        ],
                      )),
          )
        ],
      ),
    );
  }

  Future<void> processPaid() async {
    if (proof == null && order.paymentMethod == PAYMENT_TRANSFER) {
      Widget continueButton = TextButton(
        child: const Text("Ok"),
        onPressed: () {
          setState(() {
            Navigator.of(context).pop();
          });
        },
      );
      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: const Text("Pembayaran Gagal"),
        content: const Text("Bukti Pembayaran dibutuhkan."),
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

        OrderSingleResponse response;

        if (order.paymentMethod == PAYMENT_BAYAR_DITEMPAT) {
          response = await client.changeStatusOrder(OrderStatusRequest(
              id: order.id!, status: "waiting_confirmation"));
        } else {
          response = await client.paidOrder(order.id!, File(proof!.path));
        }

        List<Order> orders = [...ViewModels.getState("myOrders")];
        var foundIndex = orders.indexWhere((element) => element.id == order.id);
        if (foundIndex != -1) {
          orders[foundIndex] = response.data;
        }
        ViewModels.ctrlState.sink.add([
          {"name": "myOrders", "value": orders},
        ]);
        Widget continueButton = TextButton(
          child: const Text("Ok"),
          onPressed: () {
            setState(() {
              Navigator.of(context).pop();
              SingelPageRoute.pushAndReplaceName(routePurchase);
            });
          },
        );
        // set up the AlertDialog
        AlertDialog alert = AlertDialog(
          title: const Text("Success to paid"),
          content: const Text("Berhasil melakukan pemesanan"),
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
          child: const Text("Cancel"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        );
        Widget continueButton = TextButton(
          child: const Text("Coba lagi"),
          onPressed: () async {
            Navigator.of(context).pop();
            await processPaid();
            setState(() {
              isLoading = false;
            });
          },
        );
        String message = e.message;
        // set up the AlertDialog
        AlertDialog alert = AlertDialog(
          title: const Text("AlertDialog"),
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

  Future<void> onUploadButtonClick() async {
    XFile? file = await _picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      setState(() {
        proof = file;
      });
    }
  }
}
