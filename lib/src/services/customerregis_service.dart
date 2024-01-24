import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:resident_app/src/core/core_res_single.dart';
import 'package:resident_app/src/core/core_service.dart';
import 'package:resident_app/src/models/customerregis.dart';
import 'package:resident_app/src/network/api_result.dart';
import 'package:resident_app/src/network/customerregis_api.dart';
import 'package:resident_app/src/network/network_exceptions.dart';

class CustomerRegisService extends CoreService {
  CustomerRegisAPI customerRegisAPI = CustomerRegisAPI(Dio());

  Future<ApiResult<CoreResSingle<CustomerRegis>>> save(
      CustomerRegis param) async {
    try {
      var result = await customerRegisAPI.save(param.toJson());
      return ApiResult.success(data: result);
    } catch (e, stacktrace) {
      log("CustomerRegisService: ${e}");
      log("CustomerRegisService:StackTrace ${stacktrace}");
      return ApiResult.failure(
        error: NetworkExceptions.getDioException(e),
        message: NetworkExceptions.getMessage(e, true),
      );
    }
  }
}
