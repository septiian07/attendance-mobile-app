import 'package:json_annotation/json_annotation.dart';

part 'employee.g.dart';

@JsonSerializable()
class Employee {
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'creation')
  String? creation;
  @JsonKey(name: 'modified')
  String? modified;
  @JsonKey(name: 'modified_by')
  String? modifiedBy;
  @JsonKey(name: 'owner')
  String? owner;
  @JsonKey(name: 'docstatus')
  int? docStatus;
  @JsonKey(name: 'idx')
  int? idx;
  @JsonKey(name: 'employee')
  String? employee;
  @JsonKey(name: 'naming_series')
  String? namingSeries;
  @JsonKey(name: 'first_name')
  String? firstName;
  @JsonKey(name: 'middle_name')
  String? middleName;
  @JsonKey(name: 'last_name')
  String? lastName;
  @JsonKey(name: 'salutation')
  String? salutation;
  @JsonKey(name: 'employee_name')
  String? employeeName;
  @JsonKey(name: 'employment_type')
  String? employmentType;
  @JsonKey(name: 'image')
  String? image;
  @JsonKey(name: 'company')
  String? company;
  @JsonKey(name: 'status')
  String? status;
  @JsonKey(name: 'gender')
  String? gender;
  @JsonKey(name: 'date_of_birth')
  String? dateOfBirth;
  @JsonKey(name: 'date_of_joining')
  String? dateOfJoining;
  @JsonKey(name: 'user_id')
  String? userId;
  @JsonKey(name: 'create_user_permission')
  int? createUserPermission;
  @JsonKey(name: 'notice_number_of_days')
  int? noticeNumberOfDays;
  @JsonKey(name: 'date_of_retirement')
  String? dateOfRetirement;
  @JsonKey(name: 'from_date')
  String? fromDate;
  @JsonKey(name: 'to_date')
  String? toDate;
  @JsonKey(name: 'description')
  String? desc;
  @JsonKey(name: 'workflow_state')
  String? workflowState;
  @JsonKey(name: 'leave_approver')
  String? leaveApprover;
  @JsonKey(name: 'prefered_email')
  String? preferedEmail;
  @JsonKey(name: 'unsubscribed')
  int? unsubscribed;
  @JsonKey(name: 'sehat1')
  String? healthy;
  @JsonKey(name: 'suhu_tubuh')
  String? bodyTemperature;
  @JsonKey(name: 'ada_batuk_atau_pilek')
  String? coughOrCold;
  @JsonKey(name: 'nyeri_tenggorokan')
  String? soreThroat;
  @JsonKey(name: 'sesak_nafas')
  String? outOfBreath;
  @JsonKey(name: '14_terakhir_ada_keluar_kotanegeri')
  String? outOfTownCity;
  @JsonKey(name: 'doctype')
  String? doctype;
  @JsonKey(name: 'date')
  String? date;
  @JsonKey(name: 'log_type')
  String? logType;
  @JsonKey(name: 'shift')
  String? shift;
  @JsonKey(name: 'shift_type')
  String? shiftType;
  @JsonKey(name: 'warehouse')
  String? warehouse;
  @JsonKey(name: 'time')
  String? time;
  @JsonKey(name: 'device_id')
  String? deviceId;
  @JsonKey(name: 'selfie_image')
  String? selfieImage;
  @JsonKey(name: 'geo_longitude')
  String? geoLongitude;
  @JsonKey(name: 'geo_latitude')
  String? geoLatitude;
  @JsonKey(name: 'file_name')
  String? fileName;
  @JsonKey(name: 'is_private')
  int? isPrivate;
  @JsonKey(name: 'is_home_folder')
  int? isHomeFolder;
  @JsonKey(name: 'is_attachments_folder')
  int? isAttachmentsFolder;
  @JsonKey(name: 'file_size')
  int? fileSize;
  @JsonKey(name: 'file_url')
  String? fileUrl;
  @JsonKey(name: 'folder')
  String? folder;
  @JsonKey(name: 'is_folder')
  int? isFolder;
  @JsonKey(name: 'content_hash')
  String? contentHash;
  @JsonKey(name: 'uploaded_to_dropbox')
  int? uploadedToDropbox;
  @JsonKey(name: 'uploaded_to_google_drive')
  int? uploadedToGoogleDrive;
  @JsonKey(name: 'start_time')
  String? startTime;
  @JsonKey(name: 'end_time')
  String? endTime;
  @JsonKey(name: 'holiday_list')
  String? holidayList;
  @JsonKey(name: 'enable_auto_attendance')
  int? enableAutoAttendance;
  @JsonKey(name: 'determine_check_in_and_check_out')
  String? determineCheckInAndCheckOut;
  @JsonKey(name: 'working_hours_calculation_based_on')
  String? workingHoursCalculationBasedOn;
  @JsonKey(name: 'begin_check_in_before_shift_start_time')
  int? beginCheckInBeforeShiftStartTime;
  @JsonKey(name: 'allow_check_out_after_shift_end_time')
  int? allowCheckOutAfterShiftEndTime;
  @JsonKey(name: 'working_hours_threshold_for_half_day')
  double? workingHoursThresholdForHalfDay;
  @JsonKey(name: 'working_hours_threshold_for_absent')
  double? workingHoursThresholdForAbsent;
  @JsonKey(name: 'enable_entry_grace_period')
  int? enableEntryGracePeriod;
  @JsonKey(name: 'late_entry_grace_period')
  int? lateEntryGracePeriod;
  @JsonKey(name: 'enable_exit_grace_period')
  int? enableExitGracePeriod;
  @JsonKey(name: 'early_exit_grace_period')
  int? earlyExitGracePeriod;
  @JsonKey(name: 'face_data')
  String? faceData;
  @JsonKey(name: 'attendance_anywhere')
  int? attendanceAnywhere;
  @JsonKey(name: 'lokasi_absen')
  List<Employee>? absentLocation;
  @JsonKey(name: 'nama_lokasi')
  String? locationName;
  @JsonKey(name: 'latitude')
  String? latitude;
  @JsonKey(name: 'longitude')
  String? longitude;
  @JsonKey(name: 'tolerance')
  int? tolerance;

  Employee({
    this.name,
    this.creation,
    this.modified,
    this.modifiedBy,
    this.owner,
    this.docStatus,
    this.idx,
    this.employee,
    this.namingSeries,
    this.firstName,
    this.middleName,
    this.lastName,
    this.salutation,
    this.employeeName,
    this.employmentType,
    this.image,
    this.company,
    this.status,
    this.gender,
    this.dateOfBirth,
    this.dateOfJoining,
    this.userId,
    this.createUserPermission,
    this.noticeNumberOfDays,
    this.dateOfRetirement,
    this.fromDate,
    this.toDate,
    this.desc,
    this.workflowState,
    this.leaveApprover,
    this.preferedEmail,
    this.unsubscribed,
    this.healthy,
    this.bodyTemperature,
    this.coughOrCold,
    this.soreThroat,
    this.outOfBreath,
    this.outOfTownCity,
    this.doctype,
    this.date,
    this.logType,
    this.shift,
    this.shiftType,
    this.warehouse,
    this.time,
    this.deviceId,
    this.selfieImage,
    this.geoLongitude,
    this.geoLatitude,
    this.fileName,
    this.isPrivate,
    this.isHomeFolder,
    this.isAttachmentsFolder,
    this.fileSize,
    this.fileUrl,
    this.folder,
    this.isFolder,
    this.contentHash,
    this.uploadedToDropbox,
    this.uploadedToGoogleDrive,
    this.startTime,
    this.endTime,
    this.holidayList,
    this.enableAutoAttendance,
    this.determineCheckInAndCheckOut,
    this.workingHoursCalculationBasedOn,
    this.beginCheckInBeforeShiftStartTime,
    this.allowCheckOutAfterShiftEndTime,
    this.workingHoursThresholdForHalfDay,
    this.workingHoursThresholdForAbsent,
    this.enableEntryGracePeriod,
    this.lateEntryGracePeriod,
    this.enableExitGracePeriod,
    this.earlyExitGracePeriod,
    this.faceData,
    this.attendanceAnywhere,
    this.absentLocation,
    this.locationName,
    this.latitude,
    this.longitude,
    this.tolerance,
  });

  factory Employee.fromJson(Map<String, dynamic> json) =>
      _$EmployeeFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeToJson(this);
}
