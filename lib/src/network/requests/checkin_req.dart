import 'package:json_annotation/json_annotation.dart';
import 'package:resident_app/src/models/employee.dart';

part 'checkin_req.g.dart';

@JsonSerializable()
class CheckinReq {
  @JsonKey(name: 'attendance')
  String? attendance;
  @JsonKey(name: 'employee')
  String? employee;
  @JsonKey(name: 'employee_name')
  String? employeeName;
  @JsonKey(name: 'log_type')
  String? logType;
  @JsonKey(name: 'shift')
  Employee? shift;
  @JsonKey(name: 'warehouse')
  String? warehouse;
  @JsonKey(name: 'time')
  String? time;
  @JsonKey(name: 'device_id')
  String? deviceId;
  @JsonKey(name: 'geo_longitude')
  String? longitude;
  @JsonKey(name: 'geo_latitude')
  String? latitude;
  @JsonKey(name: 'selfie_image')
  String? selfieImage;
  @JsonKey(name: 'time_zone')
  String? timeZone;
  @JsonKey(name: 'remarks')
  String? remarks;

  CheckinReq({
    this.employee,
    this.employeeName,
    this.logType,
    this.shift,
    this.warehouse,
    this.time,
    this.deviceId,
    this.longitude,
    this.latitude,
    this.selfieImage,
    this.timeZone,
    this.remarks,
  });

  factory CheckinReq.fromJson(Map<String, dynamic> json) =>
      _$CheckinReqFromJson(json);

  Map<String, dynamic> toJson() => _$CheckinReqToJson(this);
}
