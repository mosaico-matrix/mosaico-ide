import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:mosaico_flutter_core/exceptions/exception_handler.dart';
import 'package:mosaico_flutter_core/toaster.dart';
import 'package:mosaico_flutter_core/configuration/app_color_scheme.dart';
import 'package:mosaico_ide/project/project_builder.dart';
import 'package:mosaico_ide/project/widgets/project.dart';
import 'package:toastification/toastification.dart';

void main() {
  runZonedGuarded(() {
    runApp(const ToastificationWrapper(child: App()));
  }, (error, stackTrace) {
    handleException(error, stackTrace);
  });
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Dotted',
        colorScheme: AppColorScheme.getDefaultColorScheme(),
      ),
      home: Builder(
        builder: (context) =>  HomePage(), //TextsPage()//
      ),
    );
  }
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
            // Add project and open project buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () => _onCreateProjectPressed(context),
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

  void _navigateToProject(BuildContext context, String projectPath) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Project(projectPath),
      ),
    );
  }

  void _onCreateProjectPressed(BuildContext context) async {
    // Request file picker to select a directory
    String? directoryPath = await FilePicker.platform.getDirectoryPath();
    if (directoryPath == null) {
      // Todo: Show error message
      return;
    }

    // Create a new project
    ProjectBuilder.createNewProject(directoryPath, 'New Project');

    // Navigate to the editor page
    _navigateToProject(context, directoryPath);
  }

  void _onOpenProjectPressed(BuildContext context) async {
    // Request file picker to select a directory
    String? directoryPath = await FilePicker.platform.getDirectoryPath();

    if (directoryPath == null) {
      return;
    }

    // Navigate to the editor page
    _navigateToProject(context, directoryPath);
  }
}
