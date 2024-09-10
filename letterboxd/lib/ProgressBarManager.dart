import 'package:flutter/material.dart';

class ProgressBarManager with ChangeNotifier {
  double _progress = 0.0;

  double get progress => _progress;

  void startDownload() {
    // Simulate a download by periodically updating progress
    Future.delayed(Duration(seconds: 1), () {
      _progress += 0.2;
      if (_progress <= 1.0) {
        notifyListeners();
        startDownload(); // Continue the download process
      }
    });
  }
}
