import 'package:pa_3/component/admin/form_product_component.dart';
import 'package:pa_3/component/admin/form_product_stock_component.dart';
import 'package:pa_3/component/admin/home_admin_component.dart';
import 'package:pa_3/component/admin/ntofication_admin_component.dart';
import 'package:pa_3/component/admin/ordered_admin_component.dart';
import 'package:pa_3/component/admin/product_admin_component.dart';
import 'package:pa_3/component/admin/profile_admin_component.dart';
import 'package:pa_3/constans/router_admin.dart';

var routes = {
  routeHOME: HomeAdminComponent(),
  routePRODUCT: ProductAdminComponent(),
  routeORDER: OrderedAdminComponent(),
  routePROFILE: ProfileAdminComponent(),
  routeNOTIF: NotificationAdminComponent(),
  routeFormProduct: FormProduct(),
  routeFormProductStock: FormProductStock(),
};
