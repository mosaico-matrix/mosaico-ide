import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:highlight/languages/javascript.dart';
import 'package:highlight/languages/python.dart';
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
          language: python,
        );

  @override
  List<Widget> buildActions(BuildContext context) {
    var editedFileState = Provider.of<EditedFileState>(context);

    return [
      IconButton(
        icon: const Icon(Icons.text_fields),
        tooltip: 'Create text',
        onPressed: () {
          addScriptComponent(editedFileState, 'text = widget.createText()');
        },
      ),
      IconButton(
        icon: const Icon(Icons.rectangle),
        tooltip: 'Create rectangle',
        onPressed: () {
          addScriptComponent(editedFileState, 'rectangle = widget.createRectangle()');
        },
      ),
    ];
  }

  void addScriptComponent(EditedFileState editedFileState, String content) {
    // Add a new line if the last line of the file is not empty
    if (!editedFileState.isLastLineEmpty()) {
      content = "\n$content";
    }
    codeController.insertStr(content);
  }
}
