import 'package:json_annotation/json_annotation.dart';

part 'auth_request.g.dart';

@JsonSerializable()
class AuthRequest {
  String email;
  String password;
  String? name;
  String? role;
  String? address;

  AuthRequest(
      {required this.email,
      this.address,
      this.name,
      required this.password,
      this.role});

  factory AuthRequest.fromJson(Map<String, dynamic> json) =>
      _$AuthRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AuthRequestToJson(this);
}
