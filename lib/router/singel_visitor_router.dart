import 'package:pa_3/component/visitor/about_visitor_component.dart';
import 'package:pa_3/component/visitor/home_visitor_component.dart';
import 'package:pa_3/component/visitor/profile_visitor_component.dart';
import 'package:pa_3/component/visitor/purchase_visitor_component.dart';
import 'package:pa_3/constans/router_visitor.dart';

const routes = {
  routeHome: HomeVisitorComponent(),
  routeAbout: AboutVisitorComponent(),
  routePurchase: PurchaseVisitorComponent(),
  routeProfile: ProfileVisitorComponent(),
};
