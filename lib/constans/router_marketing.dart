import 'package:flutter/material.dart';
import 'package:pa_3/model/bottom_navigator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const routeHome = "HOME";
const routeProfile = "PROFILE";
const routeAbout = "ABOUT";
const routeOrder = "ORDER";
const routeOrdered = "ORDER_ORDERED";
const routeHistory = "ORDER_HISTORY";

var bottomNavigators = [
  BottomNavigatorModel(
    name: "Orders",
    initial: routeHome,
    icon: const FaIcon(
      FontAwesomeIcons.box,
      size: 18,
      color: Colors.black87,
    ),
  ),
  BottomNavigatorModel(
    name: "About",
    initial: routeAbout,
    icon: const FaIcon(
      FontAwesomeIcons.fileLines,
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
