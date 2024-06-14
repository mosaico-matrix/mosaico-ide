import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:mosaico_ide/configuration/app_color_scheme.dart';
import 'package:mosaico_ide/project/project_manager.dart';
import 'package:mosaico_ide/project/widgets/editor.dart';

void main() {
  runApp(MaterialApp(
      theme: ThemeData(
        fontFamily: 'Dotted',
        colorScheme: AppColorScheme.getDefaultColorScheme(),
      ),
      home: HomePage()));
}

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mosaico IDE"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () => _onAddProjectPressed(context),
                  icon: Icon(Icons.add_circle, size: 150),
                ),
                IconButton(
                  onPressed: () => _onOpenProjectPressed(context),
                  icon: Icon(Icons.folder, size: 150),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _onAddProjectPressed(BuildContext context) async {

    // Request file picker to select a directory
    String? directoryPath = await FilePicker.platform.getDirectoryPath();

    if (directoryPath != null) {

      // Create a new project manager
      var projectManager = await ProjectManager.createNewProject(directoryPath, "TEST");

      // Navigate to the editor page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Editor(projectManager),
        ),
      );
    }
  }

  void _onOpenProjectPressed(BuildContext context) async {

    // Request file picker to select a directory
    String? directoryPath = await FilePicker.platform.getDirectoryPath();

    if (directoryPath != null) {

      // Create a new project manager
      var projectManager = await ProjectManager.openProject(directoryPath);

      // Navigate to the editor page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Editor(projectManager),
        ),
      );
    }
  }
}
