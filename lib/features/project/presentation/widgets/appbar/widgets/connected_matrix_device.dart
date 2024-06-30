import 'package:flutter/material.dart';
import 'package:mosaico_flutter_core/core/utils/toaster.dart';
import 'package:mosaico_ide/features/project/presentation/states/matrix_devices_state.dart';
import 'package:provider/provider.dart';

import '../../../states/project_state.dart';

class ConnectedMatrixDevice extends StatelessWidget {
  const ConnectedMatrixDevice({super.key});

  @override
  Widget build(BuildContext context) {

    var projectState = Provider.of<ProjectState>(context);

    return ChangeNotifierProvider(
      create: (context) => MatrixDevicesState(),
      child: Consumer<MatrixDevicesState>(
        builder: (context, deviceState, child) {
          return Row(
            children: [
              SizedBox(
                width: 200,
                child: TextField(
                  onChanged: (value) {
                    deviceState.setMatrixIp(value);
                  },
                ),
              ),
              IconButton(
                icon: const Icon(Icons.play_arrow),
                onPressed: () async {

                  // Check matrix connection
                  deviceState.checkActiveMatrixConnection();

                  // Build project
                  var archivePath = await projectState.buildProjectPackage();

                  // Send project to matrix
                  deviceState.sendProjectToMatrix(archivePath);
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
