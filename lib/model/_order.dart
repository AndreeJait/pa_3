import 'package:pa_3/model/product.dart';
import 'package:pa_3/model/user.dart';

class Order {
  Product product;
  User user;
  String status;
  int quantity;
  double totalPrice;
  String date;
  Order(
      {required this.product,
      required this.date,
      required this.quantity,
      required this.status,
      required this.totalPrice,
      required this.user});
}
