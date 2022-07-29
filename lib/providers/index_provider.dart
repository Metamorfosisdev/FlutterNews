import 'package:flutter/material.dart';

class IndexProvider extends ChangeNotifier {
  int _currentIndex = 0;
  final PageController _controller = PageController();

  int get currentIndex => _currentIndex;
  PageController get controller => _controller;

  set currentIndex(int index) {
    _currentIndex = index;
    _controller.animateToPage(index,
        curve: Curves.easeInOutCubicEmphasized,
        duration: const Duration(milliseconds: 250));
    notifyListeners();
  }
}
