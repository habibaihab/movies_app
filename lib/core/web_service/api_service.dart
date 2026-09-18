import 'package:dio/dio.dart';
import 'package:movies_app/core/web_service/api_constants.dart';

class ApiService {
  final Dio dio;
  ApiService() :
    dio = Dio(BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        "Authorization" : ApiConstants.token
      }

    ),
    );
  // {
  //   dio.interceptors.add(
  //     InterceptorsWrapper(
  //
  //     )
  //   );
  // }


}