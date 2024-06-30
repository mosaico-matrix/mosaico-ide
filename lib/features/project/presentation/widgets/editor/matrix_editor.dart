import 'package:flutter/material.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:flutter_highlight/themes/monokai-sublime.dart';
import 'package:highlight/highlight.dart';
import 'package:provider/provider.dart';
import '../../../data/models/project_file.dart';
import '../../states/project_state.dart';

abstract class MatrixEditor extends StatelessWidget {

  /// Icon and title for the sidebar
  final Icon icon;
  final String title;

  /// The file we are editing
  final ProjectFile file;

  /// Editor component configuration
  final Mode _language;
  late CodeController _codeController;

  MatrixEditor({
    required this.icon,
    required this.title,
    required Mode language,
    required this.file,
    super.key,
  }) : _language = language {
    _codeController = CodeController(language: _language);
  }

  /// Actions displayed on the top of the editor, override this method to add more actions
  List<Widget> buildActions(
      BuildContext context, ProjectState projectController);


  /// Save the changes made to the file
  void saveChanges() {
    file.save();
  }

  @override
  Widget build(BuildContext context) {

    // Get the project state
    var projectState = Provider.of<ProjectState>(context, listen: false);

    // Set the current file content for the editor
    _codeController.text = file.getContent();

    return Column(children: [

      // Actions
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
          children: buildActions(context, projectState)
      ),

      // Actual editor
      Flexible(
        child: SingleChildScrollView(
          child: CodeTheme(
              data: CodeThemeData(styles: monokaiSublimeTheme),
              child: SingleChildScrollView(
                  child: CodeField(
                controller: _codeController,
                onChanged: (value) {
                  file.setContent(value);
                },
              ))),
        ),
      )
    ]);
  }
}
