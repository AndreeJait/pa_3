import 'package:pa_3/component/consumer/history_consumer_component.dart';
import 'package:pa_3/component/consumer/mozzataru_detail_consumer_component.dart';
import 'package:pa_3/component/consumer/order/form_order_product.dart';
import 'package:pa_3/component/consumer/order/form_pembayaran.dart';
import 'package:pa_3/component/consumer/order/order_consumer_component.dart';
import 'package:pa_3/component/consumer/product_consumer_component.dart';
import 'package:pa_3/component/consumer/sutar_detail_consumer_component.dart';
import 'package:pa_3/component/consumer/profile_consumer_component.dart';
import 'package:pa_3/component/consumer/purchase_consumer_component.dart';
import 'package:pa_3/constans/router_consumer.dart';

const routes = {
  routeProfile: ProfileConsumerComponent(),
  routePurchase: PurchaseConsumerComponent(),
  routeProduct: ProductConsumerComponent(),
  routeHistory: HistoryConsumerComponent(),
  routeOrder: OrderConsumerComponent(),
  routePayment: FormPembayaran(),
  // routeShipment: ShipmentConsumerComponent(),
  routeOrderForm: FormOrderProduct(),
  routeSutar: SutarDetailConsumerComponent(),
  routeMozzataru: MozzataruDetailConsumerComponent(),
};
