import 'package:json_annotation/json_annotation.dart';

part 'attendance_req.g.dart';

@JsonSerializable()
class AttendanceReq {
  @JsonKey(name: 'series')
  String series = "HR-ATT-.YYYY.-";

  @JsonKey(name: 'company')
  String company = "ABC";

  @JsonKey(name: 'status')
  String? status;

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'employee')
  String? employeeCode;

  @JsonKey(name: 'attendance_date')
  String? attendanceDate;

  @JsonKey(name: 'docstatus')
  int? docStatus;

  @JsonKey(name: 'shift')
  String? shift;

  AttendanceReq({
    this.employeeCode,
    this.attendanceDate,
    this.status,
    this.docStatus,
    this.shift,
  });

  factory AttendanceReq.fromJson(Map<String, dynamic> json) =>
      _$AttendanceReqFromJson(json);

  Map<String, dynamic> toJson() => _$AttendanceReqToJson(this);
}
