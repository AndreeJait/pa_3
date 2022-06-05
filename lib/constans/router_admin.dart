import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pa_3/model/bottom_navigator.dart';

const routeHOME = "HOME";
const routePRODUCT = "PRODUCT";
const routeORDER = "ORDER";
const routePROFILE = "PROFILE";
const routeNOTIF = "NOTIFICATION";

var bottomNavigators = [
  BottomNavigatorModel(
      name: "Home",
      initial: routeHOME,
      icon: const FaIcon(
        FontAwesomeIcons.house,
        size: 18,
        color: Colors.black26,
      )),
  BottomNavigatorModel(
      name: "Product",
      initial: routePRODUCT,
      icon: const FaIcon(
        FontAwesomeIcons.handHoldingDroplet,
        size: 18,
        color: Colors.black26,
      )),
  BottomNavigatorModel(
      name: "Ordered",
      initial: routeORDER,
      icon: const FaIcon(
        FontAwesomeIcons.clipboardList,
        size: 18,
        color: Colors.black26,
      )),
  BottomNavigatorModel(
      name: "Profile",
      initial: routePROFILE,
      icon: const FaIcon(
        FontAwesomeIcons.user,
        size: 18,
        color: Colors.black26,
      )),
];
