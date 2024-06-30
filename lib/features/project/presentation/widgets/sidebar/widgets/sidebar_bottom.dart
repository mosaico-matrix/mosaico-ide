import 'package:flutter/material.dart';

class SidebarBottom extends StatelessWidget {
  const SidebarBottom({super.key});
  @override
  Widget build(BuildContext context) {
      return ListTile(
          title:
              const Text('Close project', style: TextStyle(color: Colors.red)),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          });
  }
}
