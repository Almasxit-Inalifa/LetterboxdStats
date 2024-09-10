import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Constants.dart';

class GenrePieChart extends StatefulWidget {
  final Map<String, int> genreStats;
  final String username;

  const GenrePieChart(
      {super.key, required this.genreStats, required this.username});

  @override
  _GenrePieChartState createState() => _GenrePieChartState();
}

class _GenrePieChartState extends State<GenrePieChart> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final total = widget.genreStats.values.reduce((a, b) => a + b);

    return LayoutBuilder(
      builder: (context, constraints) {
        final radius = (constraints.maxWidth < constraints.maxHeight
                ? constraints.maxWidth
                : constraints.maxHeight) /
            2 *
            0.9;

        return FractionallySizedBox(
          widthFactor: 0.5,
          heightFactor: 0.5,
          child: PieChart(
            PieChartData(
              pieTouchData: PieTouchData(
                touchCallback: (FlTouchEvent event, pieTouchResponse) {
                  if (event is FlTapUpEvent) {
                    if (pieTouchResponse == null ||
                        pieTouchResponse.touchedSection == null) {
                      setState(() {
                        touchedIndex = -1;
                      });
                      return;
                    }

                    setState(() {
                      touchedIndex =
                          pieTouchResponse.touchedSection!.touchedSectionIndex;
                    });

                    if (touchedIndex != -1) {
                      String genre =
                          widget.genreStats.keys.toList()[touchedIndex];
                      _handleGenreTap(genre, widget.username);
                    }
                  }
                },
              ),
              sections: widget.genreStats.entries.map((entry) {
                bool isSmallSection = (radius * (entry.value / total) < 13);
                final percentage =
                    (entry.value / total * 100).toStringAsFixed(1);

                int index = widget.genreStats.keys.toList().indexOf(entry.key);

                return PieChartSectionData(
                  value: entry.value.toDouble(),
                  title:
                      '${(entry.key == 'Science Fiction') ? 'Sci-Fi' : entry.key}\n$percentage%',
                  color: Constants.COLORS[index],
                  radius: radius,
                  titleStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 11,
                      fontWeight: FontWeight.bold),
                  showTitle: isSmallSection ? false : true,
                  titlePositionPercentageOffset: isSmallSection ? 1.4 : 0.7,
                );
              }).toList(),
              centerSpaceRadius: 0,
            ),
          ),
        );
      },
    );
  }

  void _handleGenreTap(String genre, String username) {
    launchUrl(Uri.parse('https://letterboxd.com/$username/films/genre/' +
        genre.replaceAll(' ', '-').toLowerCase()));
  }
}
