import 'package:flutter/material.dart';
import 'package:pa_3/constans/router_visitor.dart';
import 'package:singel_page_route/singel_page_route.dart';

class HomeVisitorComponent extends StatefulWidget {
  const HomeVisitorComponent({Key? key}) : super(key: key);

  @override
  State<HomeVisitorComponent> createState() => _HomeVisitorComponentState();
}

class _HomeVisitorComponentState extends State<HomeVisitorComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        child: const Text("Navigate About"),
        onPressed: () {
          SingelPageRoute.pushName(routeAbout);
        },
      ),
    );
  }
}
