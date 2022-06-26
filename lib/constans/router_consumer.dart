import 'package:flutter/material.dart';
import 'package:pa_3/model/bottom_navigator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const routeProfile = "PROFILE";
const routePurchase = "PURCHASES";
const routeProduct = "PRODUCT";
const routeHistory = "HISTORY";
const routeOrder = "PRODUCT_ORDER";
const routePayment = "PURCHASES_PAYMENT";
const routeShipment = "PRODUCT_SHIPMENT";
const routeSutar = "PRODUCT_SUTAR";
const routeMozzataru = "PRODUCT_MOZZATARU";
const routeOrderForm = "PRODUCT_ORDER_FORM";

var bottomNavigators = [
  BottomNavigatorModel(
    name: "Products",
    initial: routeProduct,
    icon: const FaIcon(
      FontAwesomeIcons.bottleWater,
      size: 18,
      color: Colors.black87,
    ),
  ),
  BottomNavigatorModel(
    name: "Purchase",
    initial: routePurchase,
    icon: const FaIcon(
      FontAwesomeIcons.boxesPacking,
      size: 18,
      color: Colors.black87,
    ),
  ),
  BottomNavigatorModel(
    name: "History",
    initial: routeHistory,
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
