import 'package:flutter/material.dart';
import 'package:mosaico_ide/project/controllers/sidebar_controller.dart';
import 'package:mosaico_ide/project/widgets/sidebar.dart';
import 'package:provider/provider.dart';
import '../controllers/project_controller.dart';

class Project extends StatefulWidget {
  final ProjectController projectController;

  const Project(this.projectController, {super.key});

  @override
  _ProjectState createState() => _ProjectState();
}

class _ProjectState extends State<Project> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => SidebarController()),
          ChangeNotifierProvider(create: (context) => widget.projectController),
        ],
        child: Scaffold(
          appBar: AppBar(
            title: Text(widget.projectController.getProjectName()),
          ),
          drawer: Sidebar(),
          body: Consumer<SidebarController>(
            builder: (context, controller, child) {
              return controller.getSelectedEditor() ?? EmptyEditor();
            },
          )
        ));
  }

  Widget EmptyEditor() {
    return const Center(
      child: Text("No editor selected"),
    );
  }
}
