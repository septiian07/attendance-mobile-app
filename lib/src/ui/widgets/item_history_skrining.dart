import 'package:flutter/material.dart';
import 'package:resident_app/src/helpers/scalable_dp_helper.dart';
import 'package:resident_app/src/models/employee.dart';
import 'package:resident_app/src/ui/shared/colors.dart';
import 'package:resident_app/src/ui/shared/dimens.dart';
import 'package:resident_app/src/ui/shared/styles.dart';
import 'package:resident_app/src/ui/shared/ui_helpers.dart';

class ItemHistorySkrining extends StatefulWidget {
  final Employee item;
  final VoidCallback onSeeDetail;

  const ItemHistorySkrining({
    Key? key,
    required this.item,
    required this.onSeeDetail,
  }) : super(key: key);

  @override
  _ItemHistorySkriningState createState() => _ItemHistorySkriningState();
}

class _ItemHistorySkriningState extends State<ItemHistorySkrining> {
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
                        widget.item.namingSeries ?? '',
                        style: greyRegularTextStyle.copyWith(
                          fontSize: SDP.sdp(headline6),
                        ),
                      ),
                      verticalSpace(SDP.sdp(4.0)),
                      Text(
                        widget.item.employeeName ?? '',
                        style: blackRegularTextStyle.copyWith(
                          fontSize: SDP.sdp(headline4),
                        ),
                      ),
                      verticalSpace(SDP.sdp(space)),
                      Text(
                        widget.item.date ?? '',
                        style: greyRegularTextStyle.copyWith(
                          fontSize: SDP.sdp(headline5),
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: widget.onSeeDetail,
                    child: Text(
                      'Lihat Detail',
                      style: blackBoldTextStyle.copyWith(
                        fontSize: SDP.sdp(headline6),
                        color: BaseColors.primary,
                      ),
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
