
import 'package:flutter/material.dart';

import '../models/program_model.dart';

class ProgramCard extends StatefulWidget {

  final Program program;

  const ProgramCard({super.key, required this.program});

  @override
  State<ProgramCard> createState() => _ProgramCardState();

}

class _ProgramCardState extends State<ProgramCard> {

  bool _expanded = false;

  void _toggleExpanded() {
    setState(() {
      _expanded = !_expanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleExpanded,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 3,
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 0),
        child: AnimatedCrossFade(
          duration: Duration(milliseconds: 300),
          crossFadeState:
          _expanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          firstChild: _buildCollapsed(),
          secondChild: _buildExpanded(),
        ),
      ),
    );
  }

  Widget _buildCollapsed() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          Icon(Icons.school, color: Colors.blue),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              widget.program.name,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildExpanded() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.program.name,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 8),
          Text(widget.program.field, style: TextStyle(fontSize: 16)),
          SizedBox(height: 8),
          Text("Autres infos : ...", style: TextStyle(fontSize: 14, color: Colors.grey)),
        ],
      ),
    );
  }
}