import 'package:flutter/material.dart';
import 'package:mosaico_ide/project/state/sidebar_state.dart';
import 'package:mosaico_ide/project/widgets/sidebar.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';
import '../../toaster.dart';
import '../state/project_state.dart';

class Project extends StatelessWidget {
  final String _workingPath;

  const Project(this._workingPath, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SidebarState()),
        ChangeNotifierProvider(create: (context) => ProjectState(_workingPath)),
      ],
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: Text(context.watch<ProjectState>().getProjectName()),
            ),
            floatingActionButton: Visibility(
              visible: context.watch<ProjectState>().isDirty(),
              child: FloatingActionButton(
                onPressed: (){
                  context.read<ProjectState>().saveProject();
                  Toaster.success('Saved!');
                },
                child: const Icon(Icons.save),
              ),
            ),
            drawer: Sidebar(),
            body: Scaffold(
              body: context.watch<SidebarState>().getSelectedEditor() ??
                  EmptyEditor(),
            ),
          );
        },
      ),
    );
  }

  Widget EmptyEditor() {
    return const Center(
      child: Text("No editor selected"),
    );
  }
}