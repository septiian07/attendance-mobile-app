import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:resident_app/src/helpers/scalable_dp_helper.dart';
import 'package:resident_app/src/models/employee.dart';
import 'package:resident_app/src/ui/shared/colors.dart';
import 'package:resident_app/src/ui/shared/dimens.dart';
import 'package:resident_app/src/ui/shared/styles.dart';
import 'package:resident_app/src/ui/shared/ui_helpers.dart';
import 'package:resident_app/src/ui/widgets/detail_skrining_bottom_sheet.dart';
import 'package:resident_app/src/ui/widgets/filter_history_checkin.dart';
import 'package:resident_app/src/ui/widgets/item_history_checkin.dart';
import 'package:stacked/stacked.dart';
import 'history_viewmodel.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({Key? key}) : super(key: key);

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 1,
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _tabController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SDP.init(context);
    return ViewModelBuilder<HistoryViewModel>.reactive(
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
            'Riwayat',
            style: mainBoldTextStyle.copyWith(
              fontSize: SDP.sdp(headline5),
            ),
          ),
          backgroundColor: BaseColors.primary,
          elevation: 0,
          actions: [
            IconButton(
              color: BaseColors.main,
              icon: const Icon(Icons.filter_list_rounded),
              iconSize: SDP.sdp(30),
              tooltip: 'Filter',
              onPressed: () {
                showFilter(context, vm, () {
                  setState(() {
                    vm.filter();
                  });
                }, () {
                  setState(() {
                    vm.clearFilter();
                  });
                });
              },
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(SDP.sdp(radius)),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: [
                    verticalSpace(SDP.sdp(defaultPadding)),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: SDP.sdp(smallPadding),
                      ),
                      child: Container(
                        height: SDP.sdp(40.0),
                        decoration: BoxDecoration(
                          color: BaseColors.tabOff,
                          borderRadius: BorderRadius.circular(
                            SDP.sdp(space),
                          ),
                        ),
                        child: TabBar(
                          isScrollable: false,
                          controller: _tabController,
                          indicator: BoxDecoration(
                            border: Border.all(
                              color: BaseColors.tabOff,
                              width: SDP.sdp(4.0),
                            ),
                            borderRadius: BorderRadius.circular(
                              SDP.sdp(space),
                            ),
                            color: BaseColors.primary,
                          ),
                          labelColor: Colors.white,
                          labelStyle: whiteRegularTextStyle.copyWith(
                            fontSize: SDP.sdp(headline6),
                          ),
                          unselectedLabelColor: Colors.black,
                          unselectedLabelStyle: blackRegularTextStyle.copyWith(
                            fontSize: SDP.sdp(headline6),
                          ),
                          tabs: const [
                            Tab(
                              text: 'Kehadiran',
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        physics: const BouncingScrollPhysics(),
                        controller: _tabController,
                        children: [
                          RefreshIndicator(
                            onRefresh: () async {
                              setState(() {
                                vm.clearFilter();
                              });
                              vm.getHistoryCheckin(vm.employee?.employee ?? '');
                            },
                            child: Column(
                              children: [
                                Expanded(
                                  child: ListView(
                                    children: [
                                      ListView.builder(
                                        shrinkWrap: true,
                                        physics: const BouncingScrollPhysics(),
                                        itemCount: vm.checkinList?.length ?? 0,
                                        padding: EdgeInsets.symmetric(
                                          horizontal: SDP.sdp(smallPadding),
                                        ),
                                        itemBuilder: (context, index) {
                                          final item = vm.checkinList?[index];
                                          return ItemHistoryCheckin(
                                            item: item!,
                                          );
                                        },
                                      ),
                                      verticalSpace(SDP.sdp(bigSpace)),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      viewModelBuilder: () => HistoryViewModel(),
    );
  }

  void showConfirmation(
    BuildContext context,
    Employee employee,
  ) {
    showStickyFlexibleBottomSheet<void>(
      minHeight: 0,
      initHeight: 0.7,
      maxHeight: 0.9,
      headerHeight: 26.0,
      context: context,
      isDismissible: false,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30.0),
        ),
      ),
      anchors: [.7],
      headerBuilder: (BuildContext context, double offset) {
        return Container();
      },
      bodyBuilder: (BuildContext context, double bottomSheetOffset) {
        return SliverChildListDelegate(
          [DetailSkriningBottomSheet(employee: employee)],
        );
      },
    );
  }

  void showFilter(
    BuildContext context,
    HistoryViewModel vm,
    VoidCallback onConfirm,
    VoidCallback onClear,
  ) {
    showStickyFlexibleBottomSheet<void>(
      minHeight: 0,
      initHeight: 0.3,
      maxHeight: 0.9,
      headerHeight: 26.0,
      context: context,
      isDismissible: false,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30.0),
        ),
      ),
      anchors: [.7],
      headerBuilder: (BuildContext context, double offset) {
        return Container();
      },
      bodyBuilder: (BuildContext context, double bottomSheetOffset) {
        return SliverChildListDelegate(
          [
            FilterHistoryCheckin(vm: vm, onConfirm: onConfirm),
          ],
        );
      },
    );
  }
}
