import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mosaico_flutter_core/core/utils/toaster.dart';
import 'package:mosaico_flutter_core/features/config_generator/data/models/config_output.dart';
import 'package:mosaico_flutter_core/features/config_generator/presentation/pages/config_form_page.dart';
import '../../../states/edited_file_state.dart';
import '../../../states/project_state.dart';
import '../matrix_editor.dart';
import 'package:highlight/languages/json.dart';

class MetadataEditor extends MatrixEditor {

  MetadataEditor({super.key, required super.file})
      : super(
          icon: const Icon(Icons.info),
          title: 'Metadata',
          language: json,
        );

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
    ];
  }
}
