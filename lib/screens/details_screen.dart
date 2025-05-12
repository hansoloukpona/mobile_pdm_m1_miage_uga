import 'package:flutter/material.dart';
import '../models/formations.dart';

class DetailsScreen extends StatelessWidget {
  final Formations formation;
  /** const DetailsScreen({super.key, required Formations formation, required formations}); */
  const DetailsScreen({super.key,  required this.formation});
  @override
  Widget build(BuildContext context) {
    /** final formation = ModalRoute.of(context)!.settings.arguments as Formations;*/

    return Scaffold(
      appBar: AppBar(
        title: Text(formation.nom),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  formation.nom,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  formation.ville,
                  style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                ),
                Divider(height: 32),

                _buildRow("🎯 Taux d'admission", "${formation.tauxAdmission ?? 'N/A'} %"),
                _buildRow("📥 Nb. de candidatures", "${formation.nbCandidatures ?? 'N/A'}"),
                _buildRow("📊 Note minimale", "${formation.noteMinimale ?? 'N/A'}"),
                _buildRow("⏱ Temps de réponse", formation.delaiReponse ?? "Inconnu"),

                SizedBox(height: 16),
                Text("⭐ Sélectivité ressentie", style: TextStyle(fontWeight: FontWeight.bold)),
                Row(
                  children: List.generate(5, (i) {
                    return Icon(
                      i < (formation.selectiviteRessentie ?? 0) ? Icons.star : Icons.star_border,
                      color: Colors.orange,
                    );
                  }),
                ),

                SizedBox(height: 16),
                Text("📋 Critères de sélection", style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                if (formation.criteresSelection != null && formation.criteresSelection!.isNotEmpty)
                  ...formation.criteresSelection!.map((crit) => Text("• $crit")).toList()
                else
                  Text("Non spécifiés"),

                SizedBox(height: 24),
                Text("📝 Commentaire", style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text(formation.commentaire ?? "Aucun commentaire disponible."),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Expanded(flex: 2, child: Text(title, style: TextStyle(fontWeight: FontWeight.w600))),
          Expanded(flex: 3, child: Text(value)),
        ],
      ),
    );
  }
}
