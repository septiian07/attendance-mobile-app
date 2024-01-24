import 'package:dio/dio.dart';
import 'package:resident_app/src/constant/config.dart';
import 'package:resident_app/src/core/core_res_single.dart';
import 'package:resident_app/src/helpers/http_helper.dart';
import 'package:resident_app/src/models/customerregis.dart';
import 'package:retrofit/http.dart';

part 'customerregis_api.g.dart';

@RestApi(baseUrl: Config.baseUrl)
abstract class CustomerRegisAPI {
  factory CustomerRegisAPI(Dio dio, {String? baseUrl}) {
    dio.interceptors.add(HttpHelper().getDioInterceptor());
    return _CustomerRegisAPI(dio, baseUrl: baseUrl);
  }

  @POST("resource/Customer Registration Form")
  Future<CoreResSingle<CustomerRegis>> save(@Body() Map<String, dynamic> body);
}
