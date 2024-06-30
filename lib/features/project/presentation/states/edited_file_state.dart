import 'package:flutter/cupertino.dart';
import 'package:mosaico_ide/features/project/data/models/project_file.dart';

class ProjectFileState extends ChangeNotifier {
  final ProjectFile file;

  ProjectFileState(this.file);

  /// Add content to the file
  void appendContent(String content) {
    file.appendContent(content);
    notifyListeners();
  }

  /// Update the content of the file
  void setContent(String content) {
    file.setContent(content);
    notifyListeners();
  }

  /// Save the file to the disk
  Future<void> save() async {
    file.save();
    notifyListeners();
  }
}
