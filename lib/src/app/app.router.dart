// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import '../ui/views/history/history_view.dart';
import '../ui/views/home/home_face_recognized_regis_view.dart';
import '../ui/views/home/home_face_recognized_view.dart';
import '../ui/views/leave_application/leave_application_view.dart';
import '../ui/views/leave_application/new_leave_application_view.dart';
import '../ui/views/login/login_view.dart';
import '../ui/views/main/main_view.dart';
import '../ui/views/presence/presence_view.dart';
import '../ui/views/skrining/skrining_view.dart';
import '../ui/views/splash_screen/splash_screen_view.dart';

class Routes {
  static const String splashScreenView = '/';
  static const String loginView = '/login-view';
  static const String mainView = '/main-view';
  static const String skriningView = '/skrining-view';
  static const String presenceView = '/presence-view';
  static const String historyView = '/history-view';
  static const String leaveApplicationView = '/leave-application-view';
  static const String newLeaveApplicationView = '/new-leave-application-view';
  static const String homeFaceRecognizedView = '/home-face-recognized-view';
  static const String homeFaceRecognizedRegisView =
      '/home-face-recognized-regis-view';
  static const all = <String>{
    splashScreenView,
    loginView,
    mainView,
    skriningView,
    presenceView,
    historyView,
    leaveApplicationView,
    newLeaveApplicationView,
    homeFaceRecognizedView,
    homeFaceRecognizedRegisView,
  };
}

class StackedRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.splashScreenView, page: SplashScreenView),
    RouteDef(Routes.loginView, page: LoginView),
    RouteDef(Routes.mainView, page: MainView),
    RouteDef(Routes.skriningView, page: SkriningView),
    RouteDef(Routes.presenceView, page: PresenceView),
    RouteDef(Routes.historyView, page: HistoryView),
    RouteDef(Routes.leaveApplicationView, page: LeaveApplicationView),
    RouteDef(Routes.newLeaveApplicationView, page: NewLeaveApplicationView),
    RouteDef(Routes.homeFaceRecognizedView, page: HomeFaceRecognizedView),
    RouteDef(Routes.homeFaceRecognizedRegisView,
        page: HomeFaceRecognizedRegisView),
  ];
  @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, StackedRouteFactory>{
    SplashScreenView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const SplashScreenView(),
        settings: data,
      );
    },
    LoginView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const LoginView(),
        settings: data,
      );
    },
    MainView: (data) {
      return CupertinoPageRoute<dynamic>(
        builder: (context) => const MainView(),
        settings: data,
      );
    },
    SkriningView: (data) {
      return CupertinoPageRoute<dynamic>(
        builder: (context) => const SkriningView(),
        settings: data,
      );
    },
    PresenceView: (data) {
      var args = data.getArgs<PresenceViewArguments>(
        orElse: () => PresenceViewArguments(),
      );
      return CupertinoPageRoute<dynamic>(
        builder: (context) => PresenceView(
          key: args.key,
          faceImagePath: args.faceImagePath,
          image: args.image,
        ),
        settings: data,
      );
    },
    HistoryView: (data) {
      return CupertinoPageRoute<dynamic>(
        builder: (context) => const HistoryView(),
        settings: data,
      );
    },
    LeaveApplicationView: (data) {
      return CupertinoPageRoute<dynamic>(
        builder: (context) => const LeaveApplicationView(),
        settings: data,
      );
    },
    NewLeaveApplicationView: (data) {
      return CupertinoPageRoute<dynamic>(
        builder: (context) => const NewLeaveApplicationView(),
        settings: data,
      );
    },
    HomeFaceRecognizedView: (data) {
      var args = data.getArgs<HomeFaceRecognizedViewArguments>(nullOk: false);
      return CupertinoPageRoute<dynamic>(
        builder: (context) => HomeFaceRecognizedView(
          key: args.key,
          cameraDescription: args.cameraDescription,
        ),
        settings: data,
      );
    },
    HomeFaceRecognizedRegisView: (data) {
      var args =
          data.getArgs<HomeFaceRecognizedRegisViewArguments>(nullOk: false);
      return CupertinoPageRoute<dynamic>(
        builder: (context) => HomeFaceRecognizedRegisView(
          key: args.key,
          cameraDescription: args.cameraDescription,
        ),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// PresenceView arguments holder class
class PresenceViewArguments {
  final Key? key;
  final File? faceImagePath;
  final Widget? image;
  PresenceViewArguments({this.key, this.faceImagePath, this.image});
}

/// HomeFaceRecognizedView arguments holder class
class HomeFaceRecognizedViewArguments {
  final Key? key;
  final CameraDescription cameraDescription;
  HomeFaceRecognizedViewArguments({this.key, required this.cameraDescription});
}

/// HomeFaceRecognizedRegisView arguments holder class
class HomeFaceRecognizedRegisViewArguments {
  final Key? key;
  final CameraDescription cameraDescription;
  HomeFaceRecognizedRegisViewArguments(
      {this.key, required this.cameraDescription});
}
