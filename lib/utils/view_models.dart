import 'dart:async';

import 'package:pa_3/constans/api.dart';
import 'package:pa_3/model/order.dart';
import 'package:pa_3/model/user.dart';

class ViewModels {
  static Map<String, bool> isEverHitApi = {"myOrder": false};
  static Map<String, dynamic> stateBefore = {};
  static Map<String, dynamic> state = {
    "sentOption": SENT_AMBIL_DITEMPAT,
    "myOrders": <Order>[]
  };
  static StreamController<List<Map<String, dynamic>>> ctrlState =
      StreamController.broadcast();
  static late Stream<List<Map<String, dynamic>>> stateStream;
  static void initViewModels() {
    stateStream = ctrlState.stream;
    stateStream.listen((data) {
      data.forEach((element) {
        stateBefore[element["name"]] = state[element["name"]];
        state[element["name"]] = element["value"];
      });
    });
  }

  static dynamic getState(String name) {
    return state[name];
  }
}
