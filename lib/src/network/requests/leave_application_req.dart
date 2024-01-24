import 'package:json_annotation/json_annotation.dart';

part 'leave_application_req.g.dart';

@JsonSerializable()
class LeaveApplicationReq {
  @JsonKey(name: 'naming_series')
  String? namingSeries;
  @JsonKey(name: 'employee')
  String? employee;
  @JsonKey(name: 'leave_type')
  String? leaveType;
  @JsonKey(name: 'from_date')
  String? fromDate;
  @JsonKey(name: 'to_date')
  String? toDate;
  @JsonKey(name: 'description')
  String? reason;
  @JsonKey(name: 'leave_approver')
  String? leaveApprover;
  @JsonKey(name: 'status')
  String? status;
  @JsonKey(name: 'salary_slip')
  String? salarySlip;
  @JsonKey(name: 'posting_date')
  String? postingDate;
  @JsonKey(name: 'company')
  String? company;
  @JsonKey(name: 'workflow_state')
  String? workflowState;
  @JsonKey(name: 'upload_bukti')
  String? proofFileOrPhoto;

  LeaveApplicationReq({
    this.namingSeries,
    this.employee,
    this.leaveType,
    this.fromDate,
    this.toDate,
    this.reason,
    this.leaveApprover,
    this.status,
    this.salarySlip,
    this.postingDate,
    this.company,
    this.workflowState,
    this.proofFileOrPhoto,
  });

  factory LeaveApplicationReq.fromJson(Map<String, dynamic> json) =>
      _$LeaveApplicationReqFromJson(json);

  Map<String, dynamic> toJson() => _$LeaveApplicationReqToJson(this);
}
