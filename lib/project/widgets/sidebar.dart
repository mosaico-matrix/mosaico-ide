import 'package:flutter/material.dart';
import 'package:mosaico_ide/project/widgets/editors/editor.dart';
import 'package:mosaico_ide/project/widgets/editors/config_form_editor.dart';
import 'package:provider/provider.dart';
import '../../toaster.dart';
import '../state/project_state.dart';
import '../state/sidebar_state.dart';

class Sidebar extends StatelessWidget {

  // Register all available editors
  final List<Editor> editors = [
    ConfigFormEditor(),
  ];

  Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
      
          // Header
          Header(context),
      
          // List of file editors
          Editors(),
      
          // Bottom stuff
          const Spacer(),
          const Divider(),
          BottomOptions(context),
        ],
      ),
    );
  }

  Widget Editors() {
    return Expanded(
      child: ListView.builder(
        itemCount: editors.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(editors[index].title),
            leading: editors[index].icon,
            onTap: () {

              // Check if current file is dirty before navigating
              bool dirty = Provider.of<ProjectState>(context, listen: false).isDirty();

              // If dirty, show a dialog to confirm
              if (dirty) {
                Toaster.warning('You have unsaved changes!');
              }

              // Set selected editor
              Provider.of<SidebarState>(context, listen: false)
                  .setSelectedEditor(editors[index]);

              // Close the drawer
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
