import 'package:json_annotation/json_annotation.dart';

part 'leave_type.g.dart';

@JsonSerializable()
class LeaveType {
  @JsonKey(name: 'message')
  LeaveType? message;
  @JsonKey(name: 'leave_allocation')
  Object? leaveAllocation;
  @JsonKey(name: 'leave_approver')
  String? leaveApprover;
  @JsonKey(name: 'lwps')
  List<String>? leaveTypeList;

  LeaveType({
    this.message,
    this.leaveAllocation,
    this.leaveApprover,
    this.leaveTypeList,
  });

  factory LeaveType.fromJson(Map<String, dynamic> json) =>
      _$LeaveTypeFromJson(json);

  Map<String, dynamic> toJson() => _$LeaveTypeToJson(this);
}
