import 'dart:io';

import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:resident_app/src/app/app.locator.dart';
import 'package:resident_app/src/app/app.router.dart';
import 'package:resident_app/src/core/core_res.dart';
import 'package:resident_app/src/core/core_res_single.dart';
import 'package:resident_app/src/core/core_view_model.dart';
import 'package:resident_app/src/models/attendance.dart';
import 'package:resident_app/src/models/employee.dart';
import 'package:resident_app/src/models/message.dart';
import 'package:resident_app/src/network/network_exceptions.dart';
import 'package:resident_app/src/network/result_state.dart';
import 'package:resident_app/src/services/employee_service.dart';
import 'package:resident_app/src/services/location_service.dart';
import 'package:resident_app/src/ui/shared/strings.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:resident_app/src/ui/widgets/confirmation_presence_bottom_sheet.dart';
import 'package:stacked/stacked.dart';
import 'package:trust_location/trust_location.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:camera_snap/camera_snap.dart';
import 'package:calc_lat_long/calc_lat_long.dart';

const String _EmployeeData = 'delayedEmployee';
const String _CurrentPositionData = 'delayedCurrentPostion';
const String _AttendanceData = 'delayedAttendance';
const String _WarehouseData = 'delayedWarehouse';
const String _DeviceIdData = 'delayedDeviceId';
const String _TimeZoneData = 'delayedTimeZone';
const String _MockLocationData = 'delayedMockLocation';

class PresenceViewModel extends MultipleFutureViewModel with CoreViewModel {
  final _locationService = locator<LocationService>();
  final _employeeService = locator<EmployeeService>();
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  dynamic get fetchEmployee => dataMap?[_EmployeeData];
  dynamic get fetchCurrentPostion => dataMap?[_CurrentPositionData];
  ResultState<CoreRes<Attendance>>? get fetchAttendance =>
      dataMap?[_AttendanceData];
  ResultState<CoreRes<Employee>>? get fetchWarehouse =>
      dataMap?[_WarehouseData];
  dynamic get fetchDeviceId => dataMap?[_DeviceIdData];
  dynamic get fetchTimezone => dataMap?[_TimeZoneData];
  dynamic get fetchMockLocation => dataMap?[_MockLocationData];

  bool get fetchingEmployee => busy(_EmployeeData);
  bool get fetchingCurrentPostion => busy(_CurrentPositionData);
  bool get fetchingAttendance => busy(_AttendanceData);
  bool get fetchingWarehouse => busy(_WarehouseData);
  bool get fetchingDeviceId => busy(_DeviceIdData);
  bool get fetchingTimezone => busy(_TimeZoneData);
  bool get fetchingMockLocation => busy(_MockLocationData);

  PresenceViewModel({this.imagePicked, this.image});

  final TextEditingController remarksController =
      TextEditingController(text: '');

  // File? faceImage;
  LatLng? currentPosition;
  String? address;
  String? addressInRadius;
  Widget? image;
  File? imagePicked;
  String? deviceId;
  Employee? employee;
  List<Employee>? shiftList = [];
  List<Employee>? shiftAssignment = [];
  List<Employee>? warehouseList = [];
  List<Attendance>? attendanceList = [];
  String? logTypeValue;
  List<String> listLogType = ['IN', 'OUT'];
  bool? isMockLocation;
  Employee? selectedShift;
  String? selectedWarehouse;
  String? selectedWarehouseInRadius;
  String? currentTimeZone;
  List<Employee>? attendanceLocation = [];
  String? latAbsentLocation;
  String? longAbsentLocation;
  int? tolerance;
  String? addressData;
  List radius = [];

  @override
  Map<String, Future Function()> get futuresMap => {
        _EmployeeData: getEmployee,
        _CurrentPositionData: setCurrentPosition,
        _WarehouseData: getWarehouseList,
        _DeviceIdData: getDeviceId,
        _TimeZoneData: getTimeZone,
        _MockLocationData: getMockLocation,
      };

  Future setCurrentPosition() async {
    LatLng? currentPositionData = await _locationService.getCurrentPosition();
    currentPosition = currentPositionData;
    addressData =
        await _locationService.getAddressFromCoordinates(currentPosition);
    notifyListeners();
  }

  Future getEmployee() async {
    Employee employeeData = await _employeeService.getUser();
    employee = employeeData;
    attendanceLocation = employee?.absentLocation;
    await getAttendance(employee?.employee ?? '');
    await getShiftAssignment(employee?.name ?? '');
    notifyListeners();
  }

  Future getTimeZone() async {
    String currentTimeZoneData = await FlutterNativeTimezone.getLocalTimezone();
    currentTimeZone = currentTimeZoneData;
    notifyListeners();
  }

  Future getMockLocation() async {
    bool isMockLocationData = await TrustLocation.isMockLocation;
    isMockLocation = isMockLocationData;
    notifyListeners();
  }

  Future getDeviceId() async {
    if (Platform.isAndroid) {
      var androidInfo = await deviceInfoPlugin.androidInfo;
      deviceId = androidInfo.androidId;
      notifyListeners();
    } else if (Platform.isIOS) {
      var iosInfo = await deviceInfoPlugin.iosInfo;
      deviceId = iosInfo.identifierForVendor;
      notifyListeners();
    }
  }

  Future cameraPermission(BuildContext context) async {
    var status = await Permission.camera.status;

    if (status.isGranted) {
      onImageButtonPressed(context);
    } else {
      var request = await Permission.camera.request();
      if (request.isGranted) {
        onImageButtonPressed(context);
      } else {
        showMessageError('Permintaan kamera harus diizinkan');
      }
    }
  }

  Future onImageButtonPressed(BuildContext context) async {
    try {
      final imagePath = await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => CameraSnapScreen(),
        ),
      );

      if (imagePath != null) {
        final File toFile = File(imagePath);
        image = Image.file(
          toFile,
          fit: BoxFit.cover,
        );
        imagePicked = toFile;
        imageCache.clear();
        notifyListeners();
      } else {
        print('No image selected.');
      }
    } catch (e) {
      showMessageError(Strings.messageFailureGetImage);
    }
  }

  Future validate(String logType) async {
    if (isMockLocation == true) {
      showMessageWarning('Anda terdeteksi menggunakan Fake Location!');
      navigationService.clearStackAndShow(Routes.mainView);
    } else if (remarksController.text.isEmpty &&
        !radius.contains('In Radius') &&
        employee?.attendanceAnywhere == 1 &&
        (attendanceLocation != null || attendanceLocation != [])) {
      showMessageWarning('Harap masukan alasan absen');
    } else if (remarksController.text.isEmpty &&
        attendanceLocation!.isEmpty &&
        employee?.attendanceAnywhere == 1) {
      showMessageWarning('Harap masukan alasan/tempat absen');
    } else {
      await uploadImage(logType);
    }
    notifyListeners();
  }

  Future<ResultState<Message>> uploadImage(String logType) async {
    setBusy(true);
    var result = await _employeeService.uploadImage(imagePicked!);
    setBusy(false);
    return result.when(
      success: (Message data) async {
        await checkinEmployee(data.message?.fileUrl ?? '', logType);
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

  Future<ResultState<CoreRes<Employee>>> getShiftList() async {
    var result = await _employeeService.fetchShift();
    return result.when(
      success: (CoreRes<Employee> data) async {
        shiftList = data.data;
        notifyListeners();
        return ResultState.data(data: data);
      },
      failure: (NetworkExceptions error, String? message) async {
        return ResultState.error(error: error);
      },
    );
  }

  Future<ResultState<CoreRes<Employee>>> getShiftAssignment(
      String employee) async {
    var result =
        await _employeeService.fetchShiftAssignment(employee, formattedDateAPI);
    return result.when(
      success: (CoreRes<Employee> data) async {
        shiftAssignment = data.data;
        selectedShift = data.data?.first;
        notifyListeners();
        return ResultState.data(data: data);
      },
      failure: (NetworkExceptions error, String? message) async {
        return ResultState.error(error: error);
      },
    );
  }

  Future<ResultState<CoreRes<Employee>>> getAttendanceLocation(
    String locationName,
  ) async {
    var result = await _employeeService.fetchAttendanceLocation(locationName);
    return result.when(
      success: (CoreRes<Employee> data) async {
        latAbsentLocation = data.data?.first.latitude;
        longAbsentLocation = data.data?.first.longitude;
        tolerance = data.data?.first.tolerance;
        notifyListeners();
        return ResultState.data(data: data);
      },
      failure: (NetworkExceptions error, String? message) async {
        return ResultState.error(error: error);
      },
    );
  }

  Future<ResultState<CoreRes<Attendance>>> getAttendance(
      String employeeCode) async {
    var result = await _employeeService.fetchAttendance(
      employeeCode,
      formattedDateAPI,
    );
    return result.when(
      success: (CoreRes<Attendance> data) async {
        notifyListeners();
        return ResultState.data(data: data);
      },
      failure: (NetworkExceptions error, String? message) async {
        return ResultState.error(error: error);
      },
    );
  }

  Future<ResultState<CoreRes<Employee>>> getWarehouseList() async {
    var result = await _employeeService.fetchWarehouse();
    return result.when(
      success: (CoreRes<Employee> data) async {
        warehouseList = data.data;
        notifyListeners();
        return ResultState.data(data: data);
      },
      failure: (NetworkExceptions error, String? message) async {
        return ResultState.error(error: error);
      },
    );
  }

  Future<ResultState<Employee>> checkinEmployee(
      String imagePath, String logType) async {
    setBusy(true);
    var result = await _employeeService.checkin(
      employee?.employee ?? '',
      employee?.employeeName ?? '',
      logType,
      selectedShift,
      radius.contains('In Radius')
          ? selectedWarehouseInRadius
          : selectedWarehouse,
      dateTimeNow,
      deviceId,
      currentPosition?.longitude.toString(),
      currentPosition?.latitude.toString(),
      imagePath,
      currentTimeZone,
      remarksController.text,
    );
    setBusy(false);
    return result.when(
      success: (CoreResSingle<Employee> data) async {
        showMessageSuccess('Data Anda telah direkap');
        navigationService.clearStackAndShow(Routes.mainView);
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

  Future checkDistanceLocation(
    BuildContext context,
    PresenceViewModel vm,
  ) async {
    if (attendanceLocation == null ||
        attendanceLocation == [] ||
        attendanceLocation!.isEmpty) {
      if (employee?.attendanceAnywhere == 1) {
        address = addressData;
        selectedWarehouse = address;
        showConfirmation(context, vm);
      } else {
        showMessageWarning(
            'Anda di luar radius absensi dan tidak dapat ijin untuk absen dimana saja');
      }
      notifyListeners();
    } else {
      radius = [];
      for (var item in attendanceLocation!) {
        var dist = CalcDistance.distance(
          currentPosition?.latitude ?? 0,
          double.parse(item.latitude ?? '0'),
          currentPosition?.longitude ?? 0,
          double.parse(item.longitude ?? '0'),
          UnitLength.km,
        );

        if ((dist * 1000) <= item.tolerance ?? 0) {
          radius.add('In Radius');
          addressInRadius = '${item.locationName ?? ''}, ${addressData ?? ''}';
          selectedWarehouseInRadius = addressInRadius;
        } else {
          radius.add('Out of Radius');
          address = addressData;
          selectedWarehouse = address;
        }
      }

      if (radius.contains('In Radius')) {
        showConfirmation(context, vm);
      } else if (!radius.contains('In Radius') &&
          employee?.attendanceAnywhere == 1) {
        showConfirmation(context, vm);
      } else {
        showMessageWarning(
            'Anda di luar radius absensi dan tidak dapat ijin untuk absen dimana saja');
      }
      notifyListeners();
    }
  }

  void showConfirmation(
    BuildContext context,
    PresenceViewModel vm,
  ) {
    showStickyFlexibleBottomSheet<void>(
      minHeight: 0,
      initHeight: 0.6,
      maxHeight: 0.9,
      headerHeight: 26.0,
      context: context,
      isDismissible: false,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30.0),
        ),
      ),
      anchors: [.7],
      headerBuilder: (BuildContext context, double offset) {
        return Container();
      },
      bodyBuilder: (BuildContext context, double bottomSheetOffset) {
        return SliverChildListDelegate(
          [ConfirmationPresenceBottomSheet(vm: vm)],
        );
      },
    );
  }
}
