import 'package:flutter/material.dart';
import 'package:resident_app/src/constant/config.dart';
import 'package:resident_app/src/helpers/date_time_format.dart';
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

import 'leave_application_viewmodel.dart';

class NewLeaveApplicationView extends StatefulWidget {
  const NewLeaveApplicationView({Key? key}) : super(key: key);

  @override
  State<NewLeaveApplicationView> createState() =>
      _NewLeaveApplicationViewState();
}

class _NewLeaveApplicationViewState extends State<NewLeaveApplicationView> {
  @override
  Widget build(BuildContext context) {
    SDP.init(context);
    return ViewModelBuilder<LeaveApplicationViewModel>.reactive(
      builder: (context, vm, child) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: BaseColors.main,
              size: SDP.sdp(18.0),
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            '${Strings.labelLeaveApplication} Baru',
            style: mainBoldTextStyle.copyWith(
              fontSize: SDP.sdp(headline5),
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
                          Strings.hintEmployee,
                          style: blackRegularTextStyle.copyWith(
                            fontSize: SDP.sdp(headline6),
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
                            fontSize: SDP.sdp(headline6),
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
                        verticalSpace(space),
                        Text(
                          'Jenis Pengajuan',
                          style: blackRegularTextStyle.copyWith(
                            fontSize: SDP.sdp(headline6),
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
                              child: DropdownButton<dynamic>(
                                value: vm.selectedLeaveType,
                                style: primaryBoldTextStyle.copyWith(
                                  fontSize: SDP.sdp(headline6),
                                  color: BaseColors.main,
                                ),
                                items: vm.leaveTypeList!
                                    .map<DropdownMenuItem<dynamic>>(
                                        (dynamic value) {
                                  return DropdownMenuItem<dynamic>(
                                    alignment: Alignment.center,
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                hint: Text(
                                  'Jenis Pengajuan',
                                  style: greyRegularTextStyle.copyWith(
                                      fontSize: SDP.sdp(headline6),
                                      color: BaseColors.borderUpload),
                                ),
                                onChanged: (value) {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  setState(() {
                                    vm.selectedLeaveType = value;
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
                          'Dari Tanggal',
                          style: blackRegularTextStyle.copyWith(
                            fontSize: SDP.sdp(headline6),
                          ),
                        ),
                        verticalSpace(SDP.sdp(4.0)),
                        GestureDetector(
                          onTap: () =>
                              showChooseDateDialog(context, vm, 'From'),
                          child: Container(
                            width: screenWidth(context),
                            height: SDP.sdp(44.0),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: BaseColors.main,
                              ),
                              borderRadius: BorderRadius.circular(
                                SDP.sdp(smallRadius),
                              ),
                              color: Colors.white,
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: SDP.sdp(smallPadding),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                vm.fromDateController.text.isNotEmpty
                                    ? Text(
                                        FormatDate().formatDate(
                                          vm.fromDateController.text,
                                          context: context,
                                          format: Config.dateFormat,
                                        ),
                                        style: hintRegularTextStyle.copyWith(
                                          fontSize: SDP.sdp(hint),
                                        ),
                                      )
                                    : Text(
                                        'Dari ${Strings.labelDate}',
                                        style: hintRegularTextStyle.copyWith(
                                          fontSize: SDP.sdp(hint),
                                        ),
                                      ),
                                Icon(
                                  Icons.arrow_drop_down,
                                  size: SDP.sdp(24.0),
                                ),
                              ],
                            ),
                          ),
                        ),
                        verticalSpace(space),
                        Text(
                          'Sampai Tanggal',
                          style: blackRegularTextStyle.copyWith(
                            fontSize: SDP.sdp(headline6),
                          ),
                        ),
                        verticalSpace(SDP.sdp(4.0)),
                        GestureDetector(
                          onTap: () => showChooseDateDialog(context, vm, 'To'),
                          child: Container(
                            width: screenWidth(context),
                            height: SDP.sdp(44.0),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: BaseColors.main,
                              ),
                              borderRadius: BorderRadius.circular(
                                SDP.sdp(smallRadius),
                              ),
                              color: Colors.white,
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: SDP.sdp(smallPadding),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                vm.toDateController.text.isNotEmpty
                                    ? Text(
                                        FormatDate().formatDate(
                                          vm.toDateController.text,
                                          context: context,
                                          format: Config.dateFormat,
                                        ),
                                        style: hintRegularTextStyle.copyWith(
                                          fontSize: SDP.sdp(hint),
                                        ),
                                      )
                                    : Text(
                                        'Sampai ${Strings.labelDate}',
                                        style: hintRegularTextStyle.copyWith(
                                          fontSize: SDP.sdp(hint),
                                        ),
                                      ),
                                Icon(
                                  Icons.arrow_drop_down,
                                  size: SDP.sdp(24.0),
                                ),
                              ],
                            ),
                          ),
                        ),
                        verticalSpace(space),
                        Text(
                          'Alasan',
                          style: blackRegularTextStyle.copyWith(
                            fontSize: SDP.sdp(headline6),
                          ),
                        ),
                        verticalSpace(SDP.sdp(4.0)),
                        KTextField(
                          isDense: true,
                          maxLines: 4,
                          minLines: 4,
                          enabled: true,
                          borderRadius: SDP.sdp(smallRadius),
                          controller: vm.reasonController,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.done,
                          backgroundColor: Colors.white.withOpacity(0.8),
                          placeholder: 'Alasan',
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
                          'Yang Menyetujui',
                          style: blackRegularTextStyle.copyWith(
                            fontSize: SDP.sdp(headline6),
                          ),
                        ),
                        verticalSpace(SDP.sdp(4.0)),
                        KTextField(
                          isDense: true,
                          maxLines: 1,
                          borderRadius: SDP.sdp(smallRadius),
                          controller: vm.leaveApproverController,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          backgroundColor: Colors.white.withOpacity(0.8),
                          placeholder: 'Tidak ada nama',
                          placeholderStyle: hintRegularTextStyle.copyWith(
                            fontSize: SDP.sdp(hint),
                          ),
                          enabled: false,
                          borderColor: BaseColors.main,
                          validator: Validator.requiredValidator,
                        ),
                        verticalSpace(SDP.sdp(space)),
                        Text(
                          'Status',
                          style: blackRegularTextStyle.copyWith(
                            fontSize: SDP.sdp(headline6),
                          ),
                        ),
                        verticalSpace(SDP.sdp(4.0)),
                        KTextField(
                          isDense: true,
                          maxLines: 1,
                          borderRadius: SDP.sdp(smallRadius),
                          controller: vm.statusController,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          backgroundColor: Colors.white.withOpacity(0.8),
                          placeholder: 'Tidak ada status',
                          placeholderStyle: hintRegularTextStyle.copyWith(
                            fontSize: SDP.sdp(hint),
                          ),
                          enabled: false,
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
                          'Tanggal Posting',
                          style: blackRegularTextStyle.copyWith(
                            fontSize: SDP.sdp(headline6),
                          ),
                        ),
                        verticalSpace(SDP.sdp(4.0)),
                        GestureDetector(
                          onTap: () =>
                              showChooseDateDialog(context, vm, 'Posting'),
                          child: Container(
                            width: screenWidth(context),
                            height: SDP.sdp(44.0),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: BaseColors.main,
                              ),
                              borderRadius: BorderRadius.circular(
                                SDP.sdp(smallRadius),
                              ),
                              color: Colors.white,
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: SDP.sdp(smallPadding),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                vm.postingDateController.text.isNotEmpty
                                    ? Text(
                                        FormatDate().formatDate(
                                          vm.postingDateController.text,
                                          context: context,
                                          format: Config.dateFormat,
                                        ),
                                        style: hintRegularTextStyle.copyWith(
                                          fontSize: SDP.sdp(hint),
                                        ),
                                      )
                                    : Text(
                                        '${Strings.labelDate} Posting',
                                        style: hintRegularTextStyle.copyWith(
                                          fontSize: SDP.sdp(hint),
                                        ),
                                      ),
                                Icon(
                                  Icons.arrow_drop_down,
                                  size: SDP.sdp(24.0),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                verticalSpace(SDP.sdp(padding)),
                Container(
                  width: screenWidth(context),
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
                          'Surat Dokter',
                          style: blackRegularTextStyle.copyWith(
                            fontSize: SDP.sdp(headline6),
                          ),
                        ),
                        verticalSpace(SDP.sdp(8.0)),
                        vm.filePicked == null
                            ? Text(
                                'Tidak ada file yang dipilih',
                                style: blackBoldTextStyle.copyWith(
                                  color: vm.filePicked == null
                                      ? BaseColors.black
                                      : BaseColors.main,
                                  fontSize: SDP.sdp(headline6),
                                ),
                              )
                            : vm.filePickedExtension == 'pdf'
                                ? Text(
                                    vm.filePickedName ?? '',
                                    style: blackBoldTextStyle.copyWith(
                                      color: vm.filePicked == null
                                          ? BaseColors.black
                                          : BaseColors.main,
                                      fontSize: SDP.sdp(headline6),
                                    ),
                                  )
                                : Container(
                                    height: SDP.sdp(130.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          SDP.sdp(smallRadius)),
                                      border:
                                          Border.all(color: BaseColors.grey),
                                      color: BaseColors.bgPin,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(SDP.sdp(4.0)),
                                      child: vm.files,
                                    ),
                                  ),
                        verticalSpace(SDP.sdp(8.0)),
                        SizedBox(
                          width: double.infinity,
                          child: KChip(
                            isLoading: vm.isBusy,
                            isDisabled: vm.isBusy,
                            padding: EdgeInsets.symmetric(
                              vertical: SDP.sdp(14.0),
                            ),
                            loadingColor: Colors.white,
                            borderRadius: BorderRadius.circular(
                              SDP.sdp(smallRadius),
                            ),
                            color: BaseColors.mainAccent,
                            child: Center(
                              child: Text(
                                vm.filePicked == null
                                    ? Strings.actionPickFile
                                    : '${Strings.actionPickFile} Lain',
                                style: whiteBoldTextStyle.copyWith(
                                  fontSize: SDP.sdp(headline6),
                                ),
                              ),
                            ),
                            onPressed: () => vm.onFileButtonPressed(),
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
                          fontSize: SDP.sdp(headline55),
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
      viewModelBuilder: () => LeaveApplicationViewModel(),
    );
  }

  showChooseDateDialog(
      BuildContext context, LeaveApplicationViewModel vm, String type) {
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
                  if (type == 'From') {
                    vm.setFromDate(val.toString());
                  } else if (type == 'To') {
                    vm.setToDate(val.toString());
                  } else {
                    vm.setPostingDate(val.toString());
                  }
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
