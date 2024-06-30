import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

/// This class is a ChangeNotifier that holds the state of the project
/// It is used to manage the project files and save data to disk, check if project is dirty, etc.
class ProjectState extends ChangeNotifier {

  /// Creates a new ProjectState with
  /// [projectPath]: the path to the project directory where the project files are stored
  final String _projectPath;
  ProjectState(this._projectPath)
  {
    _parseMetadata();
  }

  /*
  * Project metadata
  */
  late String _projectName = '';

  /// Parse metadata file mosaico.json
  void _parseMetadata() async {

    // Open metadata file as json
    File file = File('$_projectPath/mosaico.json');
    String content = await file.readAsString();
    var metadata = jsonDecode(content);

    // Set project data
    _projectName = metadata['name'];
  }

  /// Returns the name of the project, parsed from metadata file mosaico.json
  String getProjectName()
  {
    return _projectName;
  }


  /*
  * Dirty flag
  * A project is dirty if in memory data is different from disk data
  */
  bool _isDirty = false;

  /// Set project as dirty
  void _setDirty({bool dirty = true}) {
    _isDirty = dirty;
    notifyListeners();
  }

  /// Check if project is dirty
  bool isDirty() {
    return _isDirty;
  }


  /*
  * Config form
  */
  String _configForm = '';

  /// Update config form content in memory
  void updateConfigForm(String content) {
    // Save content to memory
    _configForm = content;
    _setDirty();
  }

  /// Get config form content from disk
  String getConfigFormFileContent() {

    // Read config form file
    File file = File('$_projectPath/config-form.json');
    return file.readAsStringSync();
  }

  /*
  * Widget script
  */
  String _widgetScript = '';

  /// Update widget script content in memory
  /// [content]: the new content of the widget script
  void updateWidgetScript(String content) {
    // Save content to memory
    _widgetScript = content;
    _setDirty();
  }

  /// Get widget script content from disk
  /// Returns the content of the widget script file
  String getWidgetScriptFileContent() {

    // Read widget script file
    File file = File('$_projectPath/widget.chai');
    return file.readAsStringSync();
  }


  /*
  * Other
  */
  /// Returns the directory where the project is stored
  String getProjectPath()
  {
    return _projectPath;
  }

  /// Save project to disk by writing in memory data to files
  void saveProject() async {

    // Save config form to file
    File file = File('$_projectPath/config-form.json');
    await file.writeAsString(_configForm);

    _setDirty(dirty: false);
  }

}
