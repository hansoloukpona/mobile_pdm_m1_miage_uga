import 'avis.dart';

class Formations {
  String nom;
  String universite;
  String ville;
  double? tauxAdmission;
  int? nbCandidatures;
  double? noteMinimale;
  int? selectiviteRessentie; // 1 à 5
  List<String>? criteresSelection;
  String? delaiReponse; // Rapide / Moyen / Long
  String? commentaire;
  late List<Avis>? avis;

  Formations({
    required this.nom,
    required this.ville,
    required this.universite,
    this.tauxAdmission,
    this.nbCandidatures,
    this.noteMinimale,
    this.selectiviteRessentie,
    this.criteresSelection,
    this.delaiReponse,
    this.commentaire,
    this.avis,
  });

  factory Formations.fromJson(Map<String, dynamic> json) {
    return Formations(
      nom: json['nom'],
      universite: json['universite'],
      ville: json['ville'],
      tauxAdmission: (json['tauxAdmission'] as num?)?.toDouble(),
      nbCandidatures: json['nbCandidatures'],
      noteMinimale: (json['noteMinimale'] as num?)?.toDouble(),
      selectiviteRessentie: json['selectiviteRessentie'],
      criteresSelection: List<String>.from(json['criteresSelection'] ?? []),
      delaiReponse: json['delaiReponse'],
      commentaire: json['commentaire'],
      avis: json['avis'] != null
          ? (json['avis'] as List).map((e) => Avis.fromJson(e)).toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nom': nom,
      'universite': universite,
      'tauxAdmission': tauxAdmission,
      'nbCandidatures': nbCandidatures,
      'noteMinimale': noteMinimale,
      'selectiviteRessentie': selectiviteRessentie,
      'criteresSelection': criteresSelection,
      'delaiReponse': delaiReponse,
      'commentaire': commentaire,
      'avis': avis?.map((e) => e.toJson()).toList(),
    };
  }

  double? get moyenneAvis {
    if (avis == null || avis!.isEmpty) return null;
    final total = avis!.fold<double>(0, (sum, a) => sum + a.note);
    return total / avis!.length;
  }

  // Setters
  set setNom(String nom) => this.nom = nom;
  set setUniversite(String universite) => this.universite = universite;
  set setVille(String ville) => this.ville = ville;
  set setTauxAdmission(double? tauxAdmission) => this.tauxAdmission = tauxAdmission;
  set setNbCandidatures(int? nbCandidatures) => this.nbCandidatures = nbCandidatures;
  set setNoteMinimale(double? noteMinimale) => this.noteMinimale = noteMinimale;
  set setSelectiviteRessentie(int? selectiviteRessentie) => this.selectiviteRessentie = selectiviteRessentie;
  set setCriteresSelection(List<String>? criteresSelection) => this.criteresSelection = criteresSelection;
  set setDelaiReponse(String? delaiReponse) => this.delaiReponse = delaiReponse;
  set setCommentaire(String? commentaire) => this.commentaire = commentaire;
  set setAvis(List<Avis>? avis) => this.avis = avis;
}
