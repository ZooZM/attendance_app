import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import '../models/user_model.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: "https://example.com/api")
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @POST("/login")
  Future<UserModel> login(@Body() Map<String, dynamic> body);

  @POST("/register")
  Future<UserModel> createAccount(@Body() Map<String, dynamic> body);

  @GET("/users")
  Future<List<UserModel>> getUsers();
}
