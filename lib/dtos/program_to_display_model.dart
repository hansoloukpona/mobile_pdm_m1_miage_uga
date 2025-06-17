import 'package:json_annotation/json_annotation.dart';


@JsonSerializable()
class ProgramToDisplay {
  String id;
  String name;
  String? description;
  String level;
  String field;
  String? duration;
  String universityId;

  //Détails d'université
  String uniName;
  String country;
  String city;

  //Détails évaluation
  int selectivityScore;     // 1 à 5
  int qualityScore;         // 1 à 5
  int rigorScore;           // 1 à 5
  int supervisionScore;     // 1 à 5
  int satisfactionScore;    // 1 à 5
  bool hasDroppedOut;
  List<String> comment;


  ProgramToDisplay(this.id, this.name, this.level, this.field, this.universityId, this.uniName, this.country, this.city, this.selectivityScore, this.qualityScore, this.rigorScore, this.supervisionScore, this.satisfactionScore, this.hasDroppedOut, this.comment);

  factory ProgramToDisplay.fromJson(Map<String, dynamic> json) =>
      _$ProgramToDisplayFromJson(json);

  Map<String, dynamic> toJson() => _$ProgramToDisplayToJson(this);

}