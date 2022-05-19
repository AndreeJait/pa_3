import 'package:flutter/material.dart';
import 'package:pa_3/constans/general_router_constant.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  // @override
  // void initState() {
  //   autoLogin();
  //   super.initState();
  // }

  Future<void> autoLogin() async {}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/chemil.png',
                height: 120,
                width: 120,
              ),
              const SizedBox(
                height: 15,
              ),
              const CircularProgressIndicator(),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                child: const Text("Navigate"),
                onPressed: () => {Navigator.pushNamed(context, routeVisitor)},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
