import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pa_3/component/bottom_navigator.dart';
import 'package:pa_3/constans/router_admin.dart';
import 'package:pa_3/model/bottom_navigator.dart';
import 'package:pa_3/router/singel_admin_router.dart';
import 'package:singel_page_route/singel_page_route.dart';

class MasterHomePageAdmin extends StatefulWidget {
  const MasterHomePageAdmin({Key? key}) : super(key: key);

  @override
  State<MasterHomePageAdmin> createState() => _MasterHomePageAdminState();
}

class _MasterHomePageAdminState extends State<MasterHomePageAdmin> {
  late Widget view;
  late StreamSubscription _subscription;
  List<BottomNavigatorModel> navigator = [...bottomNavigators];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SingelPageRoute.initSingelPageRoute(routeHOME, routes);

    SingelPageRoute.pushNamedWithoutTrigger(routeHOME);
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
      appBar: SingelPageRoute.currentName == routeHOME
          ? null
          : PreferredSize(
              child: Container(
                height: 50,
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                color: Colors.indigo[100],
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ClipOval(
                      child: Image.network(
                        "https://picsum.photos/250?image=9",
                        height: 35,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        SingelPageRoute.pushName(routeNOTIF);
                      },
                      child: const FaIcon(
                        FontAwesomeIcons.bell,
                        size: 25,
                      ),
                    )
                  ],
                ),
              ),
              preferredSize: const Size.fromHeight(50)),
      body: Container(
        child: view,
      ),
      bottomNavigationBar: BottomNavigator(
        navigtors: navigator,
      ),
    ));
  }
}
