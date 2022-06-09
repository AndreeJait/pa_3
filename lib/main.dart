import 'package:flutter/material.dart';
import 'package:pa_3/constans/general_router_constant.dart';
import 'package:pa_3/router/general_router.dart' as general_router;
import 'package:permission_handler/permission_handler.dart';

void main() async {
  // await Permission.manageExternalStorage.request();
  // await Permission.manageExternalStorage.request();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: general_router.router,
      initialRoute: routeLogin,
    );
  }
}
