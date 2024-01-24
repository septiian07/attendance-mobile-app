import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:resident_app/src/helpers/scalable_dp_helper.dart';
import 'package:resident_app/src/ui/shared/colors.dart';
import 'package:resident_app/src/ui/shared/dimens.dart';
import 'package:resident_app/src/ui/shared/styles.dart';
import 'package:resident_app/src/ui/shared/ui_helpers.dart';

class ItemHomeMenu extends StatefulWidget {
  final String menuLabel;
  final String icon;
  final VoidCallback onTap;

  const ItemHomeMenu({
    Key? key,
    required this.menuLabel,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  _ItemHomeMenuState createState() => _ItemHomeMenuState();
}

class _ItemHomeMenuState extends State<ItemHomeMenu> {
  @override
  Widget build(BuildContext context) {
    SDP.init(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: SDP.sdp(smallPadding),
      ),
      child: InkWell(
        onTap: widget.onTap,
        child: Container(
          width: screenWidth(context),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(SDP.sdp(10.0)),
            border: Border.all(color: Colors.white),
            gradient: LinearGradient(
              colors: [BaseColors.primary.withOpacity(0.9), BaseColors.primaryLight],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [shadow],
          ),
          child: Padding(
            padding: EdgeInsets.all(SDP.sdp(16.0)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: SDP.sdp(10.0)),
                      child: SvgPicture.asset(
                        widget.icon,
                        color: BaseColors.main,
                        width: SDP.sdp(26.0),
                        height: SDP.sdp(26.0),
                      ),
                    ),
                    Text(
                      widget.menuLabel,
                      style: mainBoldTextStyle.copyWith(
                        fontSize: SDP.sdp(headline55),
                      ),
                    ),
                  ],
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: BaseColors.main,
                  size: SDP.sdp(14.0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
