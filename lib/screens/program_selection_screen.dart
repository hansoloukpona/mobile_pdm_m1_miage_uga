import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:selectivite/components/program_search_bar_component.dart';

import '../controllers/programsearchcontroller.dart';
import '../models/formations.dart';
import 'details_screen.dart';

class ProgramSelectionScreen extends StatelessWidget {

  final Function(String) onProgramSelected;

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
                      return ListTile(
                        title: Text(program.name),
                        onTap: () => onProgramSelected(program.id),
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