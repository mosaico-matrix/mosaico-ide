import 'package:flutter/material.dart';
import 'package:mosaico_flutter_core/core/utils/toaster.dart';
import 'package:provider/provider.dart';

import '../../states/project_state.dart';

class SaveProjectButton extends StatelessWidget {
  const SaveProjectButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: context.watch<ProjectState>().getSelectedEditor() != null,
      child: FloatingActionButton(
        onPressed: (){
          context.read<ProjectState>().getSelectedEditor().saveChanges();
          Toaster.success('Saved!');
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}
