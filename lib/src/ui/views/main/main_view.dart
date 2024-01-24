import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:resident_app/src/helpers/scalable_dp_helper.dart';
import 'package:resident_app/src/ui/shared/colors.dart';
import 'package:resident_app/src/ui/shared/dimens.dart';
import 'package:resident_app/src/ui/shared/strings.dart';
import 'package:resident_app/src/ui/shared/styles.dart';
import 'package:resident_app/src/ui/views/home/home_view.dart';
import 'package:resident_app/src/ui/views/profile/profile_view.dart';
import 'package:stacked/stacked.dart';

import '../blank_view.dart';
import 'main_viewmodel.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  Widget build(BuildContext context) {
    SDP.init(context);
    return ViewModelBuilder<MainViewModel>.reactive(
      builder: (context, vm, child) => Scaffold(
        body: PageTransitionSwitcher(
          duration: const Duration(milliseconds: 300),
          reverse: vm.reverse,
          transitionBuilder: (
            Widget child,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) {
            return SharedAxisTransition(
              child: child,
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              transitionType: SharedAxisTransitionType.horizontal,
            );
          },
          child: getViewForIndex(vm.currentIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          currentIndex: vm.currentIndex,
          selectedItemColor: BaseColors.primary,
          unselectedItemColor: BaseColors.unselected,
          selectedFontSize: SDP.sdp(12.0),
          unselectedFontSize: SDP.sdp(12.0),
          selectedLabelStyle: primarySemiBoldTextStyle,
          unselectedLabelStyle: greySemiBoldTextStyle.copyWith(
            color: BaseColors.unselected,
          ),
          onTap: vm.setIndex,
          items: [
            BottomNavigationBarItem(
              label: Strings.labelHome,
              icon: Padding(
                padding: EdgeInsets.all(SDP.sdp(iconNavPadding)),
                child: Icon(
                  Icons.home_filled,
                  size: SDP.sdp(iconNav),
                  color: BaseColors.unselected,
                ),
              ),
              activeIcon: Padding(
                padding: EdgeInsets.all(SDP.sdp(iconNavPadding)),
                child: Icon(
                  Icons.home_filled,
                  size: SDP.sdp(iconNav),
                  color: BaseColors.primary,
                ),
              ),
            ),
            BottomNavigationBarItem(
              label: Strings.labelProfile,
              icon: Padding(
                padding: EdgeInsets.all(SDP.sdp(iconNavPadding)),
                child: Icon(
                  Icons.account_circle,
                  size: SDP.sdp(iconNav),
                  color: BaseColors.unselected,
                ),
              ),
              activeIcon: Padding(
                padding: EdgeInsets.all(SDP.sdp(iconNavPadding)),
                child: Icon(
                  Icons.account_circle,
                  size: SDP.sdp(iconNav),
                  color: BaseColors.primary,
                ),
              ),
            ),
          ],
        ),
      ),
      viewModelBuilder: () => MainViewModel(),
    );
  }

  Widget getViewForIndex(int index) {
    switch (index) {
      case 0:
        return const HomeView();
      case 1:
        return const ProfileView();
      default:
        return const BlankView();
    }
  }
}
