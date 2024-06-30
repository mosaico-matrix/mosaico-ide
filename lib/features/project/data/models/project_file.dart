import 'dart:io';


class ProjectFile {

  /// The path where the file is located
  final String _path;
  ProjectFile(this._path)
  {
    // Load the content of the file
    _content = File(_path).readAsStringSync();
  }

  /*
  * File content
  */
  String _content = '';

  /// Update the content of the file
  void setContent(String content) {
    _content = content;
    _isDirty = true;
  }

  /// Get the content of the file
  String getContent() {
    return _content;
  }

  /*
   * File status
   */
  bool _isDirty = false;
  bool isDirty() {
    return _isDirty;
  }

  /// Save the file to the disk
  void save() async {
    await File(_path).writeAsString(_content);
    _isDirty = false;
  }


}