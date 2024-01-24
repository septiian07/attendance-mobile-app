import 'package:flutter/material.dart';
import 'package:resident_app/src/helpers/scalable_dp_helper.dart';
import 'package:resident_app/src/models/employee.dart';
import 'package:resident_app/src/ui/shared/dimens.dart';
import 'package:resident_app/src/ui/shared/styles.dart';
import 'package:resident_app/src/ui/shared/ui_helpers.dart';

class DetailSkriningBottomSheet extends StatefulWidget {
  final Employee employee;

  const DetailSkriningBottomSheet({
    Key? key,
    required this.employee,
  }) : super(key: key);

  @override
  State<DetailSkriningBottomSheet> createState() =>
      _DetailSkriningBottomSheetState();
}

class _DetailSkriningBottomSheetState
    extends State<DetailSkriningBottomSheet> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    SDP.init(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: SDP.sdp(padding)),
          width: screenWidth(context),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Detail Skrining',
                style: blackBoldTextStyle.copyWith(
                  fontSize: SDP.sdp(headline2),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Tutup',
                  style: primaryBoldTextStyle.copyWith(
                    fontSize: SDP.sdp(headline4),
                  ),
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
        ),
        verticalSpace(SDP.sdp(28.0)),
        Center(
          child: Text(
            widget.employee.date ?? '',
            style: blackRegularTextStyle.copyWith(
              fontSize: SDP.sdp(headline5),
            ),
          ),
        ),
        verticalSpace(SDP.sdp(smallPadding)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: SDP.sdp(padding)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ID Karyawan: ',
                style: greyRegularTextStyle.copyWith(
                  fontSize: SDP.sdp(headline5),
                ),
              ),
              verticalSpace(SDP.sdp(space)),
              Text(
                widget.employee.employee ?? '',
                style: blackSemiBoldTextStyle.copyWith(
                  fontSize: SDP.sdp(headline3),
                ),
              ),
              verticalSpace(SDP.sdp(smallPadding)),
              Text(
                'Nama Karyawan: ',
                style: greyRegularTextStyle.copyWith(
                  fontSize: SDP.sdp(headline5),
                ),
              ),
              verticalSpace(SDP.sdp(space)),
              Text(
                widget.employee.employeeName ?? '',
                style: blackSemiBoldTextStyle.copyWith(
                  fontSize: SDP.sdp(headline3),
                ),
              ),
              verticalSpace(SDP.sdp(smallPadding)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        'Keterangan Sehat: ',
                        style: greyRegularTextStyle.copyWith(
                          fontSize: SDP.sdp(headline5),
                        ),
                      ),
                      verticalSpace(SDP.sdp(space)),
                      Text(
                        widget.employee.healthy ?? '',
                        style: blackSemiBoldTextStyle.copyWith(
                          fontSize: SDP.sdp(headline3),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        'Suhu Tubuh: ',
                        style: greyRegularTextStyle.copyWith(
                          fontSize: SDP.sdp(headline5),
                        ),
                      ),
                      verticalSpace(SDP.sdp(space)),
                      Text(
                        widget.employee.bodyTemperature ?? '',
                        style: blackSemiBoldTextStyle.copyWith(
                          fontSize: SDP.sdp(headline3),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              verticalSpace(SDP.sdp(smallPadding)),
              Text(
                'Ada batuk atau pilek: ',
                style: greyRegularTextStyle.copyWith(
                  fontSize: SDP.sdp(headline5),
                ),
              ),
              verticalSpace(SDP.sdp(space)),
              Text(
                widget.employee.coughOrCold ?? '',
                style: blackSemiBoldTextStyle.copyWith(
                  fontSize: SDP.sdp(headline3),
                ),
              ),
              verticalSpace(SDP.sdp(smallPadding)),
              Text(
                'Nyeri Tenggorokan: ',
                style: greyRegularTextStyle.copyWith(
                  fontSize: SDP.sdp(headline5),
                ),
              ),
              verticalSpace(SDP.sdp(space)),
              Text(
                widget.employee.soreThroat ?? '',
                style: blackSemiBoldTextStyle.copyWith(
                  fontSize: SDP.sdp(headline3),
                ),
              ),
              verticalSpace(SDP.sdp(smallPadding)),
              Text(
                'Sesak Nafas: ',
                style: greyRegularTextStyle.copyWith(
                  fontSize: SDP.sdp(headline5),
                ),
              ),
              verticalSpace(SDP.sdp(space)),
              Text(
                widget.employee.outOfBreath ?? '',
                style: blackSemiBoldTextStyle.copyWith(
                  fontSize: SDP.sdp(headline3),
                ),
              ),
              verticalSpace(SDP.sdp(smallPadding)),
              Text(
                '14 Hari ada keluar kota/negeri: ',
                style: greyRegularTextStyle.copyWith(
                  fontSize: SDP.sdp(headline5),
                ),
              ),
              verticalSpace(SDP.sdp(space)),
              Text(
                widget.employee.outOfTownCity ?? '',
                style: blackSemiBoldTextStyle.copyWith(
                  fontSize: SDP.sdp(headline3),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
