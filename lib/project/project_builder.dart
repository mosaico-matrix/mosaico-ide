import 'dart:convert';
import 'dart:io';

class ProjectBuilder
{

  /// File used as a template for the user's configurations for every widget
  static void _createConfigForm(String directoryPath) async {
    var file = File('$directoryPath/config-form.json');
    await file.writeAsString('{}');
  }

  static void _createWidgetMetadata(String directoryPath, String projectName) async {
    // Create metadata file from map to json
    var metadata = {
      'name': projectName,
      'description': '',
    };
    var file = File('$directoryPath/mosaico.json');
    await file.writeAsString(jsonEncode(metadata));
  }

  /// Main script used to program the widget
  static void _createWidgetScript(String directoryPath) async {
    var file = File('$directoryPath/widget.dart');
    await file.writeAsString(
        '''
          global standardText = _DrawableText();
          standardText.setText("Hey there!");
          def loop()
          {
            standardText.setColor(RANDOM_COLOR());
          }
        '''
    );
  }

  /// Create all required files for a new project
  static Future createNewProject(String directoryPath, String projectName) async {

    // Create necessary files
    _createWidgetScript(directoryPath);
    _createConfigForm(directoryPath);
    _createWidgetMetadata(directoryPath, projectName);
  }


}