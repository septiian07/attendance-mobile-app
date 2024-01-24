import 'package:flutter/material.dart';
import 'package:resident_app/src/helpers/scalable_dp_helper.dart';
import 'package:resident_app/src/ui/shared/dimens.dart';
import 'package:resident_app/src/ui/shared/styles.dart';
import 'package:resident_app/src/ui/shared/ui_helpers.dart';

class Loading extends StatefulWidget {
  final bool? backgroundTransparent;
  final bool? status;
  final Widget? child;
  final String? text;

  const Loading({
    Key? key,
    this.status,
    this.child,
    this.backgroundTransparent = false,
    this.text,
  }) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    SDP.init(context);
    return Stack(
      children: <Widget>[
        widget.child!,
        widget.status == true
            ? Container(
                alignment: Alignment.center,
                color: widget.backgroundTransparent == true
                    ? Colors.transparent
                    : Colors.black54,
                child: widget.text == null
                    ? loadingSpin
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          loadingSpin,
                          verticalSpace(SDP.sdp(4)),
                          Text(
                            widget.text ?? '',
                            style: whiteSemiBoldTextStyle.copyWith(
                              fontSize: SDP.sdp(headline5),
                            ),
                          ),
                        ],
                      ),
              )
            : Container(),
      ],
    );
  }
}
