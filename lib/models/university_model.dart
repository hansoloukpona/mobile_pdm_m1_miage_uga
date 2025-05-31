

import 'package:json_annotation/json_annotation.dart';

part 'university_model.g.dart';

@JsonSerializable()
class University {
  String? id;
  String name;
  String country;
  String city;
  String? website;
  String type;

  University(this.name, this.country, this.city, this.type);

  factory University.fromJson(Map<String, dynamic> json) =>
      _$UniversityFromJson(json);

  Map<String, dynamic> toJson() => _$UniversityToJson(this);

}