import 'dart:convert';
import 'dart:io';

/// The purpose of this file is to create the necessary files to initialize a new project
/// The files created are:
/// - widget.py: The main script used to program the widget
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
        "placeholder": "Enter some text here :)"
      }
    },
    {
      "description": {
        "type": "string",
        "label": "Description",
        "required": true,
        "placeholder": "Some other text"
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
  "widget_version": "1.0",
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
    var file = File('$directoryPath/widget.py');
    await file.writeAsString(
        '''
from mosaico import widget

# Called on widget load

# Called once each frame
def loop():
    pass
        '''
    );
  }


}