import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Colorchange with ChangeNotifier {
  final List _listofcolors = [
    const Color.fromARGB(255, 158, 237, 161),
    const Color.fromARGB(255, 237, 139, 132),
    const Color.fromARGB(255, 235, 224, 131),
    const Color.fromARGB(255, 226, 155, 239),
    const Color.fromARGB(255, 138, 189, 231),
    const Color.fromARGB(255, 230, 142, 172),
  ];
  List get listofcolors => _listofcolors;

  int _selectdIndex = 0;
  int get selectdIndex => _selectdIndex;

  void setIndex(int index) {
    _selectdIndex = index;
    notifyListeners();
  }
}
