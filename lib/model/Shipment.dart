class ChartModel {
  final String id;
  final String name;
  final String detail;
  final String time;

  ChartModel({
    required this.id,
    required this.name,
    required this.detail,
    required this.time,
  });
}

final List<ChartModel> shipments = [
  ChartModel(
      id: "sfp",
      name: "Self Pick Up",
      detail:
          "Pengambilan produk akan datang kedalam notifikasi Anda bahwa produk sudah dapat diambil ke peternakan.",
      time: "08.00 AM - 05.00 PM"),
  ChartModel(
      id: 'dlvr',
      name: "Delivery",
      detail:
          "Pengantaran produk akan datang kedalam notifikasi Anda bahwa produk akan diantar kepada lokasi tujuan ",
      time: "08.00 AM - 05.00 PM")
];
