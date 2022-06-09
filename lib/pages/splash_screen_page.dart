import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pa_3/api/request/product_request.dart';
import 'package:pa_3/api/rest_client.dart';
import 'package:pa_3/constans/general_router_constant.dart';
import 'package:pa_3/api/response/product_response.dart';
import 'package:pa_3/utils/view_models.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchDataFromApi();
  }

  void fetchDataFromApi() {
    print("Here");
    Dio dio = Dio();
    // dio.options.headers[]
    final client = RestClient(dio);
    ProductRequest request = ProductRequest();
    client.getProductActive(request).then((value) {
      print(value);
      ViewModels.ctrlState.sink.add([
        {"name": "activeProducts", "value": value.data}
      ]);
    }).catchError((error) {
      print(error);
    });
  }

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
            ],
          ),
        ),
      ),
    );
  }
}
