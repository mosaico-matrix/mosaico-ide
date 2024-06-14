import 'package:flutter/material.dart';
import 'package:mosaico_ide/project/widgets/editors/editor.dart';
import 'package:mosaico_ide/project/widgets/editors/config_form_editor.dart';
import 'package:provider/provider.dart';
import '../controllers/project_controller.dart';
import '../controllers/sidebar_controller.dart';

class Sidebar extends StatelessWidget {
  final List<Editor> editors = [
    ConfigFormEditor(),
  ];

  Sidebar({super.key});

  @override
  Widget build(BuildContext context) {

    return Consumer<SidebarController>(
        builder: (context, controller, child) => Drawer(
              child: Column(
                children: [
                  // Header
                  Header(context),

                  // List of file editors
                  Editors(controller),

                  // Bottom stuff
                  const Spacer(),
                  const Divider(),
                  BottomOptions(context),
                ],
              ),
            ));
  }

  Widget Editors(SidebarController controller) {
    return Expanded(
      child: ListView.builder(
        itemCount: editors.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(editors[index].title),
            leading: editors[index].icon,
            onTap: () {

              // Check if dirty before navigating
              //if(controller.dir)

              controller.setSelectedEditor(editors[index]);
              Navigator.of(context).pop();
            },
          );
        },
      ),
    );
  }

  Widget Header(BuildContext context) {
    return DrawerHeader(
      decoration: const BoxDecoration(
        color: Colors.black,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Mosaico IDE',
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
          IconButton(
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pop(); // Close the drawer
            },
          ),
        ],
      ),
    );
  }

  Widget BottomOptions(BuildContext context) {
    return ListTile(
      title: const Text('Close project'),
      onTap: () {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      },
    );
  }
}
