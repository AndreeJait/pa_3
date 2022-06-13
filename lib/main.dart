import 'dart:isolate';
import 'dart:ui';
import 'dart:developer';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
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
  await AndroidAlarmManager.initialize();
  runApp(const MyApp());
  await AndroidAlarmManager.cancel(0);
  var success = await AndroidAlarmManager.periodic(
      const Duration(minutes: 2), 0, () async {
    print("Hellow");
  }, wakeup: true);

  print(success);
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
