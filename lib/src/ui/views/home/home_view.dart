import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:resident_app/src/app/app.locator.dart';
import 'package:resident_app/src/constant/config.dart';
import 'package:resident_app/src/helpers/scalable_dp_helper.dart';
import 'package:resident_app/src/services/ml_service.dart';
import 'package:resident_app/src/services/face_detector_service.dart';
import 'package:resident_app/src/ui/shared/colors.dart';
import 'package:resident_app/src/ui/shared/dimens.dart';
import 'package:resident_app/src/ui/shared/images.dart';
import 'package:resident_app/src/ui/shared/strings.dart';
import 'package:resident_app/src/ui/shared/styles.dart';
import 'package:resident_app/src/ui/shared/ui_helpers.dart';
import 'package:resident_app/src/ui/widgets/item_home_menu.dart';
import 'package:resident_app/src/ui/widgets/loading.dart';
import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  FaceDetectorService _faceDetectorService = locator<FaceDetectorService>();
  MLService _mlService = locator<MLService>();

  CameraDescription? cameraDescription;
  bool loading = false;
  var us;

  @override
  void initState() {
    super.initState();
    _startUp();
  }

  _startUp() async {
    _setLoading(true);

    List<CameraDescription> cameras = await availableCameras();

    cameraDescription = cameras.firstWhere(
      (CameraDescription camera) =>
          camera.lensDirection == CameraLensDirection.front,
    );

    await _mlService.loadModel();
    _faceDetectorService.initialize();

    _setLoading(false);
  }

  _setLoading(bool value) {
    setState(() {
      loading = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    SDP.init(context);
    return ViewModelBuilder<HomeViewModel>.reactive(
      builder: (context, vm, child) => Scaffold(
        backgroundColor: Colors.white,
        body: Loading(
          status: vm.isBusy || loading,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: SDP.sdp(159 + 27),
                  child: Stack(
                    children: [
                      Container(
                        height: SDP.sdp(159),
                        color: BaseColors.primary,
                        child: Center(
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: SDP.sdp(defaultPadding),
                            ),
                            leading: vm.employee?.image == null ||
                                    vm.employee?.image == ''
                                ? Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.grey[350],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Icon(
                                        Icons.person,
                                        size: SDP.sdp(40),
                                        color: BaseColors.greyDark,
                                      ),
                                    ),
                                  )
                                : ClipOval(
                                    child: Image.network(
                                      Config.basicUrl +
                                          (vm.employee?.image ?? ''),
                                      width: SDP.sdp(46.0),
                                      height: SDP.sdp(46.0),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                            title: Text(
                              Strings.labelWelcome,
                              style: whiteRegularTextStyle.copyWith(
                                fontSize: SDP.sdp(headline5),
                              ),
                            ),
                            subtitle: Text(
                              vm.fullName ?? '',
                              style: whiteBoldTextStyle.copyWith(
                                fontSize: SDP.sdp(headline4),
                              ),
                            ),
                            trailing: InkWell(
                              onTap: () => vm.showHistory(),
                              child: Icon(
                                Icons.history,
                                color: Colors.white,
                                size: SDP.sdp(24.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: SDP.sdp(smallPadding),
                        ),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            width: screenWidth(context),
                            height: SDP.sdp(54.0),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(SDP.sdp(10.0)),
                              color: Colors.white,
                              boxShadow: [shadow],
                            ),
                            child: ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: SDP.sdp(24.0),
                              ),
                              title: Text(
                                Strings.labelPresenceToday,
                                style: greySemiBoldTextStyle.copyWith(
                                  fontSize: SDP.sdp(headline6),
                                ),
                              ),
                              trailing: Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: SDP.sdp(12.0),
                                ),
                                child: ElevatedButton(
                                  onPressed: () => vm.checkFaceRecognized(
                                      context, cameraDescription!),
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        SDP.sdp(smallRadius),
                                      ),
                                    ),
                                    elevation: 0.0,
                                    primary: BaseColors.main,
                                  ),
                                  child: Text(
                                    Strings.labelPresence,
                                    style: whiteSemiBoldTextStyle.copyWith(
                                      fontSize: SDP.sdp(headline8),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                verticalSpace(SDP.sdp(40.0)),
                ItemHomeMenu(
                  menuLabel: Strings.labelLeaveApplication,
                  onTap: () => vm.showLeaveApplication(),
                  icon: iconApplication,
                ),
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => HomeViewModel(),
    );
  }
}
