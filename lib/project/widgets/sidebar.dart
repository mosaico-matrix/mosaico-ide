import 'package:flutter/material.dart';
import '../project_manager.dart';
import 'sidebar_item.dart'; // import the SidebarItem widget

class Sidebar extends StatefulWidget {
  final ProjectManager projectManager;
  final VoidCallback onRunnerPressed;
  final VoidCallback onFormPressed;
  final VoidCallback onConfigurationPressed;

  Sidebar({
    required this.projectManager,
    required this.onRunnerPressed,
    required this.onFormPressed,
    required this.onConfigurationPressed,
    Key? key,
  }) : super(key: key);

  @override
  _SidebarState createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  bool isCollapsed = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      width: isCollapsed ? 50 : 250,
      color: Colors.black,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Sidebar header
          Row(
            children: [
              IconButton(
                icon: Icon(
                  isCollapsed
                      ? Icons.view_sidebar_outlined
                      : Icons.view_sidebar,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    isCollapsed = !isCollapsed;
                  });
                },
              ),
              Text(isCollapsed ? '' : widget.projectManager.getProjectName(),
                  style: const TextStyle(color: Colors.white)),
            ],
          ),

          // Sidebar items
          Expanded(
            child: ListView(
              children: [
                SidebarItem(
                  icon: Icons.home,
                  title: 'Runner',
                  isCollapsed: isCollapsed,
                  onTap: widget.onRunnerPressed,
                ),
                SidebarItem(
                  icon: Icons.person,
                  title: 'Form',
                  isCollapsed: isCollapsed,
                  onTap: widget.onFormPressed,
                ),
                SidebarItem(
                  icon: Icons.settings,
                  title: 'Configuration',
                  isCollapsed: isCollapsed,
                  onTap: widget.onConfigurationPressed,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
