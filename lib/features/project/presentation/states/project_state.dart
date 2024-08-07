import 'dart:convert';
import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:flutter/material.dart';
import 'package:mosaico_ide/features/project/data/models/project_file.dart';
import 'package:mosaico_ide/features/project/presentation/widgets/editor/editors/widget_script_editor.dart';
import 'package:path_provider/path_provider.dart';
import '../widgets/editor/editors/config_form_editor.dart';
import '../widgets/editor/editors/metadata_editor.dart';
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
    WidgetScriptEditor(file: ProjectFile('$_projectPath/widget.py')),
    ConfigFormEditor(file: ProjectFile('$_projectPath/config-form.json')),
    MetadataEditor(file: ProjectFile('$_projectPath/mosaico.json')),
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

  /*
   * Project actions
   */

  /// Save all changes in the project
  Future saveAll() async
  {
    for (var editor in _editors) {
      await editor.saveChanges();
    }
  }


  /// Creates a .tar.gz package of the project and returns the path to the archive
  Future<String> buildProjectPackage() async {


    // Create temp path
    Directory tempDir = await getTemporaryDirectory();

    // Define the source directory and the output file
    final sourceDir = Directory(_projectPath);
    final outputFile = File('$tempDir/widget.tar.gz');

    // Create an archive
    final encoder = TarFileEncoder();
    encoder.open('$tempDir/config.tar');

    // Add all files in the project directory to the archive
    var files = sourceDir.listSync(recursive: false);
    for (var file in files) {
      if (file is File) {
        final filename = file.path.substring(_projectPath.length + 1);
        await encoder.addFile(file, filename);
      }
    }

    // Add the assets folder if it exists
    final assetsDir = Directory('$_projectPath/assets');
    if (assetsDir.existsSync()) {
      await encoder.addDirectory(assetsDir, includeDirName: true);
    }

    // Close the archive to finalize the tar file
    await encoder.close();

    // Read the tar file
    final tarFile = File('$tempDir/config.tar');
    final tarBytes = await tarFile.readAsBytes();

    // Compress the tar file using gzip
    final gzBytes = GZipEncoder().encode(tarBytes);

    // Write the compressed file to disk
    await outputFile.writeAsBytes(gzBytes!);

    // Optionally delete the intermediate tar file
    await tarFile.delete();

    return outputFile.path;

  }

}