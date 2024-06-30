import 'package:flutter/material.dart';
import 'package:mosaico_ide/features/project/presentation/widgets/appbar/project_app_bar.dart';
import 'package:mosaico_ide/features/project/presentation/widgets/fab/save_project_button.dart';
import 'package:provider/provider.dart';
import '../states/matrix_state.dart';
import '../states/project_state.dart';
import '../widgets/sidebar/sidebar.dart';

class ProjectPage extends StatelessWidget {
  final String _workingPath;
  const ProjectPage(this._workingPath, {super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProjectState(_workingPath)),
        ChangeNotifierProvider(create: (context) => ProjectState(_workingPath)),
        ChangeNotifierProvider(create: (context) => MatrixState()),
      ],

      child: Builder(
        builder: (context) {
          return Scaffold(

            // Top bar
            appBar: const ProjectAppBar(),

            // Floating action button
            floatingActionButton: const SaveProjectButton(),

            // Left sidebar
            drawer: const Sidebar(),

            // Editor
            body: Scaffold(
              body: context.watch<ProjectState>().getSelectedEditor()
            ),
          );
        },
      ),
    );
  }
}
