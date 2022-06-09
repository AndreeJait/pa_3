import 'package:flutter/material.dart';
import 'package:pa_3/constans/general_router_constant.dart';
import 'package:pa_3/router/general_router.dart' as general_router;
import 'package:pa_3/utils/view_models.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Permission.manageExternalStorage.request();
  await Permission.storage.request();
  ViewModels.initViewModels();
  await Permission.camera.request();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: general_router.router,
      initialRoute: routeSplash,
    );
  }
}
