import 'dart:async';

import 'package:pa_3/model/user.dart';

class ViewModels {
  static Map<String, dynamic> stateBefore = {};
  static Map<String, dynamic> state = {};
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
