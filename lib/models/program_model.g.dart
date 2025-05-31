// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'program_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Program _$ProgramFromJson(Map<String, dynamic> json) =>
    Program(
        json['name'] as String,
        json['level'] as String,
        json['field'] as String,
        json['universityId'] as String,
      )
      ..id = json['id'] as String?
      ..description = json['description'] as String?
      ..duration = json['duration'] as String?;

Map<String, dynamic> _$ProgramToJson(Program instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'level': instance.level,
  'field': instance.field,
  'duration': instance.duration,
  'universityId': instance.universityId,
};
