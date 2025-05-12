import 'package:flutter/material.dart';
import 'package:selectivite/screens/add_review_screen.dart';
import 'screens/home_screen.dart';
import 'screens/results_screen.dart';
import 'screens/details_screen.dart';

void main() {
  runApp(SelectiviteApp());
}

class SelectiviteApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sélectivité des formations',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
      routes: {
        '/results': (context) => ResultsScreen(formations: []), // temporaire
        /** '/details': (context) => DetailsScreen(),*/
        '/add-review': (context) => AddReviewScreen(formations: [],),
      },
    );
  }
}
