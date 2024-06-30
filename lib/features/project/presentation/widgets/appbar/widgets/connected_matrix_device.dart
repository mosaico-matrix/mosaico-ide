import 'package:flutter/material.dart';
import 'package:mosaico_ide/features/project/presentation/states/matrix_devices_state.dart';
import 'package:provider/provider.dart';

class ConnectedMatrixDevice extends StatelessWidget {
  const ConnectedMatrixDevice({super.key});

  @override
  Widget build(BuildContext context) {
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
                onPressed: () {
                  deviceState.checkActiveMatrixConnection();
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
