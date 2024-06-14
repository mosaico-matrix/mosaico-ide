import 'package:flutter/material.dart';
import 'package:mosaico_ide/project/widgets/sidebar.dart';

import '../project_manager.dart';

class Editor extends StatefulWidget {
  final ProjectManager projectManager;

  const Editor(this.projectManager, {super.key});

  @override
  _EditorState createState() => _EditorState();
}

class _EditorState extends State<Editor> {

  Widget rightPanel = Container();
  Widget getRightPanel() {
    return
      Expanded(
          child: rightPanel
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          children: [

            // Sidebar
            Sidebar(
                projectManager: widget.projectManager,
                onRunnerPressed: () {
                  setState(() {
                    rightPanel = Container(
                      color: Colors.red,
                      width: double.infinity,
                    );
                  });
                },
                onFormPressed: () {
                  setState(() {
                    rightPanel = Container(
                      color: Colors.green,
                      width: double.infinity,

                    );
                  });
                },
                onConfigurationPressed: () {
                  setState(() {
                    rightPanel = Container(
                      color: Colors.blue,
                      width: double.infinity,

                    );
                  });
                }
            ),

            // Right panel
            getRightPanel(),
          ],
        ),
      ),
    );
  }



}
