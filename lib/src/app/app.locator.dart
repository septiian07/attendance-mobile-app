// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedLocatorGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import '../services/auth_service.dart';
import '../services/camera_service.dart';
import '../services/customerregis_service.dart';
import '../services/employee_service.dart';
import '../services/face_detector_service.dart';
import '../services/location_service.dart';
import '../services/ml_service.dart';

final locator = StackedLocator.instance;

void setupLocator({String? environment, EnvironmentFilter? environmentFilter}) {
// Register environments
  locator.registerEnvironment(
      environment: environment, environmentFilter: environmentFilter);

// Register dependencies
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => BottomSheetService());
  locator.registerLazySingleton(() => SnackbarService());
  locator.registerLazySingleton(() => AuthService());
  locator.registerLazySingleton(() => EmployeeService());
  locator.registerLazySingleton(() => LocationService());
  locator.registerLazySingleton(() => CustomerRegisService());
  locator.registerLazySingleton(() => CameraService());
  locator.registerLazySingleton(() => FaceDetectorService());
  locator.registerLazySingleton(() => MLService());
}
