import 'package:json_annotation/json_annotation.dart';

part 'customerregis.g.dart';

@JsonSerializable()
class CustomerRegis {
  @JsonKey(name: 'series')
  String? series = "CRF-.YYYY.-.MM.-";

  @JsonKey(name: 'status_toko')
  String? statusToko;

  @JsonKey(name: 'perusahaantoko')
  String? perusahaantoko;

  @JsonKey(name: 'alamat_pengiriman')
  String? alamatPengiriman;

  @JsonKey(name: 'mobile_kirim')
  String? mobileKrim;

  @JsonKey(name: 'tlp_kirim')
  String? telpKirim;

  @JsonKey(name: 'alamat_penagihan')
  String? alamatPenagihan;

  @JsonKey(name: 'tlp_tagih')
  String? telpPenagihan;

  @JsonKey(name: 'mobile_tagih')
  String? mobilePenagihan;

  @JsonKey(name: 'contoh_brand_yang_di_jual')
  String? contohBrand;

  @JsonKey(name: 'segmentasi')
  String? segmentasi;

  @JsonKey(name: 'nama')
  String? namaPemilik;

  @JsonKey(name: 'alamat')
  String? alamatPemilik;

  @JsonKey(name: 'tlp_pemilik')
  String? telpPemilik;

  @JsonKey(name: 'mobile_pemilik')
  String? mobilePemilik;

  @JsonKey(name: 'email')
  String? emailPemilik;

  @JsonKey(name: 'nama_npwp')
  String? npwpNama;

  @JsonKey(name: 'alamat_npwp')
  String? npwpAlamat;

  @JsonKey(name: 'no_npwp')
  String? npwpNo;

  @JsonKey(name: 'limit_amount')
  double? limitAmount;

  CustomerRegis();

  factory CustomerRegis.fromJson(Map<String, dynamic> json) =>
      _$CustomerRegisFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerRegisToJson(this);
}
