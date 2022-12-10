import 'dart:async';
import 'package:flutter/material.dart';

class Debounce {
  final int milliseconds;
  Debounce({
    this.milliseconds = 500,
  });

  Timer? _timer;

  void run(VoidCallback action) {
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}

class Throttle {
  final int milliseconds;

  Throttle({
    required this.milliseconds,
  });

  Timer? _timer;
  bool isAction = false;

  void run(VoidCallback action) {
    if (isAction) {
      return;
    }

    if (!isAction) {
      action();
      isAction = true;
      _timer = Timer(Duration(milliseconds: milliseconds), () {
        isAction = false;
      });
    }
  }
}