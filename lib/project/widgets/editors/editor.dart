import 'package:flutter/material.dart';
import 'package:mosaico_ide/project/state/project_state.dart';
import 'package:provider/provider.dart';

abstract class Editor extends StatelessWidget {
  final Icon icon;
  final String title;

  const Editor({
    required this.icon,
    required this.title,
    Key? key,
  }) : super(key: key);

  // Subclasses need to implement this methods
  Widget buildEditor(BuildContext context);
  List<Widget> buildActions(BuildContext context, ProjectState projectController);

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Row(children: buildActions(context, Provider.of<ProjectState>(context, listen: false))),
          buildEditor(context)
        ]
    );
  }
}
