import 'package:pa_3/constans/general_router_constant.dart';
import 'package:pa_3/pages/login_page.dart';
import 'package:pa_3/pages/master_home_page_admin.dart';
import 'package:pa_3/pages/master_home_page_visitor.dart';
import 'package:pa_3/pages/register_page.dart';
import 'package:pa_3/pages/splash_screen_page.dart';

var router = {
  routeDashboard: (context) => const SplashScreen(),
  routeVisitor: (context) => const MasterHomePageVisitor(),
  routeAdmin: (context) => const MasterHomePageAdmin(),
  routeLogin: (context) => const LoginPage(),
  routeRegister: (context) => const RegisterPage(),
};
