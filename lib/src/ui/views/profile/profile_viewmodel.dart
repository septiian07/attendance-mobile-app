import 'package:flutter/material.dart';
import 'package:resident_app/src/app/app.locator.dart';
import 'package:resident_app/src/core/core_view_model.dart';
import 'package:resident_app/src/enum/dialog_type.dart';
import 'package:resident_app/src/models/employee.dart';
import 'package:resident_app/src/services/employee_service.dart';
import 'package:stacked/stacked.dart';

class ProfileViewModel extends FutureViewModel with CoreViewModel {
  final _employeeService = locator<EmployeeService>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  Employee? employee;

  @override
  Future futureToRun() => getEmployee();

  Future getEmployee() async {
    employee = await _employeeService.getUser();
    emailController.text = employee?.preferedEmail ?? '';
    nameController.text = employee?.employeeName ?? '';
    notifyListeners();
  }

  Future<bool> showLogoutConfirmDialog({
    String? title,
    String? negativeLabel,
    String? positiveLabel,
  }) async {
    var response = await dialogService.showCustomDialog(
      barrierDismissible: true,
      variant: DialogType.confirmation,
      title: title,
      mainButtonTitle: positiveLabel,
      secondaryButtonTitle: negativeLabel,
    );
    if (response!.confirmed == true) logout();

    return response.confirmed;
  }
}
