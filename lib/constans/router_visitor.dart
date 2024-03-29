import 'package:flutter/material.dart';
import 'package:pa_3/model/bottom_navigator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
    ),
  ),
  BottomNavigatorModel(
    name: "Purchases",
    initial: routePurchase,
    icon: const FaIcon(
      FontAwesomeIcons.store,
      size: 18,
      color: Colors.black87,
    ),
  ),
  BottomNavigatorModel(
    name: "About",
    initial: routeAbout,
    icon: const FaIcon(
      FontAwesomeIcons.circleExclamation,
      size: 18,
      color: Colors.black87,
    ),
  ),
  BottomNavigatorModel(
    name: "Profile",
    initial: routeProfile,
    icon: const FaIcon(
      FontAwesomeIcons.circleUser,
      size: 18,
      color: Colors.black87,
    ),
  ),
];
