import 'package:json_annotation/json_annotation.dart';

part 'core_res_single.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class CoreResSingle<T> {
  String? message;
  T? data;

  CoreResSingle({
    this.message,
    this.data,
  });

  factory CoreResSingle.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$CoreResSingleFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$CoreResSingleToJson(this, toJsonT);
}
