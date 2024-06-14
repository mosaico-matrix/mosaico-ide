import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

class ProjectController extends ChangeNotifier {

  final String _projectPath;
  late final String _projectName;

  void _parseMetadata() async {

    // Open metadata file as json
    File file = File('$_projectPath/mosaico.json');
    String content = await file.readAsString();
    var metadata = jsonDecode(content);

    // Set project data
    _projectName = metadata['name'];
  }

  ProjectController(this._projectPath)
  {
    _parseMetadata();
  }


  String getProjectPath()
  {
    return _projectPath;
  }

  String getProjectName()
  {
    return _projectName;
  }


  /// Construct a new project manager by creating required files
  static Future<ProjectController> createNewProject(String directoryPath, String projectName) async {

    // Create config form
    File file = File('$directoryPath/config-form.json');
    await file.writeAsString('{}');

    // Create metadata file from map to json
    var metadata = {
      'name': projectName,
      'description': '',
    };
    file = File('$directoryPath/mosaico.json');
    await file.writeAsString(jsonEncode(metadata));

    // Create runner chai

    // Return new project manager
    return ProjectController(directoryPath);
  }

  /// Construct a new project manager by opening existing files
  static Future<ProjectController> openProject(String directoryPath) async {
    return ProjectController(directoryPath);
  }
}
