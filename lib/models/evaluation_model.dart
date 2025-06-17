

class Evaluation {
  final String id;
  final String? userId;
  final String programId;
  final int studyYear;
  final int submissionYear;
  final int selectivityScore;     // 1 à 5
  final int qualityScore;         // 1 à 5
  final int rigorScore;           // 1 à 5
  final int supervisionScore;     // 1 à 5
  final int satisfactionScore;    // 1 à 5
  final bool hasDroppedOut;
  final String? comment;
  final DateTime submittedAt;
  final DateTime? updatedAt;
  final bool isAnonymous;

  Evaluation({
    required this.id,
    required this.userId,
    required this.programId,
    required this.studyYear,
    required this.submissionYear,
    required this.selectivityScore,
    required this.qualityScore,
    required this.rigorScore,
    required this.supervisionScore,
    required this.satisfactionScore,
    this.hasDroppedOut = false,
    this.comment,
    required this.submittedAt,
    this.updatedAt,
    this.isAnonymous = false,
  });

  factory Evaluation.fromJson(Map<String, dynamic> json) {
    return Evaluation(
      id: json['id'],
      userId: json['user_id'],
      programId: json['program_id'],
      studyYear: json['study_year'],
      submissionYear: json['submission_year'],
      selectivityScore: json['selectivity_score'],
      qualityScore: json['quality_score'],
      rigorScore: json['rigor_score'],
      supervisionScore: json['supervision_score'],
      satisfactionScore: json['satisfaction_score'],
      hasDroppedOut: json['has_dropped_out'] ?? false,
      comment: json['comment'],
      submittedAt: DateTime.parse(json['submitted_at']),
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
      isAnonymous: json['is_anonymous'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'program_id': programId,
      'study_year': studyYear,
      'submission_year': submissionYear,
      'selectivity_score': selectivityScore,
      'quality_score': qualityScore,
      'rigor_score': rigorScore,
      'supervision_score': supervisionScore,
      'satisfaction_score': satisfactionScore,
      'has_dropped_out': hasDroppedOut,
      'comment': comment,
      'submitted_at': submittedAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'is_anonymous': isAnonymous,
    };
  }
}