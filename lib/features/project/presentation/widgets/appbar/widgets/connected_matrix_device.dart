import 'package:flutter/material.dart';

class ConnectedMatrixDevice extends StatelessWidget {
  const ConnectedMatrixDevice({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 250,
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Matrix IP',
          hintStyle: TextStyle(color: Color(0xFFCCCCCC)),
        ),
      ),
    );
  }
}
