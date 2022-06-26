import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pa_3/component/bottom_navigator.dart';
import 'package:pa_3/constans/router_consumer.dart';
import 'package:pa_3/model/bottom_navigator.dart';
import 'package:pa_3/router/singel_consumer_router.dart';
import 'package:singel_page_route/singel_page_route.dart';

class MasterHomePageConsumer extends StatefulWidget {
  const MasterHomePageConsumer({Key? key}) : super(key: key);

  @override
  State<MasterHomePageConsumer> createState() => _MasterHomePageConsumerState();
}

class _MasterHomePageConsumerState extends State<MasterHomePageConsumer> {
  late Widget view;
  late StreamSubscription _subscription;
  List<BottomNavigatorModel> navigator = [...bottomNavigators];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SingelPageRoute.clearHistory();
    SingelPageRoute.initSingelPageRoute(routeProduct, routes);

    SingelPageRoute.pushNamedWithoutTrigger(routeProduct);
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
      appBar: SingelPageRoute.currentName != routeProduct
          ? PreferredSize(
              preferredSize: const Size.fromHeight(50),
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
                    Wrap(
                      spacing: 20,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        if (SingelPageRoute.histories.length > 1)
                          InkWell(
                            onTap: () {
                              SingelPageRoute.previous();
                            },
                            child: FaIcon(FontAwesomeIcons.arrowLeft),
                          ),
                        ClipOval(
                          child: Image.network(
                            "https://picsum.photos/250?image=9",
                            height: 35,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        // SingelPageRoute.pushName(routeNOTI);
                      },
                      child: const FaIcon(
                        FontAwesomeIcons.bell,
                        size: 25,
                      ),
                    )
                  ],
                ),
              ))
          : null,
      body: Container(
        child: view,
      ),
      bottomNavigationBar: BottomNavigator(
        navigtors: navigator,
      ),
    ));
  }
}
