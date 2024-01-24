import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:resident_app/src/app/app.locator.dart';
import 'package:resident_app/src/app/app.router.dart';
import 'package:resident_app/src/constant/session.dart';
import 'package:resident_app/src/core/core_res.dart';
import 'package:resident_app/src/core/core_res_single.dart';
import 'package:resident_app/src/core/core_view_model.dart';
import 'package:resident_app/src/models/employee.dart';
import 'package:resident_app/src/network/network_exceptions.dart';
import 'package:resident_app/src/network/result_state.dart';
import 'package:resident_app/src/services/employee_service.dart';
import 'package:resident_app/src/services/ml_service.dart';
import 'package:stacked/stacked.dart';
import 'package:trust_location/trust_location.dart';

class HomeViewModel extends FutureViewModel with CoreViewModel {
  final _employeeService = locator<EmployeeService>();
  final MLService _mlService = locator<MLService>();


  File? faceImagePath;
  Widget? image;
  String? fullName;
  Employee? employee;
  bool? isMockLocation;
  Employee? predictEmployee;

  @override
  Future futureToRun() => getEmployee();

  Future<ResultState<CoreRes<Employee>>> getEmployee() async {
    getMockLocation();
    String? email = sharedPreferencesHelper.getString(Session.userId);
    var result = await _employeeService.fetchEmployee(email ?? '');
    return result.when(
      success: (CoreRes<Employee> data) async {
        await getEmployeeWithoutFilters(data.data?.first.name ?? '');
        notifyListeners();
        setName();
        return ResultState.data(data: data);
      },
      failure: (
        NetworkExceptions error,
        String? message,
      ) async {
        notifyListeners();
        return ResultState.error(error: error);
      },
    );
  }

  Future<ResultState<CoreResSingle<Employee>>> getEmployeeWithoutFilters(
      String employeeCode) async {
    var result =
        await _employeeService.fetchEmployeeWithoutFilters(employeeCode);
    return result.when(
      success: (CoreResSingle<Employee> data) async {
        employee = data.data;
        notifyListeners();
        setName();
        return ResultState.data(data: data);
      },
      failure: (
        NetworkExceptions error,
        String? message,
      ) async {
        notifyListeners();
        return ResultState.error(error: error);
      },
    );
  }

  Future registerFace(context) async {
    List? predictedData = _mlService.predictedData;

    setBusy(true);
    var result = await _employeeService.setEmployee(
      employee?.employee ?? '',
      predictedData.toString(),
    );
    setBusy(false);

    return result.when(
      success: (CoreResSingle<Employee> data) async {
        showMessageSuccess('Wajah Anda telah didaftarkan');

        this._mlService.setPredictedData(null);
        toMain();
        notifyListeners();
        return ResultState.data(data: data.data!);
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

  Future<String?>? predictUser() async {
    return await _mlService.predict();
  }

  Future getMockLocation() async {
    bool isMockLocationData = await TrustLocation.isMockLocation;
    isMockLocation = isMockLocationData;
  }

  Future setName() async {
    fullName = sharedPreferencesHelper.getString(Session.userName);
    notifyListeners();
  }

  Future checkFaceRecognized(
    BuildContext context,
    CameraDescription cameraDescription,
  ) async {
    if (employee?.faceData == null || employee?.faceData == '') {
      toFaceRegis(cameraDescription);
    } else {
      toFaceDetect(cameraDescription);
    }
  }

  void toMain() => navigationService.clearStackAndShow(Routes.mainView);

  void toFaceRegis(
    CameraDescription cameraDescription,
  ) =>
      navigationService.navigateTo(
        Routes.homeFaceRecognizedRegisView,
        arguments: HomeFaceRecognizedRegisViewArguments(
          cameraDescription: cameraDescription,
        ),
      );

  void toFaceDetect(
    CameraDescription cameraDescription,
  ) =>
      navigationService.navigateTo(
        Routes.homeFaceRecognizedView,
        arguments: HomeFaceRecognizedViewArguments(
          cameraDescription: cameraDescription,
        ),
      );

  void showPresence() => navigationService.navigateTo(Routes.presenceView,
      arguments:
          PresenceViewArguments(faceImagePath: faceImagePath, image: image));

  void showSkrining() => navigationService.navigateTo(Routes.skriningView);

  void showHistory() => navigationService.navigateTo(Routes.historyView);

  void showLeaveApplication() =>
      navigationService.navigateTo(Routes.leaveApplicationView);

}
