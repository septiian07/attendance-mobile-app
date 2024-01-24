import 'package:flutter/cupertino.dart';
import 'package:resident_app/src/app/app.locator.dart';
import 'package:resident_app/src/constant/config.dart';
import 'package:resident_app/src/core/core_res.dart';
import 'package:resident_app/src/core/core_view_model.dart';
import 'package:resident_app/src/helpers/date_time_format.dart';
import 'package:resident_app/src/models/employee.dart';
import 'package:resident_app/src/network/network_exceptions.dart';
import 'package:resident_app/src/network/result_state.dart';
import 'package:resident_app/src/services/employee_service.dart';
import 'package:stacked/stacked.dart';

class HistoryViewModel extends FutureViewModel with CoreViewModel {
  final _employeeService = locator<EmployeeService>();

  final TextEditingController selectedDateController = TextEditingController();

  Employee? employee;
  String? selectedDate;
  List<Employee>? checkinList = [];
  List<Employee>? skriningList = [];

  @override
  Future futureToRun() => getHistory();

  Future getHistory() async {
    employee = await _employeeService.getUser();
    getHistoryCheckin(employee?.employee ?? '');
  }

  Future<ResultState<CoreRes<Employee>>> getHistoryCheckin(
    String employee,
  ) async {
    var result = await _employeeService.fetchHistoryCheckin(
      employee,
      selectedDate ?? '',
    );
    return result.when(
      success: (CoreRes<Employee> data) async {
        checkinList = data.data;
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

  Future<ResultState<CoreRes<Employee>>> getHistorySkrining(
    String employee,
  ) async {
    var result = await _employeeService.fetchHistorySkrining(employee);
    return result.when(
      success: (CoreRes<Employee> data) async {
        skriningList = data.data;
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

  void filter() {
    getHistory();
    back();
  }

  void clearFilter() {
    selectedDate = null;
    selectedDateController.text = '';
  }

  setDate(val) {
    selectedDateController.text = val;
    selectedDate = FormatDate().formatDate(
      selectedDateController.text,
      format: Config.dateFormatAPI,
    );
    notifyListeners();
  }
}
