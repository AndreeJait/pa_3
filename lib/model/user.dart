import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  String name;
  String password;
  String email;
  @JsonKey(name: "_id")
  String id;
  String address;
  String phoneNumber;
  String role;
  User(
      {required this.id,
      required this.name,
      required this.password,
      required this.email,
      required this.address,
      required this.role,
      required this.phoneNumber});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
