// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'university_to_search_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UniversityToSearchRequest _$UniversityToSearchRequestFromJson(
  Map<String, dynamic> json,
) => UniversityToSearchRequest(
  name: json['name'] as String?,
  country: json['country'] as String?,
  city: json['city'] as String?,
  type: json['type'] as String?,
  page: (json['page'] as num?)?.toInt() ?? 0,
  size: (json['size'] as num?)?.toInt() ?? 10,
  sortField: json['sortField'] as String? ?? "name",
  sortDirection: json['sortDirection'] as String? ?? "ASC",
);

Map<String, dynamic> _$UniversityToSearchRequestToJson(
  UniversityToSearchRequest instance,
) => <String, dynamic>{
  'name': instance.name,
  'country': instance.country,
  'city': instance.city,
  'type': instance.type,
  'page': instance.page,
  'size': instance.size,
  'sortField': instance.sortField,
  'sortDirection': instance.sortDirection,
};
