import 'package:pa_3/model/Product.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  var shipment = 'Self Pick Up';
  var shipmentId = 'sfp';
  var variant = '';
  var address = '';
  var product = '';
  var quantity = 1.obs;
  var totalPayment = 0.obs;
  var index = 0;

  getIndex(variant) =>
      index = products.indexWhere((product) => product.variant == variant);
  setIndex(index) => index = index;

  saveShipment(value) => shipment = value;
  saveAddress(value) => address = value;
  saveProduct(value) => product = value;

  setQuantity() => quantity = RxInt(1);
  saveQuantity(value) => quantity = value;
  addQuantity() => quantity = quantity + 1;
  decQuantity() => quantity = quantity - 1;

  setVariant(orderedVariant) => variant = orderedVariant;

  setTotalPayment() => totalPayment = RxInt(0);
  addPrice(itemPrice) => totalPayment = totalPayment + itemPrice;
  decPrice(itemPrice) => totalPayment = totalPayment - itemPrice;
  savetotalPayment(value) => totalPayment = value;
}
