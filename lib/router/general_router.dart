import 'package:pa_3/constans/general_router_constant.dart';
import 'package:pa_3/pages/master_home_page_admin.dart';
import 'package:pa_3/pages/master_home_page_visitor.dart';
import 'package:pa_3/pages/splash_screen_page.dart';

var router = {
  routeDashboard: (context)=> SplashScreen(),
  routeVisitor: (context)=> MasterHomePageVisitor(),
  routeAdmin: (context)=> MasterHomePageAdmin(),
};