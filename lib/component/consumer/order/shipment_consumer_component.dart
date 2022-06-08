import 'package:flutter/material.dart';

import 'package:pa_3/constans/router_consumer.dart';
import 'package:pa_3/model/Shipment.dart';

import 'package:singel_page_route/singel_page_route.dart';

class ShipmentConsumerComponent extends StatefulWidget {
  const ShipmentConsumerComponent({Key? key}) : super(key: key);

  @override
  State<ShipmentConsumerComponent> createState() =>
      _ShipmentConsumerComponentState();
}

enum Shipment { sfp, dlvr }

class _ShipmentConsumerComponentState extends State<ShipmentConsumerComponent> {
  @override
  Widget build(BuildContext context) {
    Shipment? _shipment = Shipment.sfp;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Column(
        children: [
          subtitle("Shipment"),
          const SizedBox(
            height: 20,
          ),
          Wrap(
            spacing: 20,
            runSpacing: 10,
            children: [
              RadioListTile<Shipment>(
                title: const Text('Self Pick Up'),
                contentPadding: const EdgeInsets.all(10),
                value: Shipment.sfp,
                groupValue: _shipment,
                onChanged: (value) {
                  setState(() {
                    _shipment = value;
                  });
                },
                subtitle: detailText(shipments[0].detail),
              ),
              RadioListTile<Shipment>(
                title: const Text('Delivery'),
                contentPadding: const EdgeInsets.all(10),
                value: Shipment.dlvr,
                groupValue: _shipment,
                onChanged: (value) {
                  setState(() {
                    _shipment = value;
                  });
                },
                subtitle: detailText(shipments[1].detail),
              ),
            ],
          ),
          ElevatedButton(
            style: raisedButtonstyle,
            child: const Text("Confirm"),
            onPressed: () {
              SingelPageRoute.pushName(routeOrder);
            },
          ),
        ],
      ),
    );
  }
}

final ButtonStyle raisedButtonstyle = ElevatedButton.styleFrom(
  onPrimary: Colors.white,
  primary: const Color(0xffF8C83F),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
  ),
);

Widget subtitle(text) => Text(
      text,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Color(0xff585858),
      ),
    );

Widget detailText(text) => Text(
      text,
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: Color(0xff585858),
      ),
    );
