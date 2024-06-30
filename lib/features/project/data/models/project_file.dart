import 'dart:io';


class ProjectFile {

  ProjectFile(this._path)
  {
    // Load the content of the file
    _content = File(_path).readAsStringSync();
  }

  /*
   * File path
   */
  final String _path;
  String getPath() {
    return _path;
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

  /// Append content to the file
  void appendContent(String content) {
    _content += content;
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
  Future<void> save() async {
    await File(_path).writeAsString(_content);
    _isDirty = false;
  }


}