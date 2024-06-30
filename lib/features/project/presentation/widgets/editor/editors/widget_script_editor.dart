import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:highlight/languages/javascript.dart';
import 'package:mosaico_flutter_core/core/utils/toaster.dart';
import 'package:mosaico_flutter_core/features/config_generator/data/models/config_output.dart';
import 'package:mosaico_flutter_core/features/config_generator/presentation/pages/config_form_page.dart';
import '../../../states/project_state.dart';
import '../matrix_editor.dart';
import 'package:highlight/languages/json.dart';

class WidgetScriptEditor extends MatrixEditor {

  WidgetScriptEditor({super.key, required super.file})
      : super(
          icon: const Icon(Icons.code),
          title: 'Widget Script',
          language: javascript,
        );

  @override
  List<Widget> buildActions(
      BuildContext context, ProjectState projectController) {
    return [


    ];
  }
}
