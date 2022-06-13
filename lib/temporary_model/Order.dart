class Order {
  final String buyer;
  final String products;
  final String variant;
  final String imageUrl;
  final int quantity;
  final String shipment;
  final int totalPayment;
  final String status;

  Order({
    required this.buyer,
    required this.products,
    required this.variant,
    required this.imageUrl,
    required this.quantity,
    required this.shipment,
    required this.totalPayment,
    required this.status,
  });
}

final List<Order> orders = [
  Order(
    buyer: "sotardo",
    products: "SM-01",
    variant: "Original",
    imageUrl: "assets/images/sutar_original.png",
    quantity: 3,
    shipment: "sfp",
    totalPayment: 51000,
    status: "Packing",
  ),
  Order(
    buyer: "sotardo",
    products: "SM-03",
    variant: "Coklat",
    imageUrl: "assets/images/sutar_coklat.png",
    quantity: 6,
    shipment: "sfp",
    totalPayment: 51000,
    status: "Done",
  ),
  Order(
    buyer: "mua",
    products: "SM-02",
    variant: "Strawberry",
    imageUrl: "assets/images/sutar_stroberi.png",
    quantity: 1,
    shipment: "sfp",
    totalPayment: 17000,
    status: "Done",
  ),
];
