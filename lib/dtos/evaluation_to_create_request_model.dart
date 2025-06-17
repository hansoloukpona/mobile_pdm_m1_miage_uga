
class EvaluationToCreateRequest {
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
  final bool isAnonymous;

  EvaluationToCreateRequest({
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
    this.isAnonymous = false,
  });

  factory EvaluationToCreateRequest.fromJson(Map<String, dynamic> json) {
    return EvaluationToCreateRequest(
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
      isAnonymous: json['is_anonymous'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
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
      'is_anonymous': isAnonymous,
    };
  }
}