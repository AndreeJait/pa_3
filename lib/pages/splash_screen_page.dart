import 'package:flutter/material.dart';
import 'package:pa_3/constans/general_router_constant.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Center(
            child: ElevatedButton(
              child: Text("Navigate"),
              onPressed: ()=>{
                Navigator.pushNamed(context, routeVisitor)
              },
            ),
          ),
        )
    );
  }
}
