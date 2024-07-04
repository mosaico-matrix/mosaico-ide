import 'dart:convert';
import 'dart:io';

/// The purpose of this file is to create the necessary files to initialize a new project
/// The files created are:
/// - widget.chai: The main script used to program the widget
/// - config-form.json: A file used as a template for the user's configurations for every widget
/// - mosaico.json: A file containing metadata about the project, think it like a package.json file
class ProjectBuilder
{

  /// Create all required files for a new project
  static Future createNewProject(String directoryPath, String projectName) async {

    // Create necessary files
    _createWidgetScript(directoryPath);
    _createConfigForm(directoryPath);
    _createWidgetMetadata(directoryPath, projectName);
  }

  /// File used as a template for the user's configurations for every widget
  static void _createConfigForm(String directoryPath) async {
    var file = File('$directoryPath/config-form.json');
    await file.writeAsString(
        '''
{
"form": {
"title": "Widget Configuration",
"description": "Configure your widget here",
  "fields": [
    {
      "name": {
        "type": "string",
        "label": "Name",
        "required": true,
        "placeholder": "Enter some text here :)",
        "validation": {
          "minLength": 3,
          "maxLength": 20
        }
      }
    },
    {
      "email": {
        "type": "string",
        "label": "Description",
        "required": true,
        "placeholder": "Some other text",
        "validation": {
          "pattern": "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+\$"
        }
      }
    }
  ]
}
}
        '''
    );
  }

  static void _createWidgetMetadata(String directoryPath, String projectName) async {
    await File('$directoryPath/mosaico.json').writeAsString(
        '''
{
  "name": "$projectName",
  "description": "A new Mosaico project",
  "version": "1.0",
  "software_version": "1.0",
  "author": "Mosaico Team",
  "fps": 20,
  "configurable": false
}
        '''
    );
  }

  /// Main script used to program the widget
  static void _createWidgetScript(String directoryPath) async {
    var file = File('$directoryPath/widget.chai');
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


}