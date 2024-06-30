import 'package:flutter/material.dart';
import 'package:mosaico_ide/project/states/matrix_state.dart';
import 'package:mosaico_ide/project/states/sidebar_state.dart';
import 'package:mosaico_ide/project/widgets/sidebar.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';
import 'package:mosaico_flutter_core/toaster.dart';
import '../states/project_state.dart';

class Project extends StatelessWidget {
  final String _workingPath;

  const Project(this._workingPath, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SidebarState()),
        ChangeNotifierProvider(create: (context) => ProjectState(_workingPath)),
        ChangeNotifierProvider(create: (context) => MatrixState()),
      ],
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: Text(context.watch<ProjectState>().getProjectName()),
              actions: const [
                SizedBox(
                  width: 250,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Matrix IP',
                    ),
                  ),
                ),
              ],
            ),
            floatingActionButton: Visibility(
              visible: context.watch<SidebarState>().getSelectedEditor() != null,
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
