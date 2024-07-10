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
    var file = File('$directoryPath/widget.py');
    await file.writeAsString(
        '''
from mosaico import widget

# A nice rectangle
rectTop = widget.createRectangle()
rectTop.translateY(10)
rectTop.translateX(-rectTop.getWidth())

# Another nice rectangle
rectTop2 = widget.createRectangle()
rectTop2.translateY(10)
rectTop2.translateX(64+rectTop2.getWidth())

# A nice rectangle
rectBottom = widget.createRectangle()
rectBottom.translateY(40)
rectBottom.translateX(-rectBottom.getWidth())

# Another nice rectangle
rectBottom2 = widget.createRectangle()
rectBottom2.translateY(40)
rectBottom2.translateX(64+rectBottom2.getWidth())

# A nice text
text = widget.createText()
text.setText("Hello World")
text.translateX(10)
text.translateY(25)


i = 0
def loop():
    global i
    i += 1
    if i > 70:
        i = 0
    rectTop.moveTo(i, rectTop.getY())
    rectTop2.moveTo(63-i-rectTop2.getWidth(), rectTop2.getY())
    rectBottom.moveTo(i, rectBottom.getY())
    rectBottom2.moveTo(63-i-rectBottom2.getWidth(), rectBottom2.getY())
    pass
        '''
    );
  }


}