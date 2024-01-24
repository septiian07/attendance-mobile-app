import 'package:flutter/material.dart';
import 'package:resident_app/src/helpers/scalable_dp_helper.dart';
import 'package:resident_app/src/ui/shared/colors.dart';
import 'package:resident_app/src/ui/shared/dimens.dart';
import 'package:resident_app/src/ui/shared/styles.dart';
import 'package:resident_app/src/ui/shared/ui_helpers.dart';
import 'package:resident_app/src/ui/views/home/home_viewmodel.dart';
import 'package:resident_app/src/ui/widgets/chip.dart';

class AuthActionButton extends StatefulWidget {
  final Future _initializeControllerFuture;
  final Function onPressed;
  final bool isDetect;
  final HomeViewModel vm;

  const AuthActionButton(
    this._initializeControllerFuture, {
    Key? key,
    required this.onPressed,
    required this.isDetect,
    required this.vm,
  }) : super(key: key);

  @override
  _AuthActionButtonState createState() => _AuthActionButtonState();
}

class _AuthActionButtonState extends State<AuthActionButton> {
  @override
  Widget build(BuildContext context) {
    SDP.init(context);
    return FloatingActionButton.extended(
      label: widget.isDetect
          ? Text(
              'Deteksi Wajah',
              style: blackSemiBoldTextStyle.copyWith(
                fontSize: SDP.sdp(headline6),
              ),
            )
          : Text(
              'Daftarkan Wajah',
              style: blackSemiBoldTextStyle.copyWith(
                fontSize: SDP.sdp(headline6),
              ),
            ),
      icon: Icon(Icons.camera_alt),
      onPressed: () async {
        try {
          await widget._initializeControllerFuture;
          bool faceDetected = await widget.onPressed();

          if (faceDetected) {
            if (widget.isDetect) {
              widget.vm.predictUser()?.then((value) {
                if (value != null) {
                  setState(() {
                    widget.vm.predictEmployee = widget.vm.employee;
                  });
                }
              });
              widget.vm.showPresence();
            } else {
              Scaffold.of(context)
                  .showBottomSheet((context) => faceDetectSheet(context));
            }
          }
        } catch (e) {
          print(e);
        }
      },
    );
  }

  faceDetectSheet(context) {
    return Container(
      padding: EdgeInsets.all(20),
      height: SDP.sdp(200),
      child: Column(
        children: [
          widget.isDetect && widget.vm.predictEmployee != null
              ? Container(
                  child: Column(
                    children: [
                      Text(
                        'Halo, ${widget.vm.predictEmployee!.employeeName}.',
                        style: blackRegularTextStyle.copyWith(
                            fontSize: SDP.sdp(headline5)),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'Silahkan lanjutkan untuk konfirmasi form kehadiran',
                        style: blackRegularTextStyle.copyWith(
                            fontSize: SDP.sdp(headline5)),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                )
              : widget.isDetect
                  ? Container(
                      child: Text(
                      'Pengguna tidak ditemukan, silahkan coba kembali',
                      style: blackRegularTextStyle.copyWith(
                          fontSize: SDP.sdp(headline5)),
                      textAlign: TextAlign.center,
                    ))
                  : Container(),
          verticalSpace(smallPadding),
          widget.isDetect && widget.vm.predictEmployee != null
              ? SizedBox(
                  width: double.infinity,
                  height: SDP.sdp(50.0),
                  child: KChip(
                    isLoading: widget.vm.isBusy,
                    isDisabled: widget.vm.isBusy,
                    padding: EdgeInsets.symmetric(
                      vertical: SDP.sdp(14.0),
                    ),
                    loadingColor: Colors.white,
                    borderRadius: BorderRadius.circular(
                      SDP.sdp(smallRadius),
                    ),
                    color: BaseColors.primary,
                    child: Center(
                      child: Text(
                        'Selanjutnya',
                        style: whiteBoldTextStyle.copyWith(
                            fontSize: SDP.sdp(headline5)),
                      ),
                    ),
                    onPressed: () => widget.vm.showPresence(),
                  ),
                )
              : !widget.isDetect
                  ? Column(
                      children: [
                        Text(
                          'Klik untuk mendaftarkan wajah Anda ke sistem',
                          style: blackRegularTextStyle.copyWith(
                              fontSize: SDP.sdp(headline5)),
                          textAlign: TextAlign.center,
                        ),
                        verticalSpace(smallPadding),
                        SizedBox(
                          width: double.infinity,
                          height: SDP.sdp(50.0),
                          child: KChip(
                            isLoading: widget.vm.isBusy,
                            isDisabled: widget.vm.isBusy,
                            padding: EdgeInsets.symmetric(
                              vertical: SDP.sdp(14.0),
                            ),
                            loadingColor: Colors.white,
                            borderRadius: BorderRadius.circular(
                              SDP.sdp(smallRadius),
                            ),
                            color: BaseColors.primary,
                            child: Center(
                              child: Text(
                                'Daftar',
                                style: whiteBoldTextStyle.copyWith(
                                    fontSize: SDP.sdp(headline3)),
                              ),
                            ),
                            onPressed: () async =>
                                widget.vm.registerFace(context),
                          ),
                        ),
                      ],
                    )
                  : Container(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
