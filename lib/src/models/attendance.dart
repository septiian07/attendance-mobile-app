import 'package:json_annotation/json_annotation.dart';

part 'attendance.g.dart';

@JsonSerializable()
class Attendance {
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'employee')
  String? employee;
  @JsonKey(name: 'employee_name')
  String? employeeName;
  @JsonKey(name: 'status')
  String? status;
  @JsonKey(name: 'attendance_date')
  String? attendanceDate;

  Attendance({
    this.name,
    this.employee,
    this.employeeName,
    this.status,
    this.attendanceDate,
  });

  factory Attendance.fromJson(Map<String, dynamic> json) =>
      _$AttendanceFromJson(json);

  Map<String, dynamic> toJson() => _$AttendanceToJson(this);
}
