import 'package:flutter/material.dart';
import 'package:mosaico_ide/project/controllers/project_controller.dart';

abstract class Editor extends StatelessWidget {
  final Icon icon;
  final String title;

  const Editor({
    required this.icon,
    required this.title,
    Key? key,
  }) : super(key: key);

}
