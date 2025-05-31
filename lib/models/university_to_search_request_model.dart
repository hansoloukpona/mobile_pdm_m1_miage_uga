import 'package:json_annotation/json_annotation.dart';

part 'university_to_search_request_model.g.dart'; // nom basé sur ton fichier .dart

@JsonSerializable()
class UniversityToSearchRequest {
  String? name;
  String? country;
  String? city;
  String? type;
  int page;
  int size;
  String sortField;
  String sortDirection;

  UniversityToSearchRequest({
    this.name,
    this.country,
    this.city,
    this.type,
    this.page = 0,
    this.size = 10,
    this.sortField = "name",
    this.sortDirection = "ASC",
  });

  factory UniversityToSearchRequest.fromJson(Map<String, dynamic> json) =>
      _$UniversityToSearchRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UniversityToSearchRequestToJson(this);
}