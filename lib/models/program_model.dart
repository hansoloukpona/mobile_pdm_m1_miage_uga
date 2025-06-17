import 'package:json_annotation/json_annotation.dart';

part 'program_model.g.dart';

@JsonSerializable()
class Program {
  String id;
  String name;
  String? description;
  String level;
  String field;
  String? duration;
  String universityId;


  Program(this.id, this.name, this.level, this.field, this.universityId);

  factory Program.fromJson(Map<String, dynamic> json) =>
      _$ProgramFromJson(json);

  Map<String, dynamic> toJson() => _$ProgramToJson(this);

}