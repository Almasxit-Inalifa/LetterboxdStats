import 'package:flutter/material.dart';
import 'package:letterboxd/Pages/Widgets/Link.dart';
import 'package:letterboxd/Constants.dart';

class GenreColorChart extends StatelessWidget {
  final Map<String, int> genreStats;
  final String username;

  const GenreColorChart(
      {super.key, required this.genreStats, required this.username});

  @override
  Widget build(BuildContext context) {
    final entries = genreStats.entries.toList();
    List<Widget> colorRows = entries.map((entry) {
      final index = entries.indexOf(entry); // Get index for color
      final color = Constants.COLORS[index]; // Get color for each entry

      final total = genreStats.values.reduce((a, b) => a + b);
      int num = genreStats[entry.key] ??= 0;
      final percentage = (entry.value / total * 100).toStringAsFixed(1);

      return Row(children: [
        Link(
          url:
              'https://letterboxd.com/$username/films/genre/${entry.key.replaceAll(' ', '-').toLowerCase()}',
          hoverConfig: HoverConfig(translationYOnHover: -4),
          child: Tooltip(
            message: '$num Film${num > 1 ? 's' : ''} ($percentage%)',
            child: Row(
              children: [
                Container(
                  width: 20,
                  height: 20,
                  color: color,
                ),
                const SizedBox(width: 8),
                Text(
                  entry.key,
                  style: const TextStyle(
                      color: Colors.white), // Customize text style
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ]);
    }).toList();

    if (colorRows.length > 8) {
      int firstHalfLen = (colorRows.length / 2).ceil();
      List<Widget> colorRowsLeft = colorRows.sublist(0, firstHalfLen);
      List<Widget> colorRowsRight = colorRows.sublist(firstHalfLen);

      if (colorRowsLeft.length != colorRowsRight.length) {
        colorRowsRight.add(
          Row(
            children: [
              SizedBox(
                width: 20,
                height: 20,
              ),
              SizedBox(width: 8),
              // Entry key
              Text(
                '',
                style: TextStyle(color: Colors.white), // Customize text style
              ),
            ],
          ),
        );
      }

      return Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.19,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: colorRowsLeft,
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.19,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: colorRowsRight,
            ),
          ),
        ],
      );
    } else {
      return Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.1,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.28,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: colorRows,
            ),
          ),
        ],
      );
    }
  }
}
