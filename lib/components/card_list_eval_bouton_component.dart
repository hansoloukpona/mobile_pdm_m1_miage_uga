// widgets/university_search_bar_component.dart

import 'package:flutter/material.dart';

class Cardlistevalbouton extends StatelessWidget {

  final Text value;
  const Cardlistevalbouton({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
   return ElevatedButton(
     onPressed: () {
       Navigator.pushNamed(context, '/add_review_screen');
     },
     style: ElevatedButton.styleFrom(
       backgroundColor: Color(0xFF004AAD),
       foregroundColor: Colors.white, // couleur du texte et des icônes
       minimumSize: Size(90, 36),
       padding: EdgeInsets.symmetric(horizontal: 12),
     ),
     child: this.value,
   );
  }
}