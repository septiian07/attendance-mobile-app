import 'package:resident_app/src/constant/session.dart';
import 'package:resident_app/src/core/core_service.dart';
import 'package:resident_app/src/models/auth.dart';
import 'package:resident_app/src/network/api_result.dart';
import 'package:resident_app/src/network/network_exceptions.dart';
import 'package:stacked/stacked_annotations.dart';

@LazySingleton()
class AuthService extends CoreService {
  Future<ApiResult<Auth>> login(
    String email,
    String password,
  ) async {
    try {
      final Map<String, dynamic> body = {
        "usr": email,
        "pwd": password,
      };
      var result = await apiService.auth(body);
      saveLoggedIn(result.message);
      sharedPreferencesHelper.putString(
        Session.userId,
        email,
      );
      sharedPreferencesHelper.putString(
        Session.userName,
        result.fullName ?? '',
      );
      return ApiResult.success(data: result);
    } catch (e) {
      return ApiResult.failure(
        error: NetworkExceptions.getDioException(e),
        message: NetworkExceptions.getMessage(e, true),
      );
    }
  }

  void saveLoggedIn(String? loggedIn) {
    sharedPreferencesHelper.putString(
      Session.msgLoggedIn,
      loggedIn ?? '',
    );
  }
}
