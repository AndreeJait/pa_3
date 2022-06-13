class Product {
  final String id;
  final String name;
  final String variant;
  final int price;
  final String imageUrl;

  Product({
    required this.id,
    required this.name,
    required this.variant,
    required this.price,
    required this.imageUrl,
  });
}

final List<Product> products = [
  Product(
    id: "SM-01",
    name: "Sutar Original (1 Liter)",
    variant: "Original",
    price: 17000,
    imageUrl: "assets/images/sutar_original.png",
  ),
  Product(
    id: "SM-02",
    name: "Sutar Strawberry (1 Liter)",
    variant: "Strawberry",
    price: 17000,
    imageUrl: "assets/images/sutar_stroberi.png",
  ),
  Product(
    id: "SM-03",
    name: "Sutar Coklat (1 Liter)",
    variant: "Coklat",
    price: 17000,
    imageUrl: "assets/images/sutar_coklat.png",
  ),
  Product(
    id: "MZ-01",
    name: "Mozzataru (250 gram)",
    variant: "Mozzarella",
    price: 27000,
    imageUrl: "assets/images/mozarella.png",
  ),
];
