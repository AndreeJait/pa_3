import 'package:pa_3/component/marketing/about_marketing_component.dart';
import 'package:pa_3/component/marketing/home_marketing_component.dart';
import 'package:pa_3/component/marketing/order/history_marketing_component.dart';
import 'package:pa_3/component/marketing/order/ordered_marketing_component.dart';
import 'package:pa_3/component/marketing/order_marketing_component.dart';
import 'package:pa_3/component/marketing/profile_marketing_component.dart';
import 'package:pa_3/constans/router_marketing.dart';

const routes = {
  routeHome: HomeMarketingComponent(),
  routeAbout: AboutMarketingComponent(),
  routeProfile: ProfileMarketingComponent(),
  routeOrder: OrderMarketingComponent(),
  routeOrdered: OrderedMarketingComponent(),
  routeHistory: HistoryMarketingComponent(),
};
