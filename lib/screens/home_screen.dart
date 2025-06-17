import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:selectivite/screens/program_selection_screen.dart';

import '../components/university_card_component.dart';
import '../components/university_search_bar_component.dart';
import '../controllers/universitysearchcontroller.dart';
import 'add2_review_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
            SearchBarEvalUni(
              searchController: Provider.of<UniversitySearchController>(
                context,
                listen: false,
              ),
            ),
            SizedBox(height: 20),
            Text("Résultats", style: Theme.of(context).textTheme.headlineSmall),
            SizedBox(height: 10),
            Expanded(
              child: Consumer<UniversitySearchController>(
                builder: (context, controller, _) {
                  if (controller.isLoading) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (controller.universities.isEmpty) {
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
                              Navigator.pushNamed(context, '/add_review_screen');
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
                    itemCount: controller.universities.length,
                    itemBuilder: (context, index) {
                      final university = controller.universities[index];
                      return UniversityCard(university: university);
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

  void handleAddEvaluation(BuildContext context, {String? programId}) {
    if (programId != null) {
      // Aller directement au formulaire avec l’id
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => AddReviewScreen(programId: programId),
        ),
      );
    } else {
      // Sinon : sélectionner une filière d’abord
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ProgramSelectionScreen(
            onProgramSelected: (selectedProgramId) {
              Navigator.pop(context); // Fermer la page de sélection
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AddReviewScreen(programId: selectedProgramId),
                ),
              );
            },
          ),
        ),
      );
    }
  }

}
