import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mosaico_flutter_core/core/utils/toaster.dart';
import 'package:mosaico_flutter_core/features/config_generator/data/models/config_output.dart';
import 'package:mosaico_flutter_core/features/config_generator/presentation/pages/config_form_page.dart';
import '../../../states/edited_file_state.dart';
import '../../../states/project_state.dart';
import '../matrix_editor.dart';
import 'package:highlight/languages/json.dart';

class ConfigFormEditor extends MatrixEditor {

  ConfigFormEditor({super.key, required super.file})
      : super(
          icon: const Icon(Icons.edit_document),
          title: 'Configuration Form',
          language: json,
        );

  @override
  List<Widget> buildActions(BuildContext context) {
    return [

      IconButton(
        icon: const Icon(Icons.construction),
        tooltip: 'Build',
        onPressed: () async {

          /// Save changes made to the file
          saveChanges();

          /// Todo: validate the form
          var form = jsonDecode(file.getContent());

          // Navigate to config generator
          ConfigOutput? output = await Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => ConfigFormPage(form),
          ));

          // User dismissed the form
          if (output == null) {
            return;
          }

          // Export the output to the archive
          //output.exportToArchive();
          Toaster.success('Built!');

          },
      ),
    ];
  }
}
