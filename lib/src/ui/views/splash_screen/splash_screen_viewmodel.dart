import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:resident_app/src/app/app.router.dart';
import 'package:resident_app/src/constant/session.dart';
import 'package:resident_app/src/core/core_view_model.dart';
import 'package:stacked/stacked.dart';

class SplashScreenViewModel extends FutureViewModel with CoreViewModel {
  final _duration = const Duration(seconds: 2);
  final currentTime = DateTime.now();

  @override
  Future futureToRun() => showLocationPermission();

  Future showLocationPermission() async {
    var status = await Permission.location.status;

    if (status.isGranted) {
      showNextPage();
    } else {
      var request = await Permission.location.request();
      if (request.isGranted) {
        showNextPage();
      } else {
        showMessageError('Permintaan izin lokasi harus diizinkan');
        if (Platform.isAndroid) {
          SystemNavigator.pop();
        } else if (Platform.isIOS) {
          exit(0);
        }
      }
    }
  }

  void showNextPage() async {
    final loggedIn = sharedPreferencesHelper.getString(Session.msgLoggedIn);
    if (loggedIn != null) {
      Timer(_duration, showDashboard);
    } else {
      Timer(_duration, showLogin);
    }
  }

  void showLogin() => navigationService.clearStackAndShow(Routes.loginView);

  void showDashboard() => navigationService.clearStackAndShow(Routes.mainView);
}
