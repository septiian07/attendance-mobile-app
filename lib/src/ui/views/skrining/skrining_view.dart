import 'package:flutter/material.dart';
import 'package:resident_app/src/helpers/scalable_dp_helper.dart';
import 'package:resident_app/src/helpers/validator/validator.dart';
import 'package:resident_app/src/ui/shared/colors.dart';
import 'package:resident_app/src/ui/shared/dimens.dart';
import 'package:resident_app/src/ui/shared/strings.dart';
import 'package:resident_app/src/ui/shared/styles.dart';
import 'package:resident_app/src/ui/shared/ui_helpers.dart';
import 'package:resident_app/src/ui/widgets/chip.dart';
import 'package:resident_app/src/ui/widgets/textfield.dart';
import 'package:stacked/stacked.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import 'skrining_viewmodel.dart';

class SkriningView extends StatefulWidget {
  const SkriningView({Key? key}) : super(key: key);

  @override
  State<SkriningView> createState() => _SkriningViewState();
}

class _SkriningViewState extends State<SkriningView> {
  @override
  Widget build(BuildContext context) {
    SDP.init(context);
    return ViewModelBuilder<SkriningViewModel>.reactive(
      builder: (context, vm, child) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: BaseColors.black,
              size: SDP.sdp(18.0),
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            'Skrining CV-19',
            style: blackBoldTextStyle.copyWith(
              fontSize: SDP.sdp(headline3),
            ),
          ),
          backgroundColor: BaseColors.primary,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(SDP.sdp(smallPadding)),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(SDP.sdp(8.0)),
                    color: Colors.white,
                    boxShadow: [shadow],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(SDP.sdp(smallPadding)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Strings.labelDate,
                          style: blackRegularTextStyle.copyWith(
                            fontSize: SDP.sdp(headline5),
                          ),
                        ),
                        verticalSpace(SDP.sdp(4.0)),
                        KTextField(
                          isDense: true,
                          maxLines: 1,
                          enabled: false,
                          borderRadius: SDP.sdp(smallRadius),
                          controller: vm.dateController,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          backgroundColor: Colors.white.withOpacity(0.8),
                          placeholder: Strings.labelDate,
                          placeholderStyle: hintRegularTextStyle.copyWith(
                            fontSize: SDP.sdp(hint),
                          ),
                          borderColor: BaseColors.main,
                          validator: Validator.requiredValidator,
                        ),
                        verticalSpace(SDP.sdp(space)),
                        Text(
                          Strings.hintEmployee,
                          style: blackRegularTextStyle.copyWith(
                            fontSize: SDP.sdp(headline5),
                          ),
                        ),
                        verticalSpace(SDP.sdp(4.0)),
                        KTextField(
                          isDense: true,
                          maxLines: 1,
                          enabled: false,
                          borderRadius: SDP.sdp(smallRadius),
                          controller: vm.employeeController,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          backgroundColor: Colors.white.withOpacity(0.8),
                          placeholder: Strings.hintEmployee,
                          placeholderStyle: hintRegularTextStyle.copyWith(
                            fontSize: SDP.sdp(hint),
                          ),
                          borderColor: BaseColors.main,
                          validator: Validator.requiredValidator,
                        ),
                        verticalSpace(SDP.sdp(space)),
                        Text(
                          Strings.hintEmployeeName,
                          style: blackRegularTextStyle.copyWith(
                            fontSize: SDP.sdp(headline5),
                          ),
                        ),
                        verticalSpace(SDP.sdp(4.0)),
                        KTextField(
                          isDense: true,
                          maxLines: 1,
                          enabled: false,
                          borderRadius: SDP.sdp(smallRadius),
                          controller: vm.employeeNameController,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.done,
                          backgroundColor: Colors.white.withOpacity(0.8),
                          placeholder: Strings.hintEmployeeName,
                          placeholderStyle: hintRegularTextStyle.copyWith(
                            fontSize: SDP.sdp(hint),
                          ),
                          borderColor: BaseColors.main,
                          validator: Validator.requiredValidator,
                        ),
                      ],
                    ),
                  ),
                ),
                verticalSpace(SDP.sdp(padding)),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(SDP.sdp(8.0)),
                    color: Colors.white,
                    boxShadow: [shadow],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(SDP.sdp(smallPadding)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Dengan ini saya menyatakan',
                          style: blackBoldTextStyle.copyWith(
                            fontSize: SDP.sdp(headline4),
                          ),
                        ),
                        verticalSpace(SDP.sdp(smallPadding)),
                        Text(
                          'Apakah Anda sehat',
                          style: blackRegularTextStyle.copyWith(
                            fontSize: SDP.sdp(headline5),
                          ),
                        ),
                        verticalSpace(SDP.sdp(4.0)),
                        Container(
                          width: screenWidth(context),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(SDP.sdp(smallRadius)),
                            border: Border.all(color: BaseColors.main),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: SDP.sdp(14.0),
                              ),
                              child: DropdownButton<String>(
                                value: vm.healthValue,
                                style: primaryBoldTextStyle.copyWith(
                                  fontSize: SDP.sdp(headline4),
                                  color: BaseColors.main,
                                ),
                                items: vm.listHealth
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                  return DropdownMenuItem<String>(
                                    alignment: Alignment.center,
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                hint: Text(
                                  'Kesehatan',
                                  style: greyRegularTextStyle.copyWith(
                                      fontSize: SDP.sdp(headline5),
                                      color: BaseColors.borderUpload),
                                ),
                                onChanged: (value) {
                                  FocusManager.instance.primaryFocus
                                      ?.unfocus();
                                  setState(() {
                                    vm.healthValue = value;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                        verticalSpace(SDP.sdp(space)),
                        Text(
                          'Suhu Tubuh',
                          style: blackRegularTextStyle.copyWith(
                            fontSize: SDP.sdp(headline5),
                          ),
                        ),
                        verticalSpace(SDP.sdp(4.0)),
                        KTextField(
                          isDense: true,
                          maxLines: 1,
                          borderRadius: SDP.sdp(smallRadius),
                          controller: vm.bodyTemperatureController,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.done,
                          backgroundColor: Colors.white.withOpacity(0.8),
                          placeholder: Strings.labelTemperatureController,
                          placeholderStyle: hintRegularTextStyle.copyWith(
                            fontSize: SDP.sdp(hint),
                          ),
                          borderColor: BaseColors.main,
                          validator: Validator.requiredValidator,
                        ),
                        verticalSpace(SDP.sdp(space)),
                        Text(
                          'Ada Batuk atau Pilek',
                          style: blackRegularTextStyle.copyWith(
                            fontSize: SDP.sdp(headline5),
                          ),
                        ),
                        verticalSpace(SDP.sdp(4.0)),
                        Container(
                          width: screenWidth(context),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(SDP.sdp(smallRadius)),
                            border: Border.all(color: BaseColors.main),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: SDP.sdp(14.0),
                              ),
                              child: DropdownButton<String>(
                                value: vm.coughOrColdValue,
                                style: primaryBoldTextStyle.copyWith(
                                  fontSize: SDP.sdp(headline4),
                                  color: BaseColors.main,
                                ),
                                items: vm.listOption
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                  return DropdownMenuItem<String>(
                                    alignment: Alignment.center,
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                hint: Text(
                                  'Batuk atau Pilek',
                                  style: greyRegularTextStyle.copyWith(
                                      fontSize: SDP.sdp(headline5),
                                      color: BaseColors.borderUpload),
                                ),
                                onChanged: (value) {
                                  FocusManager.instance.primaryFocus
                                      ?.unfocus();
                                  setState(() {
                                    vm.coughOrColdValue = value;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                        verticalSpace(SDP.sdp(space)),
                        Text(
                          'Nyeri Tenggorokan',
                          style: blackRegularTextStyle.copyWith(
                            fontSize: SDP.sdp(headline5),
                          ),
                        ),
                        verticalSpace(SDP.sdp(4.0)),
                        Container(
                          width: screenWidth(context),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(SDP.sdp(smallRadius)),
                            border: Border.all(color: BaseColors.main),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: SDP.sdp(14.0),
                              ),
                              child: DropdownButton<String>(
                                value: vm.soreThroatValue,
                                style: primaryBoldTextStyle.copyWith(
                                  fontSize: SDP.sdp(headline4),
                                  color: BaseColors.main,
                                ),
                                items: vm.listOption
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                  return DropdownMenuItem<String>(
                                    alignment: Alignment.center,
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                hint: Text(
                                  'Nyeri Tenggorokan',
                                  style: greyRegularTextStyle.copyWith(
                                      fontSize: SDP.sdp(headline5),
                                      color: BaseColors.borderUpload),
                                ),
                                onChanged: (value) {
                                  FocusManager.instance.primaryFocus
                                      ?.unfocus();
                                  setState(() {
                                    vm.soreThroatValue = value;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                        verticalSpace(SDP.sdp(space)),
                        Text(
                          'Sesak Nafas',
                          style: blackRegularTextStyle.copyWith(
                            fontSize: SDP.sdp(headline5),
                          ),
                        ),
                        verticalSpace(SDP.sdp(4.0)),
                        Container(
                          width: screenWidth(context),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(SDP.sdp(smallRadius)),
                            border: Border.all(color: BaseColors.main),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: SDP.sdp(14.0),
                              ),
                              child: DropdownButton<String>(
                                value: vm.outOfBreathValue,
                                style: primaryBoldTextStyle.copyWith(
                                  fontSize: SDP.sdp(headline4),
                                  color: BaseColors.main,
                                ),
                                items: vm.listOption
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                  return DropdownMenuItem<String>(
                                    alignment: Alignment.center,
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                hint: Text(
                                  'Sesak Nafas',
                                  style: greyRegularTextStyle.copyWith(
                                      fontSize: SDP.sdp(headline5),
                                      color: BaseColors.borderUpload),
                                ),
                                onChanged: (value) {
                                  FocusManager.instance.primaryFocus
                                      ?.unfocus();
                                  setState(() {
                                    vm.outOfBreathValue = value;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                        verticalSpace(SDP.sdp(space)),
                        Text(
                          '14 Terakhir ada keluar Kota/Negeri',
                          style: blackRegularTextStyle.copyWith(
                            fontSize: SDP.sdp(headline5),
                          ),
                        ),
                        verticalSpace(SDP.sdp(4.0)),
                        Container(
                          width: screenWidth(context),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(SDP.sdp(smallRadius)),
                            border: Border.all(color: BaseColors.main),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: SDP.sdp(14.0),
                              ),
                              child: DropdownButton<String>(
                                value: vm.tourValue,
                                style: primaryBoldTextStyle.copyWith(
                                  fontSize: SDP.sdp(headline4),
                                  color: BaseColors.main,
                                ),
                                items: vm.listOption
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                  return DropdownMenuItem<String>(
                                    alignment: Alignment.center,
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                hint: Text(
                                  '14 Terakhir ada keluar Kota/Negeri',
                                  style: greyRegularTextStyle.copyWith(
                                      fontSize: SDP.sdp(headline5),
                                      color: BaseColors.borderUpload),
                                ),
                                onChanged: (value) {
                                  FocusManager.instance.primaryFocus
                                      ?.unfocus();
                                  setState(() {
                                    vm.tourValue = value;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                verticalSpace(SDP.sdp(bigPadding)),
                SizedBox(
                  width: double.infinity,
                  height: SDP.sdp(50.0),
                  child: KChip(
                    isLoading: vm.isBusy,
                    padding: EdgeInsets.symmetric(
                      vertical: SDP.sdp(14.0),
                    ),
                    loadingColor: Colors.white,
                    borderRadius: BorderRadius.circular(
                      SDP.sdp(smallRadius),
                    ),
                    color: BaseColors.main,
                    child: Center(
                      child: Text(
                        Strings.actionSave,
                        style: whiteBoldTextStyle.copyWith(
                          fontSize: SDP.sdp(headline4),
                        ),
                      ),
                    ),
                    onPressed: () => vm.validate(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => SkriningViewModel(),
    );
  }

  showChooseDateDialog(BuildContext context, SkriningViewModel vm) {
    AlertDialog alert = AlertDialog(
      content: SizedBox(
        width: screenWidth(context),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SfDateRangePicker(
              onSelectionChanged:
                  (DateRangePickerSelectionChangedArgs value) {},
              showActionButtons: true,
              confirmText: 'Konfirmasi',
              cancelText: 'Batal',
              onCancel: () {
                Navigator.of(context).pop();
              },
              onSubmit: (val) {
                setState(() {
                  vm.setDate(val.toString());
                });
                Navigator.of(context).pop();
              },
              selectionColor: BaseColors.primary,
              todayHighlightColor: BaseColors.primary,
              rangeSelectionColor: BaseColors.primary.withOpacity(0.75),
              selectionMode: DateRangePickerSelectionMode.single,
              initialSelectedDate: DateTime.now(),
            ),
          ],
        ),
      ),
    );

    showDialog(
      context: context,
      useSafeArea: true,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
