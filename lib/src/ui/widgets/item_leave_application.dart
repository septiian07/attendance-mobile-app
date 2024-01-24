import 'package:flutter/material.dart';
import 'package:resident_app/src/helpers/scalable_dp_helper.dart';
import 'package:resident_app/src/models/employee.dart';
import 'package:resident_app/src/ui/shared/colors.dart';
import 'package:resident_app/src/ui/shared/dimens.dart';
import 'package:resident_app/src/ui/shared/styles.dart';
import 'package:resident_app/src/ui/shared/ui_helpers.dart';

class ItemLeaveApplication extends StatefulWidget {
  final Employee item;

  const ItemLeaveApplication({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  _ItemLeaveApplicationState createState() => _ItemLeaveApplicationState();
}

class _ItemLeaveApplicationState extends State<ItemLeaveApplication> {
  @override
  Widget build(BuildContext context) {
    SDP.init(context);
    return Padding(
      padding: EdgeInsets.only(top: SDP.sdp(bigSpace)),
      child: Container(
        width: screenWidth(context),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(SDP.sdp(10.0)),
          color: Colors.white,
          boxShadow: [shadow],
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(SDP.sdp(radius)),
            boxShadow: [shadow],
            border: Border.all(
              color: BaseColors.border,
              width: 1,
            ),
            color: Colors.white,
          ),
          child: Material(
            color: Colors.transparent,
            child: Padding(
              padding: EdgeInsets.all(SDP.sdp(smallPadding)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.item.name ?? '',
                        style: blackBoldTextStyle.copyWith(
                          fontSize: SDP.sdp(headline5),
                        ),
                      ),
                      verticalSpace(SDP.sdp(space)),
                      Text(
                        'Dari : ${widget.item.fromDate}',
                        style: blackRegularTextStyle.copyWith(
                          fontSize: SDP.sdp(headline6),
                        ),
                      ),
                      verticalSpace(SDP.sdp(space)),
                      Text(
                        'Sampai : ${widget.item.toDate}',
                        style: blackRegularTextStyle.copyWith(
                          fontSize: SDP.sdp(headline6),
                        ),
                      ),
                      verticalSpace(SDP.sdp(space)),
                      Text(
                        'Alasan :',
                        style: blackRegularTextStyle.copyWith(
                          fontSize: SDP.sdp(headline6),
                        ),
                      ),
                      verticalSpace(SDP.sdp(space)),
                      Text(
                        widget.item.desc ?? '',
                        style: blackRegularTextStyle.copyWith(
                          fontSize: SDP.sdp(headline6),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        'Status',
                        style: mainBoldTextStyle.copyWith(
                          fontSize: SDP.sdp(headline5),
                        ),
                      ),
                      Text(
                        widget.item.workflowState ?? '',
                        style: blackBoldTextStyle.copyWith(
                          fontSize: SDP.sdp(headline5),
                          color: widget.item.workflowState == 'Pengajuan'
                              ? BaseColors.mainAccent
                              : widget.item.workflowState == 'Reject'
                                  ? BaseColors.red
                                  : BaseColors.green,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
