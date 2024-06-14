import 'package:flutter/material.dart';
import 'package:mosaico_ide/project/controllers/project_controller.dart';
import 'editor.dart';

class FormTemplateEditor extends Editor {
  FormTemplateEditor({Key? key}) : super(
    key: key,
    icon: Icon(Icons.edit),
    title: 'Form Template Editor',
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Form Template Editor'),
    );
  }


}