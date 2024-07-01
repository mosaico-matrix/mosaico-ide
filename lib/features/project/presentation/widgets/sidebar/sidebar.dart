import 'package:flutter/material.dart';
import 'package:mosaico_ide/features/project/presentation/widgets/sidebar/widgets/sidebar_bottom.dart';
import 'package:mosaico_ide/features/project/presentation/widgets/sidebar/widgets/sidebar_editors.dart';
import 'package:mosaico_ide/features/project/presentation/widgets/sidebar/widgets/sidebar_header.dart';

class Sidebar extends StatelessWidget {

  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Drawer(
      child: Column(
        children: [
          // Header
          SidebarHeader(),

          // List of file editors
          SidebarEditors(),

          // Divide the editors from the bottom
          Spacer(),
          Divider(),
          SidebarBottom(),
        ],
      ),
    );
  }
}
