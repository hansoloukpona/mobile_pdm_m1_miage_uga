import 'package:json_annotation/json_annotation.dart';

part 'program_to_search_request_model.g.dart'; // nom basé sur ton fichier .dart

@JsonSerializable()
class ProgramToSearchRequest {
  String? name;
  String? description;
  String? level;
  String? field;
  String? duration;
  String? universityId;
  int page;
  int size;
  String sortField;
  String sortDirection;

  ProgramToSearchRequest({
    this.name,
    this.description,
    this.level,
    this.field,
    this.duration,
    this.universityId,
    this.page = 0,
    this.size = 10,
    this.sortField = "name",
    this.sortDirection = "ASC",
  });

  factory ProgramToSearchRequest.fromJson(Map<String, dynamic> json) =>
      _$ProgramToSearchRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ProgramToSearchRequestToJson(this);
}