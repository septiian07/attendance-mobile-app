import 'package:flutter/material.dart';
import 'package:resident_app/src/constant/config.dart';
import 'package:resident_app/src/helpers/scalable_dp_helper.dart';
import 'package:resident_app/src/helpers/validator/validator.dart';
import 'package:resident_app/src/ui/shared/colors.dart';
import 'package:resident_app/src/ui/shared/dimens.dart';
import 'package:resident_app/src/ui/shared/strings.dart';
import 'package:resident_app/src/ui/shared/styles.dart';
import 'package:resident_app/src/ui/shared/ui_helpers.dart';
import 'package:resident_app/src/ui/widgets/chip.dart';
import 'package:resident_app/src/ui/widgets/textfield.dart';
import 'package:stacked/stacked.dart';

import 'profile_viewmodel.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    SDP.init(context);
    return ViewModelBuilder<ProfileViewModel>.reactive(
      builder: (context, vm, child) => Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: SizedBox(
            height: screenHeight(context),
            child: vm.isBusy
                ? const Center(
                    child: loadingSpin,
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: SDP.sdp(189 + 27),
                        child: Stack(
                          children: [
                            Container(
                              height: SDP.sdp(189),
                              color: BaseColors.primary,
                              child: Center(
                                child: vm.employee?.image == null ||
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
                                            size: SDP.sdp(70),
                                            color: BaseColors.greyDark,
                                          ),
                                        ),
                                      )
                                    : ClipOval(
                                        child: Image.network(
                                          Config.basicUrl +
                                              (vm.employee?.image ?? ''),
                                          width: SDP.sdp(82.0),
                                          height: SDP.sdp(82.0),
                                          fit: BoxFit.cover,
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
                                  child: Center(
                                    child: Text(
                                      vm.employee?.employee ?? '',
                                      style: blackBoldTextStyle.copyWith(
                                        fontSize: SDP.sdp(headline5),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: SDP.sdp(smallPadding),
                          vertical: SDP.sdp(padding),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Email',
                              style: greyRegularTextStyle.copyWith(
                                fontSize: SDP.sdp(headline6),
                              ),
                            ),
                            verticalSpace(SDP.sdp(space)),
                            KTextField(
                              isDense: true,
                              enabled: false,
                              borderRadius: SDP.sdp(smallRadius),
                              controller: vm.emailController,
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              backgroundColor: Colors.white.withOpacity(0.8),
                              placeholder: Strings.hintEmail,
                              placeholderStyle: hintRegularTextStyle.copyWith(
                                fontSize: SDP.sdp(hint),
                              ),
                              validator: Validator.emailValidator,
                            ),
                            verticalSpace(SDP.sdp(smallPadding)),
                            Text(
                              'Nama',
                              style: greyRegularTextStyle.copyWith(
                                fontSize: SDP.sdp(headline6),
                              ),
                            ),
                            verticalSpace(SDP.sdp(space)),
                            KTextField(
                              isDense: true,
                              enabled: false,
                              borderRadius: SDP.sdp(smallRadius),
                              controller: vm.nameController,
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              backgroundColor: Colors.white.withOpacity(0.8),
                              placeholder: Strings.hintEmployeeName,
                              placeholderStyle: hintRegularTextStyle.copyWith(
                                fontSize: SDP.sdp(hint),
                              ),
                              validator: Validator.requiredValidator,
                            ),
                            verticalSpace(SDP.sdp(bigPadding)),
                            Center(
                              child: SizedBox(
                                width: screenWidthPercentage(
                                  context,
                                  percentage: 0.5,
                                ),
                                height: SDP.sdp(50.0),
                                child: KChip(
                                  isLoading: vm.isBusy,
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
                                      Strings.actionLogout,
                                      style: whiteBoldTextStyle.copyWith(
                                        fontSize: SDP.sdp(headline55),
                                      ),
                                    ),
                                  ),
                                  onPressed: () => vm.showLogoutConfirmDialog(
                                    title: Strings.messageLogout,
                                    positiveLabel: Strings.labelYes,
                                    negativeLabel: Strings.labelNo,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
      viewModelBuilder: () => ProfileViewModel(),
    );
  }
}
