class Product {
  String id = "";
  String image;
  String name;
  double price;
  int stock;
  int weight;
  String expiredDate;
  Product(
      {required this.id,
      required this.image,
      required this.expiredDate,
      required this.name,
      required this.price,
      required this.stock,
      required this.weight});
}
