import 'dart:developer';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:resident_app/src/app/app.locator.dart';
import 'package:resident_app/src/app/app.router.dart';
import 'package:resident_app/src/constant/session.dart';
import 'package:resident_app/src/helpers/shared_preferences_helper.dart';
import 'package:resident_app/src/injector/injector.dart';
import 'package:stacked_services/stacked_services.dart';

class HttpHelper {
  final SharedPreferencesHelper _sharedPreferencesManager =
      locatorLocal<SharedPreferencesHelper>();
  final navigationService = locator<NavigationService>();
  BuildContext? currentContext = StackedService.navigatorKey?.currentContext;

  var logger = Logger(
    printer: PrettyPrinter(
      colors: true,
      printEmojis: true,
      printTime: true,
    ),
  );

  getToken() => _sharedPreferencesManager.getString(Session.token);

  getSID() => _sharedPreferencesManager.getString(Session.sid);

  setSID(String value) =>
      _sharedPreferencesManager.putString(Session.sid, value);

  getDioInterceptor() => dio.InterceptorsWrapper(
        onRequest: (options, handler) {
          try {
            options.headers = {
              'Content-Type': options.data is dio.FormData
                  ? 'multipart/form-data'
                  : 'application/json',
              if (getSID() != null) 'Cookie': '${getSID()}'
            };
            logger.i(
                "${options.headers}\n${options.queryParameters}\n${options.data}");
            logger.i("${options.baseUrl}${options.path}\n${options.uri}");

            return handler.next(options);
          } catch (e) {
            logger.e("$options");
            return handler.next(options);
          }
        },
        onResponse: (response, handler) {
          try {
            logger.i(
                "${response.headers}\n${response.requestOptions}\n${response.requestOptions.baseUrl}");
            logger.i(
                "${response.requestOptions.baseUrl}\n${response.statusCode}\n${response.headers}\n${response.data}");
            if (getSID() == null) {
              setSID(response.headers['set-cookie']!.first);
            }
            return handler.next(response);
          } catch (e) {
            logger.e("$response");
            return handler.next(response);
          }
        },
        onError: (dio.DioError e, handler) {
          logger.e("$e");
          logger.e("${e.stackTrace}");
          if (e.response?.statusCode == 403) {
            ScaffoldMessenger.of(currentContext!).showSnackBar(
              SnackBar(
                content: Text(
                  '${e.response?.statusMessage ?? ''}\n${e.response?.data['exception'] ?? ''}'
                      .replaceAll('frappe', '')
                      .replaceAll('.', ' '),
                ),
              ),
            );
            log('status ${e.response?.data}');
            _sharedPreferencesManager.clearAll();
            navigationService.clearStackAndShow(Routes.loginView);
          }
          return handler.next(e);
        },
      );
}
