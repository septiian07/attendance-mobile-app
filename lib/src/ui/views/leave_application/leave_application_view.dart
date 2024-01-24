import 'package:flutter/material.dart';
import 'package:resident_app/src/helpers/scalable_dp_helper.dart';
import 'package:resident_app/src/ui/shared/colors.dart';
import 'package:resident_app/src/ui/shared/dimens.dart';
import 'package:resident_app/src/ui/shared/strings.dart';
import 'package:resident_app/src/ui/shared/styles.dart';
import 'package:resident_app/src/ui/widgets/item_leave_application.dart';
import 'package:stacked/stacked.dart';

import 'leave_application_viewmodel.dart';

class LeaveApplicationView extends StatefulWidget {
  const LeaveApplicationView({Key? key}) : super(key: key);

  @override
  State<LeaveApplicationView> createState() => _LeaveApplicationViewState();
}

class _LeaveApplicationViewState extends State<LeaveApplicationView> {
  @override
  Widget build(BuildContext context) {
    SDP.init(context);
    return ViewModelBuilder<LeaveApplicationViewModel>.reactive(
      builder: (context, vm, child) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: BaseColors.main,
              size: SDP.sdp(18.0),
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            Strings.labelLeaveApplication,
            style: mainBoldTextStyle.copyWith(
              fontSize: SDP.sdp(headline5),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () => vm.newLeaveApplication(),
              icon: Icon(
                Icons.add_box,
                color: BaseColors.main,
                semanticLabel: '${Strings.labelLeaveApplication} Baru',
              ),
            )
          ],
          backgroundColor: BaseColors.primary,
          elevation: 0,
        ),
        body: Padding(
          padding: EdgeInsets.all(SDP.sdp(smallPadding)),
          child: Column(
            children: [
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    vm.getLeaveApplicationList(vm.user?.name ?? '');
                  },
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView(
                          shrinkWrap: true,
                          children: vm.leaveApplicationList!
                              .map((item) => ItemLeaveApplication(
                                    item: item,
                                  ))
                              .toList(),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      viewModelBuilder: () => LeaveApplicationViewModel(),
    );
  }
}
