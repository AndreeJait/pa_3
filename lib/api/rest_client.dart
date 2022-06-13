import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pa_3/api/request/auth_request.dart';
import 'package:pa_3/api/request/order_request.dart';
import 'package:pa_3/api/request/product_request.dart';
import 'package:pa_3/api/response/auth_response.dart';
import 'package:pa_3/api/response/order_response.dart';
import 'package:pa_3/api/response/product_response.dart';
import 'package:pa_3/constans/api.dart';
import 'package:pa_3/model/order.dart';
import 'package:retrofit/http.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: baseUrlConstant)
abstract class RestClient {
  factory RestClient(Dio dio) = _RestClient;

  @POST("/auth/login")
  Future<AuthResponse> login(@Body() AuthRequest request);

  @GET("/auth/refresh")
  Future<AuthResponse> refreshToken();

  @POST("/auth/register")
  Future<AuthResponse> register(@Body() AuthRequest request);

  @POST("/product/active")
  Future<ProductActiveResponse> getProductActive(
      @Body() ProductRequest request);

  @POST("/product/all")
  Future<ProductResponse> getProduct(@Body() ProductRequest request);

  @POST("/product/stock")
  Future<ProductActiveSingleResponse> createProductStock(
      @Body() ProductStockRequest request);

  @POST("/product/")
  @MultiPart()
  Future<ProductSingleResponse> createProduct(
      @Part() List<File> variantImage,
      @Part() String name,
      @Part() int productDurable,
      @Part() int weight,
      @Part() int temperatureStorage,
      @Part() List<String> variant,
      @Part() List<String> priceVariant,
      @Part() List<String> variantIndex);

  @POST("/order/")
  Future<OrderResponse> getAllOrder(@Body() OrderRequest request);
}
