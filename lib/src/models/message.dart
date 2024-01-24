import 'package:json_annotation/json_annotation.dart';

import 'employee.dart';

part 'message.g.dart';

@JsonSerializable()
class Message {
  @JsonKey(name: 'message')
  Employee? message;

  Message({
    this.message,
  });

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}
