import 'package:flutter/material.dart';
import 'dart:async';

import 'package:singel_page_route/singel_page_route.dart';
import 'package:pa_3/router/singel_visitor_router.dart';
import 'package:pa_3/component/bottom_navigator.dart';
import 'package:pa_3/constans/router_visitor.dart';
import 'package:pa_3/model/bottom_navigator.dart';

class MasterHomePageVisitor extends StatefulWidget {
  const MasterHomePageVisitor({Key? key}) : super(key: key);

  @override
  State<MasterHomePageVisitor> createState() => _MasterHomePageVisitorState();
}

class _MasterHomePageVisitorState extends State<MasterHomePageVisitor> {
  late Widget view;
  late StreamSubscription _subscription;
  List<BottomNavigatorModel> navigator = [...bottomNavigators];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SingelPageRoute.initSingelPageRoute(routeHome, routes);

    SingelPageRoute.pushNamedWithoutTrigger(routeHome);
    view = SingelPageRoute.current;

    _subscription = SingelPageRoute.listen((data) {
      setState(() {
        view = data;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    SingelPageRoute.clearHistory();
    _subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(),
      body: Container(
        child: view,
      ),
      bottomNavigationBar: BottomNavigator(
        navigtors: navigator,
      ),
    ));
  }
}
