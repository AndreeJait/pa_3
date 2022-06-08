import 'package:flutter/material.dart';
import 'package:pa_3/model/bottom_navigator.dart';
import 'package:singel_page_route/singel_page_route.dart';

class BottomNavigator extends StatelessWidget {
  List<BottomNavigatorModel> navigtors;

  BottomNavigator({Key? key, required this.navigtors}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ...navigtors.map((e) {
            e.checkCurrent(SingelPageRoute.currentName);
            return GestureDetector(
              onTap: () => {SingelPageRoute.pushName(e.initial)},
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 3,
                direction: Axis.vertical,
                children: [e.icon, Text(e.name)],
              ),
            );
          })
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
    );
  }
}
