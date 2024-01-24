import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:resident_app/src/app/app.locator.dart';
import 'package:resident_app/src/app/app.router.dart';
import 'package:resident_app/src/constant/config.dart';
import 'package:resident_app/src/core/core_res.dart';
import 'package:resident_app/src/core/core_res_single.dart';
import 'package:resident_app/src/core/core_view_model.dart';
import 'package:resident_app/src/helpers/date_time_format.dart';
import 'package:resident_app/src/models/employee.dart';
import 'package:resident_app/src/models/leave_type.dart';
import 'package:resident_app/src/models/message.dart';
import 'package:resident_app/src/network/network_exceptions.dart';
import 'package:resident_app/src/network/result_state.dart';
import 'package:resident_app/src/services/employee_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:resident_app/src/ui/shared/strings.dart';
import 'package:stacked/stacked.dart';

class LeaveApplicationViewModel extends FutureViewModel with CoreViewModel {
  final _employeeService = locator<EmployeeService>();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController fromDateController = TextEditingController();
  final TextEditingController toDateController = TextEditingController();
  final TextEditingController postingDateController = TextEditingController();
  final TextEditingController employeeController = TextEditingController();
  final TextEditingController employeeNameController = TextEditingController();
  final TextEditingController reasonController = TextEditingController();
  final TextEditingController leaveApproverController = TextEditingController();
  final TextEditingController statusController =
      TextEditingController(text: 'Open');

  final String namingSeries = 'HR-LAP-.YYYY.-';
  final String workflowState = 'Pengajuan';
  String? company;
  Employee? user;
  String? dateValue;
  String? fromDate;
  String? toDate;
  String? postingDate;
  List<String> listSeries = [];
  List? leaveTypeList = [];
  List<Employee>? salarySlipList = [];
  List<Employee>? leaveApplicationList = [];
  String? selectedLeaveType;
  Employee? selectedSalarySlip;
  List<String> fromDatefromAPI = [];
  List<String> toDatefromAPI = [];
  List<String> fromDateBeetwen = [];
  List<String> toDateBeetwen = [];
  Widget? files;
  File? filePicked;
  String? filePickedName;
  String? filePickedExtension;

  @override
  Future futureToRun() => getDataEmployee();

  Future getDataEmployee() async {
    user = await _employeeService.getUser();
    employeeController.text = user?.name ?? '';
    employeeNameController.text = user?.employeeName ?? '';
    leaveApproverController.text = user?.leaveApprover ?? '';
    dateValue = formattedDateAPI;
    postingDateController.text = formattedDateAPI;
    postingDate = formattedDateAPI;
    company = user?.company ?? '';
    getLeaveApplicationList(user?.name ?? '');
    getLeaveTypeList(user?.name ?? '');
    getSalarySlipList();
  }

  Future<ResultState<CoreRes<Employee>>> getLeaveApplicationList(
    String employee,
  ) async {
    var result = await _employeeService.fetchLeaveApplicationList(employee);
    return result.when(
      success: (CoreRes<Employee> data) async {
        leaveApplicationList = data.data;
        notifyListeners();
        return ResultState.data(data: data);
      },
      failure: (
        NetworkExceptions error,
        String? message,
      ) async {
        showMessageError(message ?? 'Terjadi kesalahan');
        notifyListeners();
        return ResultState.error(error: error);
      },
    );
  }

  setFromDate(val) {
    fromDateController.text = val;
    fromDate = FormatDate().formatDate(
      fromDateController.text,
      format: Config.dateFormatAPI,
    );

    fromDatefromAPI = [];
    toDatefromAPI = [];
    fromDateBeetwen = [];

    leaveApplicationList!.forEach((element) {
      var fDate = DateFormat(Config.dateFormatAPI).parse(fromDate ?? '');
      var fromDateapi =
          DateFormat(Config.dateFormatAPI).parse(element.fromDate ?? '');
      var toDateapi =
          DateFormat(Config.dateFormatAPI).parse(element.toDate ?? '');
      if (fromDateapi.isBefore(fDate) && toDateapi.isAfter(fDate)) {
        fromDateBeetwen.add('Is Beetwen');
      } else {
        fromDateBeetwen.add('Is Not Beetwen');
      }
      fromDatefromAPI.add(element.fromDate ?? '');
      toDatefromAPI.add(element.toDate ?? '');
    });
    notifyListeners();
  }

  setToDate(val) {
    toDateController.text = val;
    toDate = FormatDate().formatDate(
      toDateController.text,
      format: Config.dateFormatAPI,
    );

    fromDatefromAPI = [];
    toDatefromAPI = [];
    toDateBeetwen = [];

    leaveApplicationList!.forEach((element) {
      var tDate = DateFormat(Config.dateFormatAPI).parse(toDate ?? '');
      var fromDateapi =
          DateFormat(Config.dateFormatAPI).parse(element.fromDate ?? '');
      var toDateapi =
          DateFormat(Config.dateFormatAPI).parse(element.toDate ?? '');
      if (fromDateapi.isBefore(tDate) && toDateapi.isAfter(tDate)) {
        toDateBeetwen.add('Is Beetwen');
      } else {
        toDateBeetwen.add('Is Not Beetwen');
      }
      fromDatefromAPI.add(element.fromDate ?? '');
      toDatefromAPI.add(element.toDate ?? '');
    });
    notifyListeners();
  }

  setPostingDate(val) {
    postingDateController.text = val;
    postingDate = FormatDate().formatDate(
      postingDateController.text,
      format: Config.dateFormatAPI,
    );
    notifyListeners();
  }

  void onFileButtonPressed() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf']);

      if (result != null) {
        PlatformFile file = result.files.first;
        final File toFile = File(file.path ?? '');

        filePicked = toFile;
        filePickedName = file.name;
        filePickedExtension = file.extension;
        files = Image.file(
          toFile,
          fit: BoxFit.cover,
        );
      } else {
        // User canceled the picker
      }
      notifyListeners();
    } catch (e) {
      showMessageError(Strings.messageFailurePickFile);
    }
  }

  Future<ResultState<Message>> uploadProof() async {
    setBusy(true);
    var result = await _employeeService.uploadImage(filePicked!);
    setBusy(false);
    return result.when(
      success: (Message data) async {
        await create(data.message?.fileUrl ?? '');
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

  Future<ResultState<LeaveType>> getLeaveTypeList(String employee) async {
    var result =
        await _employeeService.fetchLeaveType(employee, formattedDateAPI);
    return result.when(
      success: (LeaveType data) async {
        leaveTypeList = data.message?.leaveTypeList;
        notifyListeners();
        return ResultState.data(data: data);
      },
      failure: (NetworkExceptions error, String? message) async {
        print('message error $error');
        return ResultState.error(error: error);
      },
    );
  }

  Future<ResultState<CoreRes<Employee>>> getSalarySlipList() async {
    var result = await _employeeService.fetchSalarySlip();
    return result.when(
      success: (CoreRes<Employee> data) async {
        salarySlipList = data.data;
        notifyListeners();
        return ResultState.data(data: data);
      },
      failure: (NetworkExceptions error, String? message) async {
        return ResultState.error(error: error);
      },
    );
  }

  void validate() async {
    if (namingSeries.isEmpty) {
      showMessageError('Harap masukan nomor series');
    } else if (employeeController.text.isEmpty) {
      showMessageError('Harap masukan nomor karyawan');
    } else if (employeeNameController.text.isEmpty) {
      showMessageError('Harap masukan nama karyawan');
    } else if (selectedLeaveType == null) {
      showMessageError('Harap tentukan leave type');
    } else if (fromDateController.text.isEmpty) {
      showMessageError('Harap tentukan dari tanggal berapa');
    } else if (fromDatefromAPI.contains(fromDate) ||
        fromDatefromAPI.contains(toDate) ||
        fromDateBeetwen.contains('Is Beetwen') ||
        toDatefromAPI.contains(toDate) ||
        toDatefromAPI.contains(fromDate) ||
        toDateBeetwen.contains('Is Beetwen')) {
      showMessageError(
          'Anda sudah pernah mengajukan diantara tanggal tersebut, harap pilih kembali');
    } else if (toDateController.text.isEmpty) {
      showMessageError('Harap tentukan sampai tanggal berapa');
    } else if (reasonController.text.isEmpty) {
      showMessageError('Harap masukan alasan');
    } else if (leaveApproverController.text.isEmpty) {
      showMessageError('Harap isi yang menyetujui terlebih dahulu kepada HRD');
    } else if (statusController.text.isEmpty) {
      showMessageError('Harap tentukan status');
    } else if (postingDateController.text.isEmpty) {
      showMessageError('Harap tentukan tanggal posting');
    } else {
      filePicked != null ? uploadProof() : create('');
    }
  }

  Future<ResultState<Employee>> create(String imagePath) async {
    setBusy(true);
    var result = await _employeeService.leaveApplication(
      namingSeries,
      employeeController.text,
      selectedLeaveType ?? '',
      fromDate ?? '',
      toDate ?? '',
      reasonController.text,
      leaveApproverController.text,
      statusController.text,
      selectedSalarySlip?.name ?? '',
      postingDate ?? '',
      company ?? '',
      workflowState,
      imagePath,
    );
    setBusy(false);
    return result.when(
      success: (CoreResSingle<Employee> data) async {
        showMessageSuccess('Data pengajuan izin berhasil disimpan');
        back();
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

  void newLeaveApplication() =>
      navigationService.navigateTo(Routes.newLeaveApplicationView);
}
