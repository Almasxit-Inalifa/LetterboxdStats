import 'package:flutter/material.dart';
import 'package:letterboxd/Pages/Widgets/Link.dart';
import 'package:letterboxd/Pages/Widgets/DropDown.dart';

class Years extends StatefulWidget {
  final Map<int, int> yearCount;
  final Map<int, double> yearRating;
  final String username;

  const Years(
      {super.key,
      required this.yearCount,
      required this.yearRating,
      required this.username});

  @override
  State<Years> createState() => _YearsState();
}

class _YearsState extends State<Years> {
  String selectedWidget = 'Most Watched';

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
    switch (selectedWidget) {
      case 'Most Watched':
        return Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: ByYear(
            yearStats: widget.yearCount,
            isMostWatched: true,
            username: widget.username,
          ),
        );
      case 'Highest Rated':
        return Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: ByYear(
              yearStats: widget.yearRating,
              isMostWatched: false,
              username: widget.username),
        );
      default:
        return Container();
    }
  }
}

class ByYear<V extends num> extends StatelessWidget {
  final Map<int, V> yearStats;
  final bool isMostWatched;
  final String username;

  const ByYear(
      {super.key,
      required this.yearStats,
      required this.isMostWatched,
      required this.username});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    List<int> yearsList = yearStats.keys.toList();
    if (yearsList.isEmpty) return const Row();
    if (yearsList[0] == 0) yearsList.remove(0);

    int firstYear = yearsList.first;
    int lastYear = yearsList.last;

    List<int> years = List<int>.generate(
        lastYear - firstYear + 1, (index) => firstYear + index);
    V max = yearStats.values.reduce((a, b) => a > b ? a : b);

    List<Widget> columns = years.map((year) {
      dynamic value = yearStats[year];
      Color color = Colors.grey;
      double height = 5;

      value ??= isMostWatched ? 0 : 0.0;
      String message = 'No Ratings\nReleased in $year';
      if (isMostWatched) message = 'No Films\nReleased in $year';

      if (value != 0) {
        String num = value.toStringAsFixed(2);
        message = 'Average: $num\nReleased in $year';
        color = Colors.orange;

        if (isMostWatched) {
          num = value.toStringAsFixed(0);
          String plural = '';
          if (value > 1) plural = 's';

          message = '$num Film$plural\nReleased in $year';
          color = Colors.green;
        }

        height = MediaQuery.of(context).size.height * 0.35 * (value / max);
      }

      return Tooltip(
        message: message,
        child: Link(
          url: 'https://letterboxd.com/$username/films/year/$year/',
          child: Container(
            color: color,
            height: height,
            width: MediaQuery.of(context).size.width * 0.9 / (years.length + 2),
          ),
          hoverConfig: HoverConfig(
            hoverColor: Colors.blue[100],
            elevationOnHover: 12,
            translationYOnHover: -8,
          ),
        ),
      );
    }).toList();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.bottomCenter,
          height: MediaQuery.of(context).size.height * 0.35,
          width: 40,
          child: Text(
            firstYear.toString(),
            style: theme.textTheme.bodySmall?.copyWith(
              color: Colors.white,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: columns,
        ),
        Container(
          alignment: Alignment.bottomCenter,
          height: MediaQuery.of(context).size.height * 0.35,
          width: 40,
          child: Text(
            lastYear.toString(),
            style: theme.textTheme.bodySmall?.copyWith(
              color: Colors.white,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
  }
}
