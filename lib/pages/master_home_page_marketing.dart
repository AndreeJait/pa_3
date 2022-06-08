import 'package:flutter/material.dart';
import 'dart:async';

import 'package:singel_page_route/singel_page_route.dart';
import 'package:pa_3/router/singel_marketing_router.dart';
import 'package:pa_3/component/bottom_navigator.dart';
import 'package:pa_3/constans/router_marketing.dart';
import 'package:pa_3/model/bottom_navigator.dart';

class MasterHomePageMarketing extends StatefulWidget {
  const MasterHomePageMarketing({Key? key}) : super(key: key);

  @override
  State<MasterHomePageMarketing> createState() =>
      _MasterHomePageMarketingState();
}

class _MasterHomePageMarketingState extends State<MasterHomePageMarketing> {
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
    // TODO: implement dispose
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
