import 'dart:async';
import 'dart:io';
import 'dart:math' as math;
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:resident_app/src/app/app.locator.dart';
import 'package:resident_app/src/helpers/scalable_dp_helper.dart';
import 'package:resident_app/src/services/camera_service.dart';
import 'package:resident_app/src/services/face_detector_service.dart';
import 'package:resident_app/src/services/ml_service.dart';
import 'package:resident_app/src/ui/shared/dimens.dart';
import 'package:resident_app/src/ui/shared/styles.dart';
import 'package:resident_app/src/ui/widgets/auth_action_button.dart';
import 'package:resident_app/src/ui/widgets/face_painter.dart';
import 'package:resident_app/src/ui/widgets/loading.dart';
import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart';

class HomeFaceRecognizedRegisView extends StatefulWidget {
  final CameraDescription cameraDescription;

  const HomeFaceRecognizedRegisView({Key? key, required this.cameraDescription})
      : super(key: key);

  @override
  HomeFaceRecognizedRegisViewState createState() =>
      HomeFaceRecognizedRegisViewState();
}

class HomeFaceRecognizedRegisViewState
    extends State<HomeFaceRecognizedRegisView> {
  String? imagePath;
  Face? faceDetected;
  Size? imageSize;

  bool _detectingFaces = false;
  bool pictureTaked = false;

  Future? _initializeControllerFuture;
  bool cameraInitializated = false;

  bool _saving = false;
  bool _bottomSheetVisible = false;

  bool loadingTakePicture = false;

  MLService _mlService = locator<MLService>();
  CameraService _cameraService = locator<CameraService>();
  FaceDetectorService _faceDetectorService = locator<FaceDetectorService>();

  @override
  void initState() {
    super.initState();

    _start();
  }

  @override
  void dispose() {
    _cameraService.dispose();
    _faceDetectorService.dispose();
    super.dispose();
  }

  _start() async {
    _initializeControllerFuture =
        _cameraService.startService(widget.cameraDescription);
    await _initializeControllerFuture;

    setState(() {
      cameraInitializated = true;
    });

    _frameFaces();
  }

  Future<bool> onShot(HomeViewModel vm) async {
    if (faceDetected == null) {
      loadingTakePicture = true;

      await Future.delayed(Duration(milliseconds: 500));
      await _cameraService.cameraController?.stopImageStream();
      await Future.delayed(Duration(milliseconds: 200));
      XFile file = await _cameraService.takePicture();
      imagePath = file.path;
      imageCache.clear();
      vm.faceImagePath = File(imagePath!);
      vm.image = Image.file(
        vm.faceImagePath!,
        fit: BoxFit.cover,
      );
      loadingTakePicture = false;

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(
              'No face detected!\n\nTap anywhere',
              style: blackRegularTextStyle.copyWith(
                fontSize: SDP.sdp(headline6),
              ),
            ),
          );
        },
      ).then((value) => vm.showPresence());

      return false;
    } else {
      _saving = true;
      await Future.delayed(Duration(milliseconds: 500));
      await _cameraService.cameraController?.stopImageStream();
      await Future.delayed(Duration(milliseconds: 200));
      XFile file = await _cameraService.takePicture();
      imagePath = file.path;
      imageCache.clear();

      setState(() {
        _bottomSheetVisible = true;
        pictureTaked = true;
      });

      return true;
    }
  }

  _frameFaces() {
    imageSize = _cameraService.getImageSize();

    _cameraService.cameraController?.startImageStream((image) async {
      if (_cameraService.cameraController != null) {
        if (_detectingFaces) return;

        _detectingFaces = true;

        try {
          List<Face> faces =
              await _faceDetectorService.detectFacesFromImage(image);

          if (faces.length > 0) {
            setState(() {
              faceDetected = faces[0];
            });

            if (_saving) {
              _mlService.setCurrentPrediction(image, faceDetected!);
              setState(() {
                _saving = false;
              });
            }
          } else {
            setState(() {
              faceDetected = null;
            });
          }

          _detectingFaces = false;
        } catch (e) {
          print(e);
          _detectingFaces = false;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final double mirror = math.pi;
    final width = MediaQuery.of(context).size.width;
    SDP.init(context);
    return ViewModelBuilder<HomeViewModel>.reactive(
      builder: (context, vm, child) => Scaffold(
        body: vm.isBusy
            ? const Center(child: CircularProgressIndicator())
            : Loading(
                status: loadingTakePicture,
                text: 'Sedang mengambil gambar...',
                child: FutureBuilder<void>(
                  future: _initializeControllerFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (pictureTaked) {
                        return Container(
                          width: width,
                          child: Transform(
                              alignment: Alignment.center,
                              child: Image.file(File(imagePath!)),
                              transform: Matrix4.rotationY(mirror)),
                        );
                      } else {
                        return Transform.scale(
                          scale: 1.0,
                          child: AspectRatio(
                            aspectRatio:
                                MediaQuery.of(context).size.aspectRatio,
                            child: OverflowBox(
                              alignment: Alignment.center,
                              child: FittedBox(
                                fit: BoxFit.fitHeight,
                                child: Container(
                                  width: width,
                                  height: width *
                                      _cameraService
                                          .cameraController!.value.aspectRatio,
                                  child: Stack(
                                    fit: StackFit.expand,
                                    children: <Widget>[
                                      CameraPreview(
                                          _cameraService.cameraController!),
                                      if (_faceDetectorService.faceDetected)
                                        CustomPaint(
                                          painter: FacePainter(
                                              face: faceDetected,
                                              imageSize: imageSize!),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: !_bottomSheetVisible
            ? AuthActionButton(
                _initializeControllerFuture!,
                onPressed: () => onShot(vm),
                isDetect: false,
                vm: vm,
              )
            : Container(),
      ),
      viewModelBuilder: () => HomeViewModel(),
    );
  }
}
