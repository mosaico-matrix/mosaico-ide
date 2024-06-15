import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

class ProjectState extends ChangeNotifier {

  // Project data
  final String _projectPath;
  late String _projectName = '';

  // In memory project data
  String _configForm = '';

  // State variables
  bool _isDirty = false;

  /// Parse metadata file to set project data
  void _parseMetadata() async {

    // Open metadata file as json
    File file = File('$_projectPath/mosaico.json');
    String content = await file.readAsString();
    var metadata = jsonDecode(content);

    // Set project data
    _projectName = metadata['name'];
  }

  /// Set project as dirty or not
  void _setDirty({bool dirty = true}) {
    _isDirty = dirty;
    notifyListeners();
  }

  ProjectState(this._projectPath)
  {
    _parseMetadata();
  }

  /// Save project to disk by writing in memory data to files
  void saveProject() async {

    // Save config form to file
    File file = File('$_projectPath/config-form.json');
    await file.writeAsString(_configForm);

    _setDirty(dirty: false);
  }

  /// Get config form content from disk
  String getConfigFormFileContent() {

    // Read config form file
    File file = File('$_projectPath/config-form.json');
    return file.readAsStringSync();
  }

  /// Update config form content in memory
  void updateConfigForm(String content) {
    // Save content to memory
    _configForm = content;
    _setDirty();
  }

  /// Check if project is dirty
  /// A project is dirty if in memory data is different from disk data
  bool isDirty() {
    return _isDirty;
  }

  /// Returns the directory where the project is stored
  String getProjectPath()
  {
    return _projectPath;
  }

  /// Returns the name of the project, parsed from metadata file mosaico.json
  String getProjectName()
  {
    return _projectName;
  }
}
