// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'university_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

University _$UniversityFromJson(Map<String, dynamic> json) =>
    University(
        json['name'] as String,
        json['country'] as String,
        json['city'] as String,
        json['type'] as String,
      )
      ..id = json['id'] as String?
      ..website = json['website'] as String?;

Map<String, dynamic> _$UniversityToJson(University instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'country': instance.country,
      'city': instance.city,
      'website': instance.website,
      'type': instance.type,
    };
