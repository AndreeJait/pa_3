import 'package:json_annotation/json_annotation.dart';
import 'package:pa_3/model/user.dart';

part 'auth_response.g.dart';

@JsonSerializable()
class AuthResponse {
  User? data;
  String token;
  String? refresh;

  AuthResponse({required this.token, this.data, this.refresh});

  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthResponseToJson(this);
}
