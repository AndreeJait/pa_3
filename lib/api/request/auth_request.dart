import 'package:json_annotation/json_annotation.dart';

part 'auth_request.g.dart';

@JsonSerializable()
class AuthRequest {
  String email;
  String password;
  String? name;
  String? role;
  String? address;
  String? phoneNumber;

  AuthRequest(
      {required this.email,
      this.address,
      this.name,
      required this.password,
      this.role,
      this.phoneNumber});

  factory AuthRequest.fromJson(Map<String, dynamic> json) =>
      _$AuthRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AuthRequestToJson(this);
}
