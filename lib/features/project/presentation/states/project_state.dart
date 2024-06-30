import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mosaico_ide/features/project/data/models/project_file.dart';
import 'package:mosaico_ide/features/project/presentation/widgets/editor/editors/widget_script_editor.dart';
import '../widgets/editor/editors/config_form_editor.dart';
import '../widgets/editor/matrix_editor.dart';

class ProjectState extends ChangeNotifier {


  /// The path to the project directory
  final String _projectPath;

  /// The name of the project
  late String _projectName;
  String getName() {
    return _projectName;
  }

  ProjectState(this._projectPath)
  {
    // Parse metadata before opening the project
    File metadataFile = File('$_projectPath/mosaico.json');
    String content = metadataFile.readAsStringSync();
    var metadata = jsonDecode(content);

    // Set project data
    _projectName = metadata['name'];
  }

  /*
   * Editors
   */
  MatrixEditor? _selectedEditor;
  late final List<MatrixEditor> _editors = [
    WidgetScriptEditor(file: ProjectFile('$_projectPath/widget.chai')),
    ConfigFormEditor(file: ProjectFile('$_projectPath/config-form.json')),
  ];

  /// Set the selected editor
  void setSelectedEditor(MatrixEditor editor) {
    _selectedEditor = editor;
    notifyListeners();
  }

  /// Get the selected editor
  MatrixEditor getSelectedEditor() {
    return _selectedEditor ?? _editors[0];
  }

  /// Get the list of editors
  List<MatrixEditor> getEditors() {
    return _editors;
  }

}