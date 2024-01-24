import 'package:flutter/material.dart';
import 'package:resident_app/src/app/app.locator.dart';
import 'package:resident_app/src/core/core_res_single.dart';
import 'package:resident_app/src/core/core_view_model.dart';
import 'package:resident_app/src/models/employee.dart';
import 'package:resident_app/src/network/network_exceptions.dart';
import 'package:resident_app/src/network/result_state.dart';
import 'package:resident_app/src/services/employee_service.dart';
import 'package:resident_app/src/ui/shared/strings.dart';
import 'package:stacked/stacked.dart';

class SkriningViewModel extends FutureViewModel with CoreViewModel {
  final _employeeService = locator<EmployeeService>();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController employeeController = TextEditingController();
  final TextEditingController employeeNameController = TextEditingController();
  final TextEditingController bodyTemperatureController =
      TextEditingController();

  final String namingSeries = 'SKR-.YYYY.-';
  Employee? user;
  String? dateValue;

  String? healthValue;
  String? coughOrColdValue;
  String? soreThroatValue;
  String? outOfBreathValue;
  String? tourValue;
  List<String> listSeries = [];
  List<String> listHealth = ['Sehat', 'Kurang Baik', 'Sakit'];
  List<String> listOption = ['Tidak', 'Ya'];

  @override
  Future futureToRun() => getDataEmployee();

  Future getDataEmployee() async {
    user = await _employeeService.getUser();
    employeeController.text = user?.name ?? '';
    employeeNameController.text = user?.employeeName ?? '';
    dateController.text = dateNow;
    dateValue = formattedDateAPI;
  }

  setDate(val) {
    dateController.text = val;
    notifyListeners();
  }

  void validate() async {
    if (namingSeries.isEmpty) {
      showMessageError('Harap masukan nomor series');
    } else if (dateController.text.isEmpty) {
      showMessageError('Harap tentukan tanggal');
    } else if (employeeController.text.isEmpty) {
      showMessageError('Harap masukan nomor karyawan');
    } else if (employeeNameController.text.isEmpty) {
      showMessageError('Harap masukan nama karyawan');
    } else if (healthValue == null) {
      showMessageError('Harap tentukan kesehatan');
    } else if (bodyTemperatureController.text.isEmpty) {
      showMessageError('Harap masukan suhu tubuh');
    } else if (coughOrColdValue == null) {
      showMessageError('Harap tentukan Anda batuk atau pilik');
    } else if (soreThroatValue == null) {
      showMessageError('Harap tentukan nyeri tenggorokan');
    } else if (outOfBreathValue == null) {
      showMessageError('Harap tentukan sesak nafas');
    } else if (tourValue == null) {
      showMessageError('Harap tentukan perjalanan keluar Kota/Negeri');
    } else {
      create();
    }
  }

  Future<ResultState<Employee>> create() async {
    setBusy(true);
    var result = await _employeeService.skrining(
      namingSeries,
      employeeController.text,
      employeeNameController.text,
      dateValue ?? '',
      healthValue ?? '',
      bodyTemperatureController.text,
      coughOrColdValue ?? '',
      soreThroatValue ?? '',
      outOfBreathValue ?? '',
      tourValue ?? '',
      Strings.labelSkriningCV19,
    );
    setBusy(false);
    return result.when(
      success: (CoreResSingle<Employee> data) async {
        showMessageSuccess('Data Skrining CV 19 berhasil disimpan');
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
}
