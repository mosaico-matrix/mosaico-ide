import 'package:flutter/material.dart';
import 'package:mosaico_config_generator/form/config_output.dart';
import 'package:mosaico_ide/project/state/project_state.dart';
import 'package:mosaico_ide/toaster.dart';
import 'package:provider/provider.dart';
import 'editor.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:highlight/languages/json.dart';
import 'package:flutter_highlight/themes/monokai-sublime.dart';
import 'package:mosaico_config_generator/form/pages/config_generator.dart';

class ConfigFormEditor extends Editor {
  final codeController = CodeController(
    language: json,
  );

  ConfigFormEditor({super.key})
      : super(
          icon: Icon(Icons.edit_document),
          title: 'Configuration Form',
        );

  @override
  Widget buildEditor(BuildContext context) {
    // Set the code controller text to the project's configuration form
    codeController.text = Provider.of<ProjectState>(context, listen: false)
        .getConfigFormFileContent();

    return CodeTheme(
      data: CodeThemeData(styles: monokaiSublimeTheme),
      child: SingleChildScrollView(
        child: CodeField(
          controller: codeController,
          onChanged: (value) {
            Provider.of<ProjectState>(context, listen: false)
                .updateConfigForm(value);
          },
        ),
      ),
    );
  }

  @override
  List<Widget> buildActions(
      BuildContext context, ProjectState projectController) {
    return [
      IconButton(
        icon: Icon(Icons.construction),
        tooltip: 'Build',
        onPressed: () async {
          // Save file if not already saved
          if (projectController.isDirty()) {
            projectController.saveProject();
            Toaster.success('Saved!');
          }

          // Navigate to config generator
          ConfigOutput? output = await Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => ConfigGenerator(
                    projectController.getConfigFormFileContent())),
          );

          if (output == null) {
            Toaster.error('Aborted!');
          } else {
            Toaster.success('Built!');
          }
        },
      ),
    ];
  }
}
