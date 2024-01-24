import 'package:dio/dio.dart';
import 'package:resident_app/src/constant/config.dart';
import 'package:resident_app/src/core/core_res.dart';
import 'package:resident_app/src/core/core_res_single.dart';
import 'package:resident_app/src/helpers/http_helper.dart';
import 'package:resident_app/src/models/attendance.dart';
import 'package:resident_app/src/models/auth.dart';
import 'package:resident_app/src/models/employee.dart';
import 'package:resident_app/src/models/leave_type.dart';
import 'package:resident_app/src/models/message.dart';
import 'package:retrofit/http.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: Config.baseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String? baseUrl}) {
    dio.interceptors.add(HttpHelper().getDioInterceptor());
    return _ApiService(dio, baseUrl: baseUrl);
  }

  @POST("method/login")
  Future<Auth> auth(@Body() Map<String, dynamic> body);

  @GET("resource/Employee")
  Future<CoreRes<Employee>> getEmployee({
    @Query('filters') String? filters,
    @Query('fields') String? fields,
  });

  @GET("resource/Employee/{employee}")
  Future<CoreResSingle<Employee>> getEmployeeWithoutFilters(
    @Path("employee") String employee,
  );

  @PUT("resource/Employee/{employee}")
  Future<CoreResSingle<Employee>> setEmployee(
    @Path("employee") String employee,
    @Body() Map<String, dynamic> body,
  );

  @POST("resource/Skrining CV19")
  Future<CoreResSingle<Employee>> skrining(@Body() Map<String, dynamic> body);

  @POST("resource/Employee Checkin")
  Future<CoreResSingle<Employee>> checkin(@Body() Map<String, dynamic> body);

  @POST("resource/Attendance")
  Future<CoreResSingle<Attendance>> present(@Body() Map<String, dynamic> body);

  @POST("resource/Leave Application")
  Future<CoreResSingle<Employee>> leaveApplication(
      @Body() Map<String, dynamic> body);

  @GET("resource/Employee Checkin")
  Future<CoreRes<Employee>> checkinList({
    @Query('filters') String? filters,
    @Query('fields') String? fields,
    @Query('order_by') String? orderBy,
  });

  @GET("resource/Skrining CV19")
  Future<CoreRes<Employee>> skriningList({
    @Query('filters') String? filters,
    @Query('fields') String? fields,
  });

  @GET("resource/Shift Type")
  Future<CoreRes<Employee>> shiftList({
    @Query('fields') String? fields,
  });

  @GET("resource/Shift Assignment")
  Future<CoreRes<Employee>> shiftAssigment({
    @Query('filters') String? filters,
    @Query('fields') String? fields,
  });

  @GET("resource/Attendance Location")
  Future<CoreRes<Employee>> getAttendanceLocation({
    @Query('filters') String? filters,
    @Query('fields') String? fields,
  });

  @GET("resource/Warehouse")
  Future<CoreRes<Employee>> warehouseList({
    @Query('fields') String? fields,
    @Query('limit_page_length') int? limitPageLength,
  });

  @GET("resource/Attendance")
  Future<CoreRes<Attendance>> getAttendance({
    @Query('filters') String? filters,
    @Query('fields') String? fields,
  });

  @GET("resource/Leave Application")
  Future<CoreRes<Employee>> leaveApplicationList({
    @Query('filters') String? filters,
    @Query('fields') String? fields,
    @Query('order_by') String? orderBy,
  });

  @POST(
      "method/erpnext.hr.doctype.leave_application.leave_application.get_leave_details")
  Future<LeaveType> leaveTypeList(@Body() Map<String, dynamic> body);

  @GET("resource/Salary Slip")
  Future<CoreRes<Employee>> salarySlipList({
    @Query('fields') String? fields,
  });

  @POST("method/upload_file")
  Future<Message> upload(@Body() FormData body);
}
