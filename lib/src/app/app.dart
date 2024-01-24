import 'package:resident_app/src/services/auth_service.dart';
import 'package:resident_app/src/services/camera_service.dart';
import 'package:resident_app/src/services/customerregis_service.dart';
import 'package:resident_app/src/services/employee_service.dart';
import 'package:resident_app/src/services/ml_service.dart';
import 'package:resident_app/src/services/location_service.dart';
import 'package:resident_app/src/services/face_detector_service.dart';
import 'package:resident_app/src/ui/views/history/history_view.dart';
import 'package:resident_app/src/ui/views/home/home_face_recognized_regis_view.dart';
import 'package:resident_app/src/ui/views/home/home_face_recognized_view.dart';
import 'package:resident_app/src/ui/views/leave_application/leave_application_view.dart';
import 'package:resident_app/src/ui/views/leave_application/new_leave_application_view.dart';
import 'package:resident_app/src/ui/views/login/login_view.dart';
import 'package:resident_app/src/ui/views/main/main_view.dart';
import 'package:resident_app/src/ui/views/presence/presence_view.dart';
import 'package:resident_app/src/ui/views/skrining/skrining_view.dart';
import 'package:resident_app/src/ui/views/splash_screen/splash_screen_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: SplashScreenView, initial: true),
    MaterialRoute(page: LoginView),
    CupertinoRoute(page: MainView),
    CupertinoRoute(page: SkriningView),
    CupertinoRoute(page: PresenceView),
    CupertinoRoute(page: HistoryView),
    CupertinoRoute(page: LeaveApplicationView),
    CupertinoRoute(page: NewLeaveApplicationView),
    CupertinoRoute(page: HomeFaceRecognizedView),
    CupertinoRoute(page: HomeFaceRecognizedRegisView),
  ],
  dependencies: [
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: SnackbarService),
    LazySingleton(classType: AuthService),
    LazySingleton(classType: EmployeeService),
    LazySingleton(classType: LocationService),
    LazySingleton(classType: CustomerRegisService),
    LazySingleton(classType: CameraService),
    LazySingleton(classType: FaceDetectorService),
    LazySingleton(classType: MLService),
  ],
)
class AppSetup {
  /** Serves no purpose besides having an annotation attached to it */
  /** flutter pub run build_runner build --delete-conflicting-outputs */
}
