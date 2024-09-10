import 'package:flutter/material.dart';
import 'package:letterboxd/ProgressBarManager.dart';
import 'package:provider/provider.dart';

class ProgressBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProgressBarManager()..startDownload(),
      child: Scaffold(
        appBar: AppBar(title: Text("Progress Bar Example")),
        body: Center(
          child: Consumer<ProgressBarManager>(
            builder: (context, downloadManager, child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(value: downloadManager.progress),
                  SizedBox(height: 20),
                  Text(
                      '${(downloadManager.progress * 100).toStringAsFixed(1)}%'),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
