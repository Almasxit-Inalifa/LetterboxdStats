import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:letterboxd/Pages/Widgets/DropDown.dart';
import 'package:letterboxd/Pages/Widgets/GenreColorChart.dart';
import 'package:letterboxd/Pages/Widgets/GenrePieChart.dart';
import 'package:url_launcher/url_launcher.dart';

class Genres extends StatefulWidget {
  final Map<String, int> genreCount;
  final Map<String, double> genreRating;
  final String username;
  //final String username;

  const Genres(
      {super.key,
      required this.genreCount,
      required this.genreRating,
      required this.username});

  @override
  State<Genres> createState() => _GenresState();
}

class _GenresState extends State<Genres> {
  String selectedWidget = 'Most Watched';

  List<Color> colors = [
    const Color.fromRGBO(0, 224, 84, 30),
    const Color.fromRGBO(64, 188, 244, 30),
    const Color.fromRGBO(255, 128, 0, 30),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: DropDown(
            selectedWidget: selectedWidget,
            onWidgetChanged: (String? newValue) {
              setState(() {
                selectedWidget = newValue ?? 'Most Watched';
              });
            },
          ),
        ),
        Container(
          child: _getSelectedWidget(),
        ),
      ],
    );
  }

  Widget _getSelectedWidget() {
    final safeData = widget.genreRating.map((key, value) {
      if (value.isNaN || value.isInfinite) {
        return MapEntry(key, 0.0);
      }
      return MapEntry(key, value);
    });

    switch (selectedWidget) {
      case 'Most Watched':
        return _buildGenrePieChart();
      case 'Highest Rated':
        return _buildGenreBarChart(safeData);
      default:
        return Container();
    }
  }

  Widget _buildGenrePieChart() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.6,
          width: MediaQuery.of(context).size.width * 0.58,
          child: GenrePieChart(
            genreStats: widget.genreCount,
            username: widget.username,
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.04,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.6,
          width: MediaQuery.of(context).size.width * 0.38,
          child: GenreColorChart(
            genreStats: widget.genreCount,
            username: widget.username,
          ),
        ),
      ],
    );
  }

  Widget _buildGenreBarChart(Map<String, double> safeData) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(4.0),
            child: Text(
              'Only genres with at least three rated films are included.',
              style: TextStyle(color: Color.fromARGB(255, 153, 153, 153)),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            width: MediaQuery.of(context).size.width * 0.85,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: BarChart(
                BarChartData(
                  minY: 0.5, // Minimum y-axis value
                  maxY: 5, // Maximum y-axis value
                  alignment: BarChartAlignment.spaceEvenly,
                  titlesData: FlTitlesData(
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 50,
                        interval: 0.5, // Interval between values
                        getTitlesWidget: (double value, TitleMeta meta) {
                          if (value % 0.5 == 0) {
                            return SideTitleWidget(
                              axisSide: meta.axisSide,
                              child: Text(
                                value.toStringAsFixed(1),
                                style: const TextStyle(color: Colors.white),
                              ),
                            );
                          }
                          return Container();
                        },
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (double value, TitleMeta meta) {
                          String genre = safeData.keys.elementAt(value.toInt());
                          if (genre == 'Science Fiction') genre = 'Sci-Fi';
                          return SideTitleWidget(
                            axisSide: meta.axisSide,
                            space:
                                4, // Add some spacing between the axis and the text
                            child: SizedBox(
                              height: 20, // Increase the height if needed
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal:
                                        4.0), // Adjust padding to avoid cutoffs
                                child: Align(
                                  alignment: Alignment
                                      .center, // Align the text properly within the box
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.7 /
                                        safeData.length,
                                    child: Center(
                                      child: Text(
                                        genre,
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 11),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border:
                        Border.all(color: const Color(0xff37434d), width: 1),
                  ),
                  barGroups: safeData.entries.map((entry) {
                    int index = safeData.keys.toList().indexOf(entry.key);
                    return BarChartGroupData(
                      x: index,
                      barRods: [
                        BarChartRodData(
                          toY: double.parse(entry.value.toStringAsFixed(2)),
                          color: colors[index % colors.length],
                          width: MediaQuery.of(context).size.width *
                              0.4 /
                              safeData.length,
                          borderRadius: BorderRadius.zero,
                        ),
                      ],
                    );
                  }).toList(),
                  barTouchData: BarTouchData(
                    touchCallback: (FlTouchEvent event, barTouchResponse) {
                      if (event is FlTapUpEvent &&
                          barTouchResponse != null &&
                          barTouchResponse.spot != null) {
                        final tappedIndex =
                            barTouchResponse.spot!.touchedBarGroupIndex;
                        String genre = safeData.keys.elementAt(tappedIndex);
                        _handleBarTap(genre, widget.username);
                      }
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleBarTap(String genre, String username) {
    launchUrl(Uri.parse('https://letterboxd.com/$username/films/genre/' +
        genre.replaceAll(' ', '-').toLowerCase()));
  }
}
