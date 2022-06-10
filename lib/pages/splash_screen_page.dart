import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pa_3/api/request/product_request.dart';
import 'package:pa_3/api/rest_client.dart';
import 'package:pa_3/constans/general_router_constant.dart';
import 'package:pa_3/api/response/product_response.dart';
import 'package:pa_3/utils/view_models.dart';
import 'dart:io' show Platform, exit;

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

  Future<void> fetchDataFromApi() async {
    try {
      bool product = await fetchProduct();
      bool activeProduct = await fetchActiveProduct();
      if (product && activeProduct) {
        setState(() {
          Navigator.pushReplacementNamed(context, routeVisitor);
        });
      }
    } catch (e) {
      print(e);
      bool isOk = await confirm(context,
          title: const Text("Error Found"),
          content: const Text("Failed to get data"),
          textOK: const Text("Try Again"),
          textCancel: const Text("Exit"));

      if (isOk) {
        fetchActiveProduct();
      } else {
        if (Platform.isAndroid) {
          SystemNavigator.pop();
        } else if (Platform.isIOS) {
          exit(0);
        }
      }
    }
  }

  Future<bool> fetchProduct() async {
    Dio dio = Dio();
    // dio.options.headers[]
    final client = RestClient(dio);
    ProductRequest request = ProductRequest();
    ProductResponse response = await client.getProduct(request);
    ViewModels.ctrlState.sink.add([
      {"name": "products", "value": response.data}
    ]);
    return true;
  }

  Future<bool> fetchActiveProduct() async {
    Dio dio = Dio();
    // dio.options.headers[]
    final client = RestClient(dio);
    ProductRequest request = ProductRequest();
    ProductActiveResponse response = await client.getProductActive(request);

    ViewModels.ctrlState.sink.add([
      {"name": "activeProducts", "value": response.data}
    ]);

    return true;
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
