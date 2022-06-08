import 'package:flutter/material.dart';

class TabBarCustom extends StatelessWidget {
  TabController tabController;
  List<Tab> tabs;
  TabBarCustom({Key? key, required this.tabController, required this.tabs})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
          color: Colors.grey[300], borderRadius: BorderRadius.circular(25.0)),
      child: TabBar(
        controller: tabController,
        indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0), color: Colors.green),
        labelColor: Colors.white,
        unselectedLabelColor: Colors.black,
        tabs: [...tabs],
      ),
    );
  }
}
