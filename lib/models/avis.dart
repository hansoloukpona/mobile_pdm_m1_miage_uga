class Avis {
  final double note;
  final String commentaire;
  final DateTime date;

  Avis({
    required this.note,
    required this.commentaire,
    required this.date,
  });

  Map<String, dynamic> toJson() => {
    'note': note,
    'commentaire': commentaire,
    'date': date.toIso8601String(),
  };

  factory Avis.fromJson(Map<String, dynamic> json) => Avis(
    note: (json['note'] as num).toDouble(),
    commentaire: json['commentaire'],
    date: DateTime.parse(json['date']),
  );
}
