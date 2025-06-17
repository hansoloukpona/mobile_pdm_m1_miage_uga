// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'program_to_search_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProgramToSearchRequest _$ProgramToSearchRequestFromJson(
  Map<String, dynamic> json,
) => ProgramToSearchRequest(
  name: json['name'] as String?,
  description: json['description'] as String?,
  level: json['level'] as String?,
  field: json['field'] as String?,
  duration: json['duration'] as String?,
  universityId: json['universityId'] as String?,
  page: (json['page'] as num?)?.toInt() ?? 0,
  size: (json['size'] as num?)?.toInt() ?? 10,
  sortField: json['sortField'] as String? ?? "name",
  sortDirection: json['sortDirection'] as String? ?? "ASC",
);

Map<String, dynamic> _$ProgramToSearchRequestToJson(
  ProgramToSearchRequest instance,
) => <String, dynamic>{
  'name': instance.name,
  'description': instance.description,
  'level': instance.level,
  'field': instance.field,
  'duration': instance.duration,
  'universityId': instance.universityId,
  'page': instance.page,
  'size': instance.size,
  'sortField': instance.sortField,
  'sortDirection': instance.sortDirection,
};
