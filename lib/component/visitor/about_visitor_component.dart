import 'package:flutter/material.dart';
import 'package:pa_3/constans/router_visitor.dart';
import 'package:singel_page_route/singel_page_route.dart';

class AboutVisitorComponent extends StatelessWidget {
  const AboutVisitorComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        child: Text("Navigate"),
        onPressed: (){
          SingelPageRoute.pushName(routeHome);
        },
      ),
    );
  }
}
