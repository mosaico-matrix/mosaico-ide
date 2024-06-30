import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:highlight/languages/javascript.dart';
import 'package:mosaico_flutter_core/core/utils/toaster.dart';
import 'package:mosaico_flutter_core/features/config_generator/data/models/config_output.dart';
import 'package:mosaico_flutter_core/features/config_generator/presentation/pages/config_form_page.dart';
import 'package:mosaico_ide/features/project/data/models/project_file.dart';
import 'package:mosaico_ide/features/project/presentation/states/edited_file_state.dart';
import 'package:provider/provider.dart';
import '../../../states/project_state.dart';
import '../matrix_editor.dart';
import 'package:highlight/languages/json.dart';

class WidgetScriptEditor extends MatrixEditor {
  WidgetScriptEditor({super.key, required super.file})
      : super(
          icon: const Icon(Icons.code),
          title: 'Widget Script',
          language: javascript,
        );

  @override
  List<Widget> buildActions(BuildContext context) {
    var editedFileState = Provider.of<EditedFileState>(context);

    return [
      IconButton(
        icon: Icon(Icons.text_fields),
        tooltip: 'Create text',
        onPressed: () {
          addScriptComponent(editedFileState, 'global text = _createText();');
        },
      ),
      IconButton(
        icon: Icon(Icons.rectangle),
        tooltip: 'Create rectangle',
        onPressed: () {
          addScriptComponent(editedFileState, 'global rectangle = _createRectangle();');
        },
      ),
    ];
  }

  void addScriptComponent(EditedFileState editedFileState, String content) {
    // Add a new line if the last line of the file is not empty
    if (!editedFileState.isLastLineEmpty()) {
      content = "\n$content";
    }
    editedFileState.appendContent(content);
  }
}
