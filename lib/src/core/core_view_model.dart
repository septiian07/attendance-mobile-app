import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:resident_app/src/app/app.locator.dart';
import 'package:resident_app/src/app/app.router.dart';
import 'package:resident_app/src/constant/config.dart';
import 'package:resident_app/src/constant/session.dart';
import 'package:resident_app/src/helpers/shared_preferences_helper.dart';
import 'package:resident_app/src/injector/injector.dart';
import 'package:resident_app/src/ui/shared/colors.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CoreViewModel {
  final navigationService = locator<NavigationService>();
  final dialogService = locator<DialogService>();
  final SharedPreferencesHelper sharedPreferencesHelper =
      locatorLocal<SharedPreferencesHelper>();
  BuildContext? currentContext = StackedService.navigatorKey?.currentContext;

  String formattedDate =
      DateFormat(Config.dayDateFormat).format(DateTime.now());
  String dateNow = DateFormat(Config.dateFormat).format(DateTime.now());
  String dateTimeNow = DateFormat(Config.dateTimeFormat).format(DateTime.now());
  String formattedDateAPI =
      DateFormat(Config.dateFormatAPI).format(DateTime.now());

  void back() => navigationService.back();

  void showMessageError(String msg) {
    ScaffoldMessenger.of(currentContext!).showSnackBar(
      SnackBar(
        content: Text(msg),
      ),
    );
  }

  void showMessageSuccess(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: BaseColors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void showMessageWarning(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: BaseColors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void logout() {
    sharedPreferencesHelper.clearKey(Session.msgLoggedIn);
    sharedPreferencesHelper.clearAll();
    navigationService.clearStackAndShow(Routes.loginView);
  }
}
