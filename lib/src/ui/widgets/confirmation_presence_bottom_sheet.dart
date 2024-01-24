import 'package:flutter/material.dart';
import 'package:resident_app/src/helpers/scalable_dp_helper.dart';
import 'package:resident_app/src/helpers/validator/validator.dart';
import 'package:resident_app/src/ui/shared/colors.dart';
import 'package:resident_app/src/ui/shared/dimens.dart';
import 'package:resident_app/src/ui/shared/styles.dart';
import 'package:resident_app/src/ui/shared/ui_helpers.dart';
import 'package:resident_app/src/ui/views/presence/presence_viewmodel.dart';
import 'package:resident_app/src/ui/widgets/textfield.dart';

import 'chip.dart';

class ConfirmationPresenceBottomSheet extends StatefulWidget {
  final PresenceViewModel vm;

  const ConfirmationPresenceBottomSheet({
    Key? key,
    required this.vm,
  }) : super(key: key);

  @override
  State<ConfirmationPresenceBottomSheet> createState() =>
      _ConfirmationPresenceBottomSheetState();
}

class _ConfirmationPresenceBottomSheetState
    extends State<ConfirmationPresenceBottomSheet> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    SDP.init(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: SDP.sdp(padding)),
          width: screenWidth(context),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Konfirmasi Kehadiran',
                style: blackBoldTextStyle.copyWith(
                  fontSize: SDP.sdp(headline5),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Batal',
                  style: primaryBoldTextStyle.copyWith(
                    fontSize: SDP.sdp(headline6),
                  ),
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
        ),
        verticalSpace(SDP.sdp(28.0)),
        Center(
          child: Text(
            widget.vm.dateNow,
            style: blackRegularTextStyle.copyWith(
              fontSize: SDP.sdp(headline6),
            ),
          ),
        ),
        verticalSpace(SDP.sdp(smallPadding)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: SDP.sdp(padding)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ID Karyawan: ',
                style: greyRegularTextStyle.copyWith(
                  fontSize: SDP.sdp(headline6),
                ),
              ),
              verticalSpace(SDP.sdp(space)),
              Text(
                widget.vm.employee?.employee ?? '',
                style: blackSemiBoldTextStyle.copyWith(
                  fontSize: SDP.sdp(headline5),
                ),
              ),
              verticalSpace(SDP.sdp(smallPadding)),
              Text(
                'Nama Karyawan: ',
                style: greyRegularTextStyle.copyWith(
                  fontSize: SDP.sdp(headline6),
                ),
              ),
              verticalSpace(SDP.sdp(space)),
              Text(
                widget.vm.employee?.employeeName ?? '',
                style: blackSemiBoldTextStyle.copyWith(
                  fontSize: SDP.sdp(headline5),
                ),
              ),
              verticalSpace(SDP.sdp(smallPadding)),
              Text(
                'Lokasi Anda melakukan scan: ',
                style: greyRegularTextStyle.copyWith(
                  fontSize: SDP.sdp(headline6),
                ),
              ),
              verticalSpace(SDP.sdp(space)),
              Text(
                widget.vm.radius.contains('In Radius')
                    ? widget.vm.addressInRadius ?? ''
                    : widget.vm.address ?? '',
                style: blackSemiBoldTextStyle.copyWith(
                  fontSize: SDP.sdp(headline5),
                ),
              ),
              verticalSpace(widget.vm.employee?.attendanceAnywhere == 1 &&
                      !widget.vm.radius.contains('In Radius')
                  ? SDP.sdp(smallPadding)
                  : 0),
              !widget.vm.radius.contains('In Radius') &&
                      widget.vm.employee?.attendanceAnywhere == 1 &&
                      (widget.vm.attendanceLocation != null ||
                          widget.vm.attendanceLocation != [])
                  ? Text(
                      'Anda di luar radius absensi, harap isi alasan',
                      style: greyRegularTextStyle.copyWith(
                        fontSize: SDP.sdp(headline6),
                      ),
                    )
                  : widget.vm.attendanceLocation!.isEmpty &&
                          widget.vm.employee?.attendanceAnywhere == 1
                      ? Text(
                          'Anda belum menentukan lokasi absen, harap isi tempat absen dan alasan',
                          style: greyRegularTextStyle.copyWith(
                            fontSize: SDP.sdp(headline6),
                          ),
                        )
                      : Container(),
              verticalSpace(SDP.sdp(space)),
              !widget.vm.radius.contains('In Radius') &&
                          widget.vm.employee?.attendanceAnywhere == 1 &&
                          (widget.vm.attendanceLocation != null ||
                              widget.vm.attendanceLocation != []) ||
                      widget.vm.attendanceLocation!.isEmpty &&
                          widget.vm.employee?.attendanceAnywhere == 1
                  ? KTextField(
                      isDense: true,
                      maxLines: 3,
                      minLines: 3,
                      enabled: true,
                      borderRadius: SDP.sdp(smallRadius),
                      controller: widget.vm.remarksController,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.done,
                      backgroundColor: Colors.white.withOpacity(0.8),
                      placeholder: 'Remarks',
                      placeholderStyle: hintRegularTextStyle.copyWith(
                        fontSize: SDP.sdp(headline6),
                      ),
                      borderColor: BaseColors.main,
                      validator: Validator.requiredValidator,
                    )
                  : Container(),
              verticalSpace(SDP.sdp(28.0)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: SDP.sdp(120.0),
                    height: SDP.sdp(50.0),
                    child: KChip(
                      isLoading: isLoading || widget.vm.isBusy,
                      isDisabled: isLoading || widget.vm.isBusy,
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
                          'IN',
                          style: whiteBoldTextStyle.copyWith(
                            fontSize: SDP.sdp(headline55),
                          ),
                        ),
                      ),
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });
                        await widget.vm.validate('IN');
                        setState(() {
                          isLoading = false;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    width: SDP.sdp(120.0),
                    height: SDP.sdp(50.0),
                    child: KChip(
                      isLoading: isLoading || widget.vm.isBusy,
                      isDisabled: isLoading || widget.vm.isBusy,
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
                          'OUT',
                          style: whiteBoldTextStyle.copyWith(
                            fontSize: SDP.sdp(headline5),
                          ),
                        ),
                      ),
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });
                        await widget.vm.validate('OUT');
                        setState(() {
                          isLoading = false;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
