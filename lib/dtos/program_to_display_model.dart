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

  /*factory ProgramToDisplay.fromJson(Map<String, dynamic> json) =>
      _$ProgramToDisplayFromJson(json);

  Map<String, dynamic> toJson() => _$ProgramToDisplayToJson(this);*/

  factory ProgramToDisplay.fromJson(Map<String, dynamic> json) {
    return ProgramToDisplay(
      json['id'],
      json['name'],
      json['level'],
      json['field'],
      json['universityId'],
      json['uniName'],
      json['country'],
      json['city'],
      json['selectivityScore'],
      json['qualityScore'],
      json['rigorScore'],
      json['supervisionScore'],
      json['satisfactionScore'],
      json['hasDroppedOut'] ?? false,
      List<String>.from(json['comment'] ?? []),

    )
    ..description = json['description'] as String?
    ..duration = json['duration'] as String?;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'level': level,
      'field': field,
      'duration': duration,
      'universityId': universityId,
      'uniName': uniName,
      'country': country,
      'city': city,
      'selectivityScore': selectivityScore,
      'qualityScore': qualityScore,
      'rigorScore': rigorScore,
      'supervisionScore': supervisionScore,
      'satisfactionScore': satisfactionScore,
      'hasDroppedOut': hasDroppedOut,
      'comment': comment,
    };
  }

}