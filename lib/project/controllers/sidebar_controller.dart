import 'package:flutter/material.dart';
import '../widgets/editors/editor.dart';

class SidebarController extends ChangeNotifier {
  Editor? _selectedEditor;

  void setSelectedEditor(Editor editor) {
    _selectedEditor = editor;
    notifyListeners();
  }

  Editor? getSelectedEditor() {
    return _selectedEditor;
  }
}