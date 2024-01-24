import 'package:flutter/material.dart';
import 'package:resident_app/src/helpers/scalable_dp_helper.dart';
import 'package:resident_app/src/ui/shared/colors.dart';
import 'package:resident_app/src/ui/shared/dimens.dart';

class KChip extends StatelessWidget {
  const KChip({
    Key? key,
    this.child,
    this.color = BaseColors.background,
    this.margin,
    this.padding,
    this.borderRadius,
    this.onPressed,
    this.border,
    this.isLoading = false,
    this.loadingColor = Colors.white,
    this.boxShadow,
    this.height,
    this.width,
    this.isDisabled = false,
  }) : super(key: key);

  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final Widget? child;
  final Color color;
  final BorderRadius? borderRadius;
  final VoidCallback? onPressed;
  final BoxBorder? border;
  final bool isLoading;
  final Color loadingColor;
  final List<BoxShadow>? boxShadow;
  final double? height;
  final double? width;
  final bool isDisabled;

  @override
  Widget build(BuildContext context) {
    SDP.init(context);
    return Opacity(
      opacity: isDisabled ? 0.5 : 1.0,
      child: Container(
        margin: margin,
        decoration: BoxDecoration(
          borderRadius: borderRadius ??
              BorderRadius.circular(
                SDP.sdp(smallRadius),
              ),
          color: isDisabled || isLoading ? color.withOpacity(0.5) : color,
          border: border,
          boxShadow: boxShadow,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: borderRadius ??
                BorderRadius.circular(
                  SDP.sdp(smallRadius),
                ),
            onTap: isDisabled || isLoading ? null : onPressed,
            enableFeedback: isDisabled || isLoading ? false : true,
            child: Padding(
              padding: padding ?? EdgeInsets.all(SDP.sdp(smallPadding)),
              child: isLoading
                  ? Center(
                      child: SizedBox(
                        height: SDP.sdp(smallPadding),
                        width: SDP.sdp(smallPadding),
                        child: CircularProgressIndicator(
                          color: loadingColor,
                        ),
                      ),
                    )
                  : child,
            ),
          ),
        ),
      ),
    );
  }
}
