import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:pa_3/constans/api.dart';
import 'package:pa_3/model/order.dart';
import 'package:pa_3/utils/view_models.dart';

class FormPembayaran extends StatefulWidget {
  const FormPembayaran({Key? key}) : super(key: key);

  @override
  State<FormPembayaran> createState() => _FormPembayaranState();
}

class _FormPembayaranState extends State<FormPembayaran> {
  Order order = ViewModels.getState("selectedOrder");
  Map<String, String> tutorial = {
    PAYMENT_BAYAR_DITEMPAT:
        "1.Lorem ipsum dolor sit amet, consectetur adipiscing elit. \n2.Etiam ullamcorper ultrices malesuada. Aliquam erat volutpat. Integer vel dui in erat rutrum porta nec id ligula.\n3. Nunc feugiat, tortor id dignissim semper, erat arcu convallis nulla, a interdum ligula est at ante. Vestibulum viverra ornare pharetra. \n4.Maecenas laoreet, orci vitae viverra tempus, metus neque pretium eros, in finibus elit libero eu sem. Nulla facilisi. Nam pretium urna tempor magna posuere, sed posuere purus scelerisque.",
    PAYMENT_TRANSFER:
        "1.Lorem ipsum dolor sit amet, consectetur adipiscing elit. \n2.Etiam ullamcorper ultrices malesuada. Aliquam erat volutpat. Integer vel dui in erat rutrum porta nec id ligula.\n3. Nunc feugiat, tortor id dignissim semper, erat arcu convallis nulla, a interdum ligula est at ante. Vestibulum viverra ornare pharetra. \n4.Maecenas laoreet, orci vitae viverra tempus, metus neque pretium eros, in finibus elit libero eu sem. Nulla facilisi. Nam pretium urna tempor magna posuere, sed posuere purus scelerisque."
  };
  final formatCurrency =
      NumberFormat.simpleCurrency(locale: "IDR", decimalDigits: 2);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: const Text(
              "Pembayran",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total Pembayaran"),
                Text(formatCurrency.format(order.total)),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20, bottom: 20),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  color: Colors.blue[300],
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Via Transfer Bank \n\n1234 - 1234 -1324 - 1235\n\nA.N Nama Pemilik Bak",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          Container(
            margin: EdgeInsets.only(top: 20, bottom: 20),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              margin: EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue, width: 1),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
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
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                "Bukti Pembayaran",
                style: TextStyle(
                    color: Colors.blue[300], fontWeight: FontWeight.bold),
              ),
              Container(
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white)),
                    onPressed: () {},
                    child: Wrap(
                      spacing: 20,
                      alignment: WrapAlignment.start,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        FaIcon(
                          FontAwesomeIcons.image,
                          color: Colors.black,
                        ),
                        Text(
                          "Upload",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        )
                      ],
                    )),
              )
            ]),
          )
        ],
      ),
    );
  }
}
