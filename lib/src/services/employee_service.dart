import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:resident_app/src/constant/session.dart';

import 'package:resident_app/src/core/core_res.dart';
import 'package:resident_app/src/core/core_res_single.dart';
import 'package:resident_app/src/core/core_service.dart';
import 'package:resident_app/src/models/attendance.dart';

import 'package:resident_app/src/models/employee.dart';
import 'package:resident_app/src/models/leave_type.dart';
import 'package:resident_app/src/models/message.dart';

import 'package:resident_app/src/network/api_result.dart';
import 'package:resident_app/src/network/network_exceptions.dart';
import 'package:resident_app/src/network/requests/checkin_req.dart';
import 'package:resident_app/src/network/requests/leave_application_req.dart';
import 'package:resident_app/src/network/requests/skrining_req.dart';
import 'package:resident_app/src/network/requests/attendance_req.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked_annotations.dart';

@LazySingleton()
class EmployeeService extends CoreService {
  Future<ApiResult<CoreRes<Employee>>> fetchEmployee(String email) async {
    try {
      var filters = '[["user_id","=","' + email + '"]]';
      var fields = '["*"]';
      var result = await apiService.getEmployee(
        filters: filters,
        fields: fields,
      );
      return ApiResult.success(data: result);
    } catch (e) {
      return ApiResult.failure(
        error: NetworkExceptions.getDioException(e),
        message: NetworkExceptions.getMessage(e, false),
      );
    }
  }

  Future<ApiResult<CoreResSingle<Employee>>> fetchEmployeeWithoutFilters(
      String employee) async {
    try {
      var result = await apiService.getEmployeeWithoutFilters(employee);
      saveUser(result.data);
      return ApiResult.success(data: result);
    } catch (e) {
      return ApiResult.failure(
        error: NetworkExceptions.getDioException(e),
        message: NetworkExceptions.getMessage(e, false),
      );
    }
  }

  Future<ApiResult<CoreResSingle<Employee>>> setEmployee(
      String employee, String faceData) async {
    try {
      final Map<String, dynamic> body = {
        "face_data": faceData,
      };
      var result = await apiService.setEmployee(employee, body);
      saveUser(result.data);
      return ApiResult.success(data: result);
    } catch (e) {
      return ApiResult.failure(
        error: NetworkExceptions.getDioException(e),
        message: NetworkExceptions.getMessage(e, false),
      );
    }
  }

  Future<void> saveUser(Employee? data) async {
    final Employee? user = data;

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(Session.user, jsonEncode(user));
  }

  Future<void> saveAttendance(Attendance? data) async {
    final Attendance? attendance = data;

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(Session.attendance, jsonEncode(attendance));
  }

  Future<Attendance?> getAttendance() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    Map<String, dynamic> attendanceMap;
    if (prefs.getString(Session.attendance) != null) {
      final String attendancStr = prefs.getString(Session.attendance)!;
      attendanceMap = jsonDecode(attendancStr) as Map<String, dynamic>;

      final Attendance attendance = Attendance.fromJson(attendanceMap);
      return attendance;
    } else {
      return null;
    }
  }

  Future<Employee> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    Map<String, dynamic> userMap;
    final String userStr = prefs.getString(Session.user)!;
    userMap = jsonDecode(userStr) as Map<String, dynamic>;

    final Employee user = Employee.fromJson(userMap);
    return user;
  }

  Future<ApiResult<CoreResSingle<Employee>>> skrining(
    String namingSeries,
    String employee,
    String employeeName,
    String date,
    String healthy,
    String bodyTemperature,
    String coughOrCold,
    String soreThroat,
    String outOfBreath,
    String outOfTownCity,
    String doctype,
  ) async {
    try {
      var data = SkriningReq(
        namingSeries: namingSeries,
        employee: employee,
        employeeName: employeeName,
        date: date,
        healthy: healthy,
        bodyTemperature: bodyTemperature,
        coughOrCold: coughOrCold,
        soreThroat: soreThroat,
        outOfBreath: outOfBreath,
        outOfTownCity: outOfTownCity,
        doctype: doctype,
      ).toJson();
      var result = await apiService.skrining(data);
      return ApiResult.success(data: result);
    } catch (e) {
      return ApiResult.failure(
        error: NetworkExceptions.getDioException(e),
        message: NetworkExceptions.getMessage(e, false),
      );
    }
  }

  Future<ApiResult<Message>> uploadImage(File imageLink) async {
    try {
      var formData = FormData.fromMap({
        "file": MultipartFile.fromFileSync(imageLink.path),
      });
      var result = await apiService.upload(formData);
      return ApiResult.success(data: result);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult<CoreResSingle<Employee>>> checkin(
    String? employee,
    String? employeeName,
    String? logType,
    Employee? shift,
    String? warehouse,
    String? time,
    String? deviceId,
    String? longitude,
    String? latitude,
    String? selfieImage,
    String? timeZone,
    String? remarks,
  ) async {
    try {
      var data = CheckinReq(
        employee: employee,
        employeeName: employeeName,
        logType: logType,
        time: time,
        deviceId: deviceId,
        longitude: longitude,
        latitude: latitude,
        selfieImage: selfieImage,
        timeZone: timeZone,
        warehouse: warehouse,
        remarks: remarks,
      );

      var resultAttendance;
      var att = await getAttendance();
      if (att == null) {
        var attendance = AttendanceReq(
          employeeCode: employee,
          attendanceDate: time,
          status: "Present",
          docStatus: 1,
          shift: shift?.shiftType ?? '',
        );
        resultAttendance = await apiService.present(attendance.toJson());
        data.attendance = resultAttendance.data?.name;
        saveAttendance(resultAttendance.data);
      } else {
        data.attendance = att.name;
      }
      var result = await apiService.checkin(data.toJson());
      saveUser(result.data);
      return ApiResult.success(data: result);
    } catch (e) {
      log("${e}");
      return ApiResult.failure(
        error: NetworkExceptions.getDioException(e),
        message: NetworkExceptions.getMessage(e, false),
      );
    }
  }

  Future<ApiResult<CoreResSingle<Employee>>> leaveApplication(
    String namingSeries,
    String employee,
    String leaveType,
    String fromDate,
    String toDate,
    String reason,
    String leaveApprover,
    String status,
    String salarySlip,
    String postingDate,
    String company,
    String workflowState,
    String proofFileOrPhoto,
  ) async {
    try {
      var data = LeaveApplicationReq(
        namingSeries: namingSeries,
        employee: employee,
        leaveType: leaveType,
        fromDate: fromDate,
        toDate: toDate,
        reason: reason,
        leaveApprover: leaveApprover,
        status: status,
        salarySlip: salarySlip,
        postingDate: postingDate,
        company: company,
        workflowState: workflowState,
        proofFileOrPhoto: proofFileOrPhoto,
      ).toJson();
      var result = await apiService.leaveApplication(data);
      return ApiResult.success(data: result);
    } catch (e) {
      return ApiResult.failure(
        error: NetworkExceptions.getDioException(e),
        message: NetworkExceptions.getMessage(e, false),
      );
    }
  }

  Future<ApiResult<CoreRes<Employee>>> fetchLeaveApplicationList(
    String employee,
  ) async {
    try {
      var filters = '[["employee","=","' + employee + '"]]';
      var fields = '["*"]';
      var result = await apiService.leaveApplicationList(
        filters: filters,
        fields: fields,
        orderBy: 'creation desc',
      );
      return ApiResult.success(data: result);
    } catch (e) {
      return ApiResult.failure(
        error: NetworkExceptions.getDioException(e),
        message: NetworkExceptions.getMessage(e, false),
      );
    }
  }

  Future<ApiResult<CoreRes<Employee>>> fetchHistoryCheckin(
    String employee,
    String date,
  ) async {
    try {
      var filters = date != ''
          ? '[["employee","=","' +
              employee +
              '"],["creation",">=","' +
              date +
              ' 00:00:00"],["creation","<=","' +
              date +
              ' 23:59:59"]]'
          : '[["employee","=","' + employee + '"]]';

      var fields = '["*"]';
      var result = await apiService.checkinList(
        filters: filters,
        fields: fields,
        orderBy: 'creation desc',
      );
      return ApiResult.success(data: result);
    } catch (e) {
      return ApiResult.failure(
        error: NetworkExceptions.getDioException(e),
        message: NetworkExceptions.getMessage(e, false),
      );
    }
  }

  Future<ApiResult<CoreRes<Employee>>> fetchHistorySkrining(
    String employee,
  ) async {
    try {
      var filters = '[["employee","=","' + employee + '"]]';
      var fields = '["*"]';
      var result = await apiService.skriningList(
        filters: filters,
        fields: fields,
      );
      return ApiResult.success(data: result);
    } catch (e) {
      return ApiResult.failure(
        error: NetworkExceptions.getDioException(e),
        message: NetworkExceptions.getMessage(e, false),
      );
    }
  }

  Future<ApiResult<CoreRes<Employee>>> fetchShift() async {
    try {
      var fields = '["*"]';
      var result = await apiService.shiftList(fields: fields);
      return ApiResult.success(data: result);
    } catch (e) {
      return ApiResult.failure(
        error: NetworkExceptions.getDioException(e),
        message: NetworkExceptions.getMessage(e, false),
      );
    }
  }

  Future<ApiResult<CoreRes<Employee>>> fetchShiftAssignment(
    String employee,
    String dateNow,
  ) async {
    try {
      var filters =
          '[["employee","=","$employee"],["start_date",">=","$dateNow"],["start_date","<=","$dateNow"]]';
      var fields = '["*"]';
      var result =
          await apiService.shiftAssigment(filters: filters, fields: fields);
      return ApiResult.success(data: result);
    } catch (e) {
      return ApiResult.failure(
        error: NetworkExceptions.getDioException(e),
        message: NetworkExceptions.getMessage(e, false),
      );
    }
  }

  Future<ApiResult<CoreRes<Employee>>> fetchAttendanceLocation(
    String locationName,
  ) async {
    try {
      var filters = '[["name","=","$locationName"]]';
      var fields = '["*"]';
      var result = await apiService.getAttendanceLocation(
        filters: filters,
        fields: fields,
      );
      return ApiResult.success(data: result);
    } catch (e) {
      return ApiResult.failure(
        error: NetworkExceptions.getDioException(e),
        message: NetworkExceptions.getMessage(e, false),
      );
    }
  }

  Future<ApiResult<CoreRes<Attendance>>> fetchAttendance(
    String employee,
    String time,
  ) async {
    try {
      var filters =
          '[["employee","=","$employee"],["attendance_date","=","$time"]]';
      var fields = '["*"]';
      var result = await apiService.getAttendance(
        filters: filters,
        fields: fields,
      );
      saveAttendance(result.data?.first);
      return ApiResult.success(data: result);
    } catch (e) {
      return ApiResult.failure(
        error: NetworkExceptions.getDioException(e),
        message: NetworkExceptions.getMessage(e, false),
      );
    }
  }

  Future<ApiResult<CoreRes<Employee>>> fetchWarehouse() async {
    try {
      var fields = '["*"]';
      var limitPageLength = 10000;
      var result = await apiService.warehouseList(
        fields: fields,
        limitPageLength: limitPageLength,
      );
      return ApiResult.success(data: result);
    } catch (e) {
      return ApiResult.failure(
        error: NetworkExceptions.getDioException(e),
        message: NetworkExceptions.getMessage(e, false),
      );
    }
  }

  Future<ApiResult<LeaveType>> fetchLeaveType(
      String employee, String date) async {
    try {
      final Map<String, dynamic> body = {
        "employee": employee,
        "date": date,
      };
      var result = await apiService.leaveTypeList(body);
      return ApiResult.success(data: result);
    } catch (e) {
      return ApiResult.failure(
        error: NetworkExceptions.getDioException(e),
        message: NetworkExceptions.getMessage(e, false),
      );
    }
  }

  Future<ApiResult<CoreRes<Employee>>> fetchSalarySlip() async {
    try {
      var fields = '["*"]';
      var result = await apiService.salarySlipList(fields: fields);
      return ApiResult.success(data: result);
    } catch (e) {
      return ApiResult.failure(
        error: NetworkExceptions.getDioException(e),
        message: NetworkExceptions.getMessage(e, false),
      );
    }
  }
}
