import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:selectivite/components/program_search_bar_component.dart';
import 'package:selectivite/models/university_model.dart';

import '../components/program_card_component.dart';
import '../controllers/programsearchcontroller.dart';

class UniversityDetails extends StatefulWidget {
  final University university;

  const UniversityDetails({super.key, required this.university});

  @override
  State<UniversityDetails> createState() => _UniversityDetailsState();
}

class _UniversityDetailsState extends State<UniversityDetails> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF4B7EBE),
      appBar: AppBar(
        title: Text("Rechercher une université"),
        backgroundColor: Color(0xFF4B7EBE),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchBarEvalProgram(
              searchController: Provider.of<ProgramSearchController>(
                context,
                listen: false,
              ),
              universityId: widget.university.id as String,
            ),
            SizedBox(height: 20),
            Text("Résultats", style: Theme.of(context).textTheme.headlineSmall),
            SizedBox(height: 10),

            _buildLine("Nom", widget.university.name),
            _buildLine("Pays", widget.university.country),
            _buildLine("Ville", widget.university.city),
            _buildLine("Type", widget.university.type),
            if (widget.university.website != null && widget.university.website!.isNotEmpty)
              _buildLine("Site web", widget.university.website!),

            Expanded(
              child: Consumer<ProgramSearchController>(
                builder: (context, controller, _) {
                  if (controller.isLoading) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (controller.programs.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Aucun résultat trouvé.",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Souhaitez-vous créer une nouvelle évaluation ?",
                          ),
                          SizedBox(height: 20),
                          ElevatedButton.icon(
                            onPressed: () {
                              Navigator.pushNamed(context, '/add-review');
                            },
                            icon: Icon(Icons.add),
                            label: Text("Créer une évaluation"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).primaryColorDark,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: controller.programs.length,
                    itemBuilder: (context, index) {
                      final program = controller.programs[index];
                      return ProgramCard(program: program);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLine(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(fontSize: 16, color: Colors.black87),
          children: [
            TextSpan(text: "$label : ", style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: value),
          ],
        ),
      ),
    );
  }
}
