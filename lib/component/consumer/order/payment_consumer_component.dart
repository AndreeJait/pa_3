import 'package:flutter/material.dart';

import 'package:pa_3/component/consumer/order/order_form_controller.dart';

import 'package:intl/intl.dart';
import 'package:get/get.dart';

class PaymentConsumerComponent extends StatefulWidget {
  const PaymentConsumerComponent({Key? key}) : super(key: key);

  @override
  State<PaymentConsumerComponent> createState() =>
      _PaymentConsumerComponentState();
}

class _PaymentConsumerComponentState extends State<PaymentConsumerComponent> {
  final OrderController o = Get.put(OrderController());
  String paymentDate =
      DateFormat.yMMMd().format(DateTime.now().add(const Duration(days: 1)));

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          const Text("Payment"),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Total Payment : "),
              Text("Rp. ${o.totalPayment.toString()}")
            ],
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Please transfer: "),
              Column(
                children: [
                  const Text("in 24 Hours"),
                  Text("before ${paymentDate.toString()}")
                ],
              )
            ],
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xff0293DF),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                paymentSubtitle("Via Transfer Bank"),
                const SizedBox(height: 10),
                paymentSubtitle("0000 - 0000 - 0000- 0"),
                const SizedBox(height: 10),
                paymentDetailText("A.N. :  Chemilk"),
              ],
            ),
          )
        ],
      ),
    ));
  }
}

final ButtonStyle raisedButtonstyle = ElevatedButton.styleFrom(
  onPrimary: Colors.white,
  primary: const Color(0xffF8C83F),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
  ),
);

Widget paymentSubtitle(text) => Text(
      text,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );

Widget paymentDetailText(text) => Text(
      text,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.normal,
        color: Colors.white,
      ),
    );
