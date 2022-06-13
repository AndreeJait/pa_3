class ChartModel {
  final String username;
  final String fullname;
  final String phone;
  final String email;
  final String photo;
  final String address;

  ChartModel({
    required this.username,
    required this.fullname,
    required this.phone,
    required this.email,
    required this.photo,
    required this.address,
  });
}

final List<ChartModel> users = [
  ChartModel(
      username: "sotardo",
      fullname: "Sotar Dodo",
      phone: "0812-34567-7890",
      email: "examplemail@email.com",
      photo: "assets/images/profile.png",
      address: "Sotar Dodo, 1234 NW Bobcat Lane, St. Robert, MO 65584-5678 ")
];
