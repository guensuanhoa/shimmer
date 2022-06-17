import 'package:flutter/material.dart';

enum MainState { loading, idle }

class MainVm extends ChangeNotifier {
  MainState _mainState = MainState.idle;

  MainState get mainState => _mainState;

  set mainState(MainState value) {
    if (_mainState != value) {
      _mainState = value;
      notifyListeners();
    }
  }

  void loadData() async {
    print('MainVm.loadData: 1 mainState=$mainState');
    mainState = MainState.loading;
    print('MainVm.loadData: 2 mainState=$mainState');
    await Future.delayed(const Duration(seconds: 5));
    mainState = MainState.idle;
    print('MainVm.loadData: 3 mainState=$mainState');
  }
}
