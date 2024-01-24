import 'package:flutter/material.dart';
import 'package:resident_app/src/helpers/scalable_dp_helper.dart';
import 'package:resident_app/src/models/employee.dart';
import 'package:resident_app/src/ui/shared/colors.dart';
import 'package:resident_app/src/ui/shared/dimens.dart';
import 'package:resident_app/src/ui/shared/styles.dart';
import 'package:resident_app/src/ui/shared/ui_helpers.dart';

class ItemHistoryCheckin extends StatefulWidget {
  final Employee item;

  const ItemHistoryCheckin({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  _ItemHistoryCheckinState createState() => _ItemHistoryCheckinState();
}

class _ItemHistoryCheckinState extends State<ItemHistoryCheckin> {
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
                        style: greyRegularTextStyle.copyWith(
                          fontSize: SDP.sdp(headline6),
                        ),
                      ),
                      verticalSpace(SDP.sdp(4.0)),
                      Text(
                        widget.item.employeeName ?? '',
                        style: mainSemiBoldTextStyle.copyWith(
                          fontSize: SDP.sdp(headline5),
                        ),
                      ),
                      verticalSpace(SDP.sdp(space)),
                      Text(
                        widget.item.time ?? '',
                        style: greyRegularTextStyle.copyWith(
                          fontSize: SDP.sdp(headline6),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    widget.item.logType ?? '',
                    style: blackBoldTextStyle.copyWith(
                      fontSize: SDP.sdp(headline4),
                      color: widget.item.logType == 'IN'
                          ? BaseColors.green
                          : BaseColors.red,
                    ),
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
