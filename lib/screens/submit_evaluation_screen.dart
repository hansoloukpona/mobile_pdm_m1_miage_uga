import 'package:flutter/material.dart';
import 'package:selectivite/dtos/program_to_display_model.dart';

import '../controllers/addadvisecontroller.dart';

class SubmitEvaluationScreen extends StatefulWidget {
  final ProgramToDisplay programwithdetails;

  final AddAdviseController addAdviseController;

  const SubmitEvaluationScreen({super.key, required this.programwithdetails, required this.addAdviseController});

  @override
  State<SubmitEvaluationScreen> createState() => _SubmitEvaluationScreenState();
}

class _SubmitEvaluationScreenState extends State<SubmitEvaluationScreen> {

  final Map<String, int> ratings = {
    'Selectivity': 0,
    'Quality of Education': 0,
    'Academic Rigor': 0,
    'Supervision': 0,
    'Satisfaction': 0,
  };

  bool hasDroppedOut = false;

  void _setRating(String category, int rating) {
    setState(() {
      ratings[category] = rating;
    });
  }

  void _submit() {
    widget.addAdviseController.ratings.addAll(ratings);
    widget.addAdviseController.hasDroppedOut = hasDroppedOut;
    widget.addAdviseController.addEvaluation(widget.programwithdetails.id);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Évaluation envoyée pour ${widget.programwithdetails.name}")),
    );

    Navigator.pop(context);
  }

  Widget _buildStarRating(String category) {
    final rating = ratings[category]!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(category, style: TextStyle(fontWeight: FontWeight.bold)),
        Row(
          children: List.generate(5, (index) {
            return IconButton(
              icon: Icon(
                index < rating ? Icons.star : Icons.star_border,
                color: Colors.amber,
              ),
              onPressed: () => _setRating(category, index + 1),
            );
          }),
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[100],
      appBar: AppBar(
        title: const Text("Ajouter une évaluation"),
        backgroundColor: Colors.lightBlue[200],
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: ListView(
          children: [
            Text(widget.programwithdetails.name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text(widget.programwithdetails.uniName ?? "", style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),

            ...['Selectivity', 'Quality of Education', 'Academic Rigor']
                .map(_buildStarRating)
                .toList(),

            Text("Année d'étude", style: TextStyle(fontWeight: FontWeight.bold)),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () => setState(() {
                    if (widget.addAdviseController.studyYear > 2000) widget.addAdviseController.studyYear--;
                  }),
                ),
                Expanded(
                  child: Text("${widget.addAdviseController.studyYear}", textAlign: TextAlign.center, style: TextStyle(fontSize: 18)),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () => setState(() => widget.addAdviseController.studyYear++),
                ),
              ],
            ),
            const SizedBox(height: 16),

            _buildStarRating('Supervision'),
            _buildStarRating('Satisfaction'),

            Row(
              children: [
                Checkbox(
                  value: hasDroppedOut,
                  onChanged: (val) => setState(() => hasDroppedOut = val ?? false),
                ),
                const Text("Has dropped out"),
              ],
            ),
            const SizedBox(height: 16),

            const Text("Other Comments", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextField(
              controller: widget.addAdviseController.commentController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: "Enter your comments",
                border: OutlineInputBorder(),
                fillColor: Colors.grey[100],
                filled: true,
              ),
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: _submit,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[800],
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text("SUBMIT", style: TextStyle(fontSize: 16)),
            )
          ],
        ),
      ),
    );
  }
}


/*import 'package:flutter/material.dart';
import 'package:selectivite/dtos/program_to_display_model.dart';

import '../controllers/addadvisecontroller.dart';

class SubmitEvaluationScreen extends StatefulWidget {
  final ProgramToDisplay programwithdetails;

  final AddAdviseController addAdviseController;

  const SubmitEvaluationScreen({super.key, required this.programwithdetails, required this.addAdviseController});

  @override
  State<SubmitEvaluationScreen> createState() => _SubmitEvaluationScreenState();
}

class _SubmitEvaluationScreenState extends State<SubmitEvaluationScreen> {

  Map<String, int> ratings = {
    'Sélectivité': 0,
    'Qualité': 0,
    'Rigueur': 0,
    'Encadrement': 0,
    'Satisfaction': 0,
  };

  Widget _buildStarRating(String category) {

    var rating;
    if (ratings.containsKey(category) && ratings[category] != null) {
      rating = ratings[category];
    } else {
      rating = 0; // TODO Il faudrait ? changer cette manère de selectionner pour quelque chose de plus contraignant
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(category, style: TextStyle(fontWeight: FontWeight.bold)),
        Row(
          children: List.generate(5, (index) {
            return IconButton(
              icon: Icon(
                index < rating ? Icons.star : Icons.star_border,
                color: Colors.amber,
              ),
              onPressed: () => {ratings[category] = index + 1},
            );
          }),
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[100],
      appBar: AppBar(
        title: const Text("Ajouter une évaluation"),
        backgroundColor: Colors.lightBlue[200],
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: ListView(
          children: [
            Text(widget.programwithdetails.name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text(widget.programwithdetails.uniName ?? "", style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),

            ...['Sélectivité', 'Qualité', 'Rigueur']
                .map(_buildStarRating)
                .toList(),

            /*const SizedBox(height: 8),
            Text("📘 Study Year", style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(
              controller: widget.addAdviseController.studyYearController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Ex : 2025",
                border: OutlineInputBorder(),
              ),
            ),*/
            const SizedBox(height: 16),

            Text("Année d'étude", style: TextStyle(fontWeight: FontWeight.bold)),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () => setState(() {
                    if (widget.addAdviseController.studyYear > 2000) widget.addAdviseController.studyYear--;
                  }),
                ),
                Expanded(
                  child: Text("${widget.addAdviseController.studyYear}", textAlign: TextAlign.center, style: TextStyle(fontSize: 18)),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () => setState(() => widget.addAdviseController.studyYear++),
                ),
              ],
            ),
            const SizedBox(height: 16),

            _buildStarRating('Encadrement'),
            _buildStarRating('Satisfaction'),

            Row(
              children: [
                Checkbox(
                  value: widget.addAdviseController.hasDroppedOut,
                  onChanged: (val) => setState(() => widget.addAdviseController.hasDroppedOut = val ?? false),
                ),
                const Text("Avez vous abandonné ?"),
              ],
            ),
            const SizedBox(height: 16),

            const Text("Commentaire", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextField(
              controller: widget.addAdviseController.commentController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: "Entrez votre commentaire",
                border: OutlineInputBorder(),
                fillColor: Colors.grey[100],
                filled: true,
              ),
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                widget.addAdviseController.addEvaluation(widget.programwithdetails.id);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Évaluation envoyée pour ${widget.programwithdetails.name}")),
                );
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[800],
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text("Envoyer", style: TextStyle(fontSize: 16)),
            )
          ],
        ),
      ),
    );
  }
}
*/