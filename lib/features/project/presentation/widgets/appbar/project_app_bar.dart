import 'package:flutter/material.dart';
import 'package:mosaico_ide/features/project/presentation/widgets/appbar/widgets/connected_matrix_device.dart';
import 'package:provider/provider.dart';

import '../../states/project_state.dart';

class ProjectAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ProjectAppBar({super.key});


  @override
  Widget build(BuildContext context) {
    var projectState = Provider.of<ProjectState>(context);
    return AppBar(
      title: Text(projectState.getName()),
      actions: const [
        ConnectedMatrixDevice()
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
