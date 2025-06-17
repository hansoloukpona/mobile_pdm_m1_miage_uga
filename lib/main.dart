import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:selectivite/models/formations.dart';
import 'package:selectivite/screens/submit_evaluation_screen.dart';

import 'controllers/programsearchcontroller.dart';
import 'controllers/universitysearchcontroller.dart';
import 'screens/home_screen.dart';
import 'screens/results_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UniversitySearchController()),
        ChangeNotifierProvider(create: (_) => ProgramSearchController()),
      ],
      child: SelectiviteApp(),
    ),
  );
}

class SelectiviteApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sélectivité des formations',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        //primarySwatch: Colors.indigo,
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF4B7EBE)),
        //primarySwatch: customPrimarySwatch,
        primaryColor: Color(0xFF4B7EBE), // Redéfini ici
        fontFamily: 'Roboto',
        textTheme: TextTheme(
          headlineSmall: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(fontSize: 16.0),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
      routes: {
        '/results': (context) => Eval_Brut_Search_Screen(), // temporaire
        /** '/details': (context) => DetailsScreen(),*/
        //'/add_review_screen': (context) => SubmitEvaluationScreen(formation: formation),
        '/add_review_screen': (context) {
          final formationTest = Formations(
            nom: 'Computer Science',
            ville: 'Lyon',
            universite: 'University of Example',
            tauxAdmission: 30.5,
            nbCandidatures: 1200,
            noteMinimale: 14.0,
            selectiviteRessentie: 4,
            criteresSelection: ['Dossier', 'Lettre de motivation'],
            delaiReponse: 'Moyen',
            commentaire: 'Très bonne formation',
            avis: [], // ou null si tu veux
          );

          return SubmitEvaluationScreen(formation: formationTest);
        },
      },
    );
  }
}
