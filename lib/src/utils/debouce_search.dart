import 'dart:async';

import 'package:flutter/material.dart';

class Debounce {
  final Duration duration;
  Timer _timer;
  Debounce({this.duration = const Duration(milliseconds: 500)});

  create(VoidCallback callback) {
    cancel();
    _timer = Timer(this.duration, callback);
  }

  cancel() {
    if (_timer != null) {
      _timer.cancel();
    }
  }
}
