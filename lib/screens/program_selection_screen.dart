import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:selectivite/dtos/program_to_display_model.dart';

import '../components/program_brut_search_bar_component.dart';
import '../controllers/programsearchcontroller.dart';
import 'details_screen.dart';

class ProgramSelectionScreen extends StatelessWidget {

  final Function(ProgramToDisplay) onProgramSelected;

  const ProgramSelectionScreen({Key? key, required this.onProgramSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF4B7EBE),
      appBar: AppBar(
        title: Text("Rechercher une filière"),
        backgroundColor: Color(0xFF4B7EBE),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BrutSearchBarEvalProgram(
              searchController: Provider.of<ProgramSearchController>(
                context,
                listen: false,
              ),
            ),
            SizedBox(height: 20),
            Text("Résultats", style: Theme.of(context).textTheme.headlineSmall),
            SizedBox(height: 10),
            Expanded(
              child: Consumer<ProgramSearchController>(
                builder: (context, controller, _) {
                  if (controller.isLoading) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (controller.brutSearchResultOfProgram.isEmpty) {
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
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: controller.brutSearchResultOfProgram.length,
                    itemBuilder: (context, index) {
                      final program = controller.brutSearchResultOfProgram[index];
                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 10.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        elevation: 3,
                        clipBehavior: Clip.antiAlias,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Colors.white,
                                Colors.white,
                                Color(0x1A004AAD), // Bleu très léger (~10% opacité)
                                Color(0x1A004AAD),
                              ],
                              stops: [0.0, 0.75, 0.85, 1.0], // Dégradé à partir de 75%
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                            child: Row(
                              children: [
                                // Partie cliquable (texte université)
                                Expanded(
                                  child: InkWell(
                                    onTap: () => onProgramSelected(program),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          program.name,
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 8.0),
                                        Text(
                                          "Voir les détails de cette université",
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.grey[700],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(width: 16.0),
                              ],
                            ),
                          ),
                        ),
                      );
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
}





/**onTap: () {
Navigator.push(
context,
MaterialPageRoute(
builder: (context) => DetailsScreen(formation: formation),
),
);
}*/