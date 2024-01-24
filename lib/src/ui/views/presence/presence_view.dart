import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:resident_app/src/helpers/scalable_dp_helper.dart';
import 'package:resident_app/src/ui/shared/colors.dart';
import 'package:resident_app/src/ui/shared/dimens.dart';
import 'package:resident_app/src/ui/shared/images.dart';
import 'package:resident_app/src/ui/shared/strings.dart';
import 'package:resident_app/src/ui/shared/styles.dart';
import 'package:resident_app/src/ui/shared/ui_helpers.dart';
import 'package:resident_app/src/ui/widgets/chip.dart';
import 'package:stacked/stacked.dart';

import 'presence_viewmodel.dart';

class PresenceView extends StatefulWidget {
  final File? faceImagePath;
  final Widget? image;

  const PresenceView({
    Key? key,
    this.faceImagePath,
    this.image,
  }) : super(key: key);

  @override
  State<PresenceView> createState() => _PresenceViewState();
}

class _PresenceViewState extends State<PresenceView> {
  @override
  Widget build(BuildContext context) {
    SDP.init(context);
    return ViewModelBuilder<PresenceViewModel>.reactive(
      builder: (context, vm, child) => WillPopScope(
        onWillPop: () async => main(),
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: BaseColors.main,
                size: SDP.sdp(18.0),
              ),
              onPressed: () => main(),
            ),
            title: Text(
              'Kehadiran',
              style: mainBoldTextStyle.copyWith(
                fontSize: SDP.sdp(headline5),
              ),
            ),
            backgroundColor: BaseColors.primary,
            elevation: 0,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(SDP.sdp(padding)),
              child: Column(
                children: [
                  Container(
                    height: SDP.sdp(430.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(SDP.sdp(smallRadius)),
                      border: Border.all(color: BaseColors.grey),
                      color: BaseColors.bgPin,
                    ),
                    child: vm.imagePicked != null
                        ? Container(
                            width: screenWidth(context),
                            child: Padding(
                              padding: EdgeInsets.all(SDP.sdp(4.0)),
                              child: vm.image,
                            ),
                          )
                        : Center(
                            child: Container(
                              width: SDP.sdp(100.0),
                              height: SDP.sdp(100.0),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: BaseColors.borderUpload),
                                shape: BoxShape.circle,
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(SDP.sdp(padding)),
                                child: SvgPicture.asset(iconCamera),
                              ),
                            ),
                          ),
                  ),
                  verticalSpace(SDP.sdp(padding)),
                  SizedBox(
                    width: double.infinity,
                    height: SDP.sdp(50.0),
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
                      color: BaseColors.main,
                      child: Center(
                        child: Text(
                          vm.imagePicked == null
                              ? Strings.actionTakePicture
                              : Strings.actionSendPresence,
                          style: whiteBoldTextStyle.copyWith(
                            fontSize: SDP.sdp(headline55),
                          ),
                        ),
                      ),
                      onPressed: () => setState(() {
                        vm.imagePicked == null
                            ? vm.cameraPermission(context)
                            : vm.checkDistanceLocation(context, vm);
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      viewModelBuilder: () => PresenceViewModel(
        imagePicked: widget.faceImagePath,
        image: widget.image,
      ),
    );
  }

  main() => Navigator.popUntil(context, (route) => route.isFirst);
}
