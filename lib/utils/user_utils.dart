import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pa_3/api/response/auth_response.dart';
import 'package:pa_3/constans/general_router_constant.dart';
import 'package:pa_3/constans/preferences.dart';
import 'package:pa_3/constans/role.dart';
import 'package:pa_3/model/user.dart';
import 'package:pa_3/utils/view_models.dart';
import 'package:shared_preferences/shared_preferences.dart';

void redirectByRole(User user, BuildContext context) {
  if (user.role == roleAdmin) {
    Navigator.pushReplacementNamed(context, routeAdmin);
  } else if (user.role == roleConsumer) {
    Navigator.pushReplacementNamed(context, routeConsumer);
  } else if (user.role == roleMarketing) {
    Navigator.pushReplacementNamed(context, routeMarketing);
  }
}

Future<void> setupUserData(AuthResponse response) async {
  ViewModels.ctrlState.sink.add([
    {"name": "user", "value": response.data},
    {"name": "token", "value": response.token},
    {"name": "refresh", "value": response.refresh}
  ]);
  final prefs = await SharedPreferences.getInstance();
  String convert = jsonEncode(response.data!);

  await prefs.setString(prefUser, convert);
  await prefs.setString(prefRefresh, response.refresh!);
  await prefs.setString(prefToken, response.token);
}

Future<void> logOut(BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();
  ViewModels.ctrlState.sink.add([
    {"name": "user", "value": null},
    {"name": "token", "value": null},
    {"name": "refresh", "value": null}
  ]);
  prefs.remove(prefUser);
  prefs.remove(prefToken);
  prefs.remove(prefRefresh);

  Navigator.pushReplacementNamed(context, routeLogin);
}
