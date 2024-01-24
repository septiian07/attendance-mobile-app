import 'package:flutter/material.dart';
import 'package:resident_app/src/app/app.locator.dart';
import 'package:resident_app/src/app/app.router.dart';
import 'package:resident_app/src/core/core_view_model.dart';
import 'package:resident_app/src/models/auth.dart';
import 'package:resident_app/src/network/network_exceptions.dart';
import 'package:resident_app/src/network/result_state.dart';
import 'package:resident_app/src/services/auth_service.dart';
import 'package:stacked/stacked.dart';

class LoginViewModel extends BaseViewModel with CoreViewModel {
  final _authService = locator<AuthService>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool obscure = true;

  void validate() async {
    if (formKey.currentState?.validate() ?? false) login();
  }

  Future<ResultState<Auth>> login() async {
    setBusy(true);
    var result = await _authService.login(
      emailController.text,
      passwordController.text,
    );
    setBusy(false);
    return result.when(
      success: (Auth data) async {
        showDashboard();
        notifyListeners();
        return ResultState.data(data: data);
      },
      failure: (
        NetworkExceptions error,
        String? message,
      ) async {
        ScaffoldMessenger.of(currentContext!).showSnackBar(
          SnackBar(
            content: Text(message ?? ''),
          ),
        );
        notifyListeners();
        return ResultState.error(error: error);
      },
    );
  }

  void showDashboard() => navigationService.replaceWith(Routes.mainView);
}
