import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mosaico_flutter_core/modules/config_form/models/config_output.dart';
import 'package:mosaico_flutter_core/modules/config_form/pages/config_generator.dart';
import 'package:mosaico_flutter_core/modules/networking/channels/coap/widget_configurations_service.dart';
import 'package:mosaico_ide/project/states/project_state.dart';
import 'package:mosaico_flutter_core/toaster.dart';
import 'package:provider/provider.dart';
import 'editor.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:highlight/languages/json.dart';
import 'package:flutter_highlight/themes/monokai-sublime.dart';

class WidgetScriptEditor extends Editor {


  WidgetScriptEditor({super.key})
      : super(
          icon: const Icon(Icons.code),
          title: 'Widget Script',
        );

  @override
  Widget buildEditor(BuildContext context) {
    return Text("hei");
  }

  @override
  List<Widget> buildActions(
      BuildContext context, ProjectState projectController) {
    return [];
  }
}
