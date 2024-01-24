import 'package:json_annotation/json_annotation.dart';

part 'skrining_req.g.dart';

@JsonSerializable()
class SkriningReq {
  @JsonKey(name: 'naming_series')
  String? namingSeries;
  @JsonKey(name: 'employee')
  String? employee;
  @JsonKey(name: 'employee_name')
  String? employeeName;
  @JsonKey(name: 'date')
  String? date;
  @JsonKey(name: 'sehat1')
  String? healthy;
  @JsonKey(name: 'suhu_tubuh')
  String? bodyTemperature;
  @JsonKey(name: 'ada_batuk_atau_pilek')
  String? coughOrCold;
  @JsonKey(name: 'nyeri_tenggorokan')
  String? soreThroat;
  @JsonKey(name: 'sesak_nafas')
  String? outOfBreath;
  @JsonKey(name: '14_terakhir_ada_keluar_kotanegeri')
  String? outOfTownCity;
  @JsonKey(name: 'doctype')
  String? doctype;

  SkriningReq({
    this.namingSeries,
    this.employee,
    this.employeeName,
    this.date,
    this.healthy,
    this.bodyTemperature,
    this.coughOrCold,
    this.soreThroat,
    this.outOfBreath,
    this.outOfTownCity,
    this.doctype,
  });

  factory SkriningReq.fromJson(Map<String, dynamic> json) =>
      _$SkriningReqFromJson(json);

  Map<String, dynamic> toJson() => _$SkriningReqToJson(this);
}
