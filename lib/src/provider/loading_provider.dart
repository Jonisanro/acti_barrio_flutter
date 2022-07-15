import 'package:flutter/material.dart';

class LoadingProvider with ChangeNotifier {
  bool _loadingOn = false;

  bool get loadingOn {
    return _loadingOn;
  }

  set loadingOn(bool value) {
    _loadingOn = value;

    notifyListeners();
  }
}
