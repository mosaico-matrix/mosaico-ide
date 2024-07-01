import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../states/project_state.dart';
import '../../editor/matrix_editor.dart';

class SidebarEditors extends StatelessWidget {

  const SidebarEditors({super.key});

  @override
  Widget build(BuildContext context) {

    var projectState = Provider.of<ProjectState>(context);
    var editors = projectState.getEditors();

    return Expanded(
      child: ListView.builder(
        itemCount: editors.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(editors[index].title),
            leading: editors[index].icon,
            onTap: () => _onEditorSelected(projectState, editors[index], context),
          );
        },
      ),
    );
  }

  void _onEditorSelected(ProjectState projectState, MatrixEditor editor, BuildContext context) {
    projectState.setSelectedEditor(editor);
    Navigator.of(context).pop();
  }
}
