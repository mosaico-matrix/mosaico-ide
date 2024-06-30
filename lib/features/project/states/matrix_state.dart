import 'package:flutter/material.dart';

class MatrixState extends ChangeNotifier
{
  /*
  * Matrix connection
  */
  String _matrixIp = '';
  void setMatrixIp(String ip) {
    _matrixIp = ip;
  }

}