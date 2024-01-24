import 'package:flutter/material.dart';
import 'package:resident_app/src/constant/config.dart';
import 'package:resident_app/src/helpers/date_time_format.dart';
import 'package:resident_app/src/helpers/scalable_dp_helper.dart';
import 'package:resident_app/src/ui/shared/colors.dart';
import 'package:resident_app/src/ui/shared/dimens.dart';
import 'package:resident_app/src/ui/shared/strings.dart';
import 'package:resident_app/src/ui/shared/styles.dart';
import 'package:resident_app/src/ui/shared/ui_helpers.dart';
import 'package:resident_app/src/ui/views/history/history_viewmodel.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class FilterHistoryCheckin extends StatefulWidget {
  final VoidCallback? onConfirm;
  final VoidCallback? onClear;
  final HistoryViewModel vm;

  const FilterHistoryCheckin({
    Key? key,
    this.onConfirm,
    this.onClear,
    required this.vm,
  }) : super(key: key);

  @override
  State<FilterHistoryCheckin> createState() => _FilterHistoryCheckinState();
}

class _FilterHistoryCheckinState extends State<FilterHistoryCheckin> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

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
              InkWell(
                onTap: widget.onConfirm,
                child: Text(
                  'Konfirmasi',
                  style: blackBoldTextStyle.copyWith(
                    fontSize: SDP.sdp(headline5),
                    color: BaseColors.green,
                  ),
                  textAlign: TextAlign.end,
                ),
              ),
              InkWell(
                onTap: () {
                  widget.onClear;
                  Navigator.pop(context);
                },
                child: Text(
                  'Batal',
                  style: blackBoldTextStyle.copyWith(
                    fontSize: SDP.sdp(headline5),
                    color: BaseColors.red,
                  ),
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
        ),
        verticalSpace(SDP.sdp(28.0)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: SDP.sdp(padding)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tanggal',
                style: blackRegularTextStyle.copyWith(
                  fontSize: SDP.sdp(headline6),
                ),
              ),
              verticalSpace(SDP.sdp(4.0)),
              GestureDetector(
                onTap: () => showChooseDateDialog(context, widget.vm),
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
                      widget.vm.selectedDateController.text.isNotEmpty
                          ? Text(
                              FormatDate().formatDate(
                                widget.vm.selectedDateController.text,
                                context: context,
                                format: Config.dateFormat,
                              ),
                              style: hintRegularTextStyle.copyWith(
                                fontSize: SDP.sdp(hint),
                              ),
                            )
                          : Text(
                              '${Strings.labelDate}',
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
              verticalSpace(SDP.sdp(padding)),
            ],
          ),
        ),
      ],
    );
  }

  showChooseDateDialog(BuildContext context, HistoryViewModel vm) {
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
