import 'package:flutter/material.dart';
import 'package:resident_app/src/helpers/scalable_dp_helper.dart';
import 'package:resident_app/src/helpers/validator/validator.dart';
import 'package:resident_app/src/ui/shared/colors.dart';
import 'package:resident_app/src/ui/shared/dimens.dart';
import 'package:resident_app/src/ui/shared/images.dart';
import 'package:resident_app/src/ui/shared/strings.dart';
import 'package:resident_app/src/ui/shared/styles.dart';
import 'package:resident_app/src/ui/shared/ui_helpers.dart';
import 'package:resident_app/src/ui/widgets/chip.dart';
import 'package:resident_app/src/ui/widgets/textfield.dart';
import 'package:stacked/stacked.dart';

import 'login_viewmodel.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    SDP.init(context);
    return ViewModelBuilder<LoginViewModel>.reactive(
      builder: (context, vm, child) => Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SDP.sdp(defaultPadding),
          ),
          child: Stack(
            children: [
              Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: SDP.sdp(94),
                        height: SDP.sdp(94),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(SDP.sdp(26)),
                          image: DecorationImage(
                            image: AssetImage(logo),
                            opacity: 0.9,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      verticalSpace(SDP.sdp(12.0)),
                      Form(
                        key: vm.formKey,
                        autovalidateMode: AutovalidateMode.disabled,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            KTextField(
                              isDense: true,
                              maxLines: 1,
                              borderRadius: SDP.sdp(smallRadius),
                              controller: vm.emailController,
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              backgroundColor: Colors.white,
                              borderColor: Colors.grey.withOpacity(0.4),
                              placeholder: Strings.hintEmail,
                              placeholderStyle: hintRegularTextStyle.copyWith(
                                fontSize: SDP.sdp(hint),
                              ),
                              validator: Validator.emailValidator,
                            ),
                            verticalSpace(SDP.sdp(10.0)),
                            KTextField(
                              isDense: true,
                              maxLines: 1,
                              borderRadius: SDP.sdp(smallRadius),
                              textInputAction: TextInputAction.go,
                              controller: vm.passwordController,
                              backgroundColor: Colors.white,
                              borderColor: Colors.grey.withOpacity(0.4),
                              placeholder: Strings.hintPassword,
                              onFieldSubmitted: (val) => vm.validate(),
                              placeholderStyle: hintRegularTextStyle.copyWith(
                                fontSize: SDP.sdp(hint),
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    vm.obscure = !vm.obscure;
                                  });
                                },
                                icon: Icon(
                                  vm.obscure
                                      ? Icons.remove_red_eye
                                      : Icons.visibility_off,
                                  size: SDP.sdp(16.0),
                                  color: vm.obscure
                                      ? BaseColors.grey
                                      : Colors.black,
                                ),
                              ),
                              obscure: vm.obscure,
                              validator: Validator.passwordValidator,
                            ),
                          ],
                        ),
                      ),
                      verticalSpace(SDP.sdp(12.0)),
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
                              Strings.actionLogin,
                              style: whiteBoldTextStyle.copyWith(
                                fontSize: SDP.sdp(headline55),
                              ),
                            ),
                          ),
                          onPressed: () => vm.validate(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: MediaQuery.of(context).viewInsets.bottom == 0.0,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: SDP.sdp(smallPadding)),
                    child: Container(
                      color: BaseColors.background,
                      height: SDP.sdp(34.0),
                      child: Image.asset(logoHPY),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      viewModelBuilder: () => LoginViewModel(),
    );
  }
}
