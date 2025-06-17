import 'package:flutter/material.dart';

import '../dtos/program_to_display_model.dart';

class DetailsScreen extends StatelessWidget {
  final ProgramToDisplay programwithuni;
  /** const DetailsScreen({super.key, required Formations formation, required formations}); */
  const DetailsScreen({super.key,  required this.programwithuni});
  @override
  Widget build(BuildContext context) {
    /** final formation = ModalRoute.of(context)!.settings.arguments as Formations;*/

    return Scaffold(
      appBar: AppBar(
        title: Text(programwithuni.name),
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
                  programwithuni.name,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  programwithuni.city,
                  style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                ),
                Divider(height: 32),

                _buildRow("Qualité", "${programwithuni.qualityScore ?? 'N/A'} %"),
                //_buildRow("🎯 Sélectivité", "${programwithuni.selectivityScore ?? 'N/A'} %"),
                _buildRow("Encadrement", "${programwithuni.supervisionScore ?? 'N/A'}"),
                _buildRow("Rigeur", "${programwithuni.rigorScore ?? 'N/A'}"),
                _buildRow("Satisfaction" /*de qui?*/, "${programwithuni.satisfactionScore ?? 'N/A'}"),

                /*_buildRow("🎯 Taux d'admission", "${programwithuni.tauxAdmission ?? 'N/A'} %"),
                _buildRow("📥 Nb. de candidatures", "${programwithuni.nbCandidatures ?? 'N/A'}"),
                _buildRow("📊 Note minimale", "${programwithuni.noteMinimale ?? 'N/A'}"), //TODO écrire une fonction qui permet d'obenir une valeur en français de la note minimale quelle que soit le système de notation
                _buildRow("⏱ Temps de réponse", programwithuni.delaiReponse ?? "Inconnu"),*/

                SizedBox(height: 16),
                Text("⭐ Sélectivité ressentie", style: TextStyle(fontWeight: FontWeight.bold)),
                Row(
                  children: List.generate(5, (i) {
                    return Icon(
                      i < (programwithuni.selectivityScore ?? 0) ? Icons.star : Icons.star_border,
                      color: Colors.orange,
                    );
                  }),
                ),

                /*SizedBox(height: 16),
                Text("📋 Critères de sélection", style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),*/
                /*if (programwithuni.criteresSelection != null && programwithuni.criteresSelection!.isNotEmpty)
                  ...programwithuni.criteresSelection!.map((crit) => Text("• $crit")).toList()
                else
                  Text("Non spécifiés"),*/ //Remplacer ceci par les tags ue fois qu'ils seront intégrés

                SizedBox(height: 24),
                Text("Commentaire", style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),

                if (programwithuni.comment != null && programwithuni.comment!.isNotEmpty)
                  ...programwithuni.comment!.map((crit) => Text("• $crit")).toList() //TODO une meilleure séparation ?
                else
                  Text("Non spécifiés"),
                //Text(programwithuni.comment ?? "Aucun commentaire disponible."),
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
