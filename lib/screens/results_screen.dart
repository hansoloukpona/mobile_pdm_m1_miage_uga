import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:selectivite/components/program_search_bar_component.dart';

import '../controllers/programsearchcontroller.dart';
import 'details_screen.dart';

class Eval_Brut_Search_Screen extends StatelessWidget {

  const Eval_Brut_Search_Screen({Key? key}) : super(key: key);

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

                  if (controller.allProgramsOfAUni.isEmpty) {
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
                    itemCount: controller.brutSearchResultOfProgram.length,
                    itemBuilder: (context, index) {
                      final programwithuni = controller.brutSearchResultOfProgram[index];
                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        elevation: 2,
                        child: ListTile(
                          title: Text(
                            programwithuni.name,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(programwithuni.uniName),
                          trailing: const Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailsScreen(programwithuni: programwithuni),
                              ),
                            );
                          },
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