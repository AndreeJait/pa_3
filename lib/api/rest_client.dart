import 'package:dio/dio.dart';
import 'package:pa_3/api/request/auth_request.dart';
import 'package:pa_3/api/response/auth_response.dart';
import 'package:retrofit/http.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: "http://192.168.1.19:5000")
abstract class RestClient {
  factory RestClient(Dio dio) = _RestClient;

  @POST("/auth/login")
  Future<AuthResponse> login(@Body() AuthRequest request);
}
