import 'package:flutter/material.dart';
import 'package:selectivite/controllers/addadvisecontroller.dart';
import 'package:selectivite/controllers/programsearchcontroller.dart';

import '../dtos/program_to_display_model.dart';

class DetailsScreen extends StatefulWidget {

  final ProgramToDisplay programwithuni;

  const DetailsScreen({super.key, required this.programwithuni});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {

  /*late ProgramSearchController programSearchController;


  @override
  void initState() {
    super.initState();
    programSearchController.isLoading = true;
    fetchFullProgramInfo(widget.programwithuni.id);
  }

  Future<void> fetchFullProgramInfo(String programId) async {
    setState(() {
      widget.programwithuni = programSearchController.getProgramByIdFromJson(programId) as ProgramToDisplay;
      //widget.programwithuni = programSearchController.getProgramById(widget.programwithuni.id) as ProgramToDisplay;
      programSearchController.isLoading = false;
    });
  }*/

  @override
  Widget build(BuildContext context) {
    /** final formation = ModalRoute.of(context)!.settings.arguments as Formations;*/

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.programwithuni.name),
      ),
      body: /*programSearchController.isLoading ? Center(child: CircularProgressIndicator()) : */SingleChildScrollView(
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
                  widget.programwithuni.name,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  widget.programwithuni.city,
                  style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                ),
                Divider(height: 32),

                _buildRow("Qualité", "${widget.programwithuni.qualityScore ?? 'N/A'} %"),
                //_buildRow("Sélectivité", "${programwithuni.selectivityScore ?? 'N/A'} %"),
                _buildRow("Encadrement", "${widget.programwithuni.supervisionScore ?? 'N/A'}"),
                _buildRow("Rigeur", "${widget.programwithuni.rigorScore ?? 'N/A'}"),
                _buildRow("Satisfaction" /*de qui?*/, "${widget.programwithuni.satisfactionScore ?? 'N/A'}"),

                /*_buildRow("🎯 Taux d'admission", "${programwithuni.tauxAdmission ?? 'N/A'} %"),
                _buildRow("📥 Nb. de candidatures", "${programwithuni.nbCandidatures ?? 'N/A'}"),
                _buildRow("📊 Note minimale", "${programwithuni.noteMinimale ?? 'N/A'}"), //TODO écrire une fonction qui permet d'obenir une valeur en français de la note minimale quelle que soit le système de notation
                _buildRow("⏱ Temps de réponse", programwithuni.delaiReponse ?? "Inconnu"),*/

                SizedBox(height: 16),
                Text("Sélectivité ressentie", style: TextStyle(fontWeight: FontWeight.bold)),
                Row(
                  children: List.generate(5, (i) {
                    return Icon(
                      i < (widget.programwithuni.selectivityScore ?? 0) ? Icons.star : Icons.star_border,
                      color: Colors.orange,
                    );
                  }),
                ),

                SizedBox(height: 24),
                Text("Commentaire", style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),

                if (widget.programwithuni.comment.isNotEmpty)
                  ...widget.programwithuni.comment.map((crit) => Text("• $crit")) //TODO une meilleure séparation ?
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
