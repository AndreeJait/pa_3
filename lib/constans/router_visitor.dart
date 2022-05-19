import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pa_3/model/bottom_navigator.dart';

const routeHome = "HOME";
const routeAbout = "ABOUT";
const routePurchase = "PURCHASE";
const routeProfile = "PROFILE";

var bottomNavigators = [
  BottomNavigatorModel(
      name: "Home",
      initial: routeHome,
      icon: const FaIcon(
        FontAwesomeIcons.house,
        size: 18,
        color: Colors.black87,
      )),
  BottomNavigatorModel(
      name: "About",
      initial: routeAbout,
      icon: const FaIcon(
        FontAwesomeIcons.circleExclamation,
        size: 18,
        color: Colors.black87,
      )),
];
