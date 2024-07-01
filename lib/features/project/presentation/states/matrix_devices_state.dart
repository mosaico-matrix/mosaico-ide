import 'package:flutter/material.dart';
import 'package:mosaico_flutter_core/core/networking/services/coap/coap_service.dart';
import 'package:mosaico_flutter_core/core/utils/toaster.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/data/repositories/mosaico_widgets_repository_impl.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/domain/repositories/mosaico_widgets_repository.dart';
class MatrixDevicesState extends ChangeNotifier {

  final MosaicoWidgetsRepository _widgetsRepository = MosaicoWidgetsRepositoryImpl();

  /*
  * Matrix IP
  */
  String _matrixIp = '';
  String get matrixIp => _matrixIp;
  void setMatrixIp(String matrixIp) {
    _matrixIp = matrixIp;
  }

  /*
  * Matrix actions
  */
  void ensureConnectedOrThrow() async {
    CoapService.setMatrixIp(matrixIp);
    // this crashes if the matrix is not connected
    var widget = await _widgetsRepository.getInstalledWidgets();
  }

  Future playProjectOnMatrix(String projectName, String archivePath) async {
    var result = await _widgetsRepository.installDevelopedWidget(projectName: projectName, archivePath: archivePath);
    await _widgetsRepository.previewWidget(widgetId: result.id);
  }

}
