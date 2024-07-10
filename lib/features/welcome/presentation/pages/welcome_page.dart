
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:mosaico_flutter_core/common/widgets/matrices/led_matrix.dart';
import 'package:mosaico_ide/features/project/presentation/pages/project_page.dart';
import '../../../../core/utils/project_structure_builder.dart';
import 'package:mosaico_flutter_core/common/widgets/matrices/loading_matrix.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

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

            // Matrix animation
            LoadingMatrix(n: 20,),

            const SizedBox(height: 50),


            // Add project and open project buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () => _onCreateProjectPressed(context),
                  icon: const Icon(Icons.add_circle, size: 150),
                ),
                IconButton(
                  onPressed: () => _onOpenProjectPressed(context),
                  icon: const Icon(Icons.folder, size: 150),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Navigate to the project page after opening or creating a project
  void _navigateToProject(BuildContext context, String projectPath) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProjectPage(projectPath),
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
