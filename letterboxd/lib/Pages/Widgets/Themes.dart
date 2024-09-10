import 'package:flutter/material.dart';
import 'package:letterboxd/Pages/Widgets/DropDown.dart';
import 'package:letterboxd/Pages/Widgets/Link.dart';
import 'package:letterboxd/Models/ThemeLetterboxd.dart';

class Themes extends StatefulWidget {
  final Map<ThemeLetterboxd, int> themeCount;
  final Map<ThemeLetterboxd, double> themeRating;

  const Themes({
    super.key,
    required this.themeCount,
    required this.themeRating,
  });

  @override
  State<Themes> createState() => _ThemesState();
}

class _ThemesState extends State<Themes> {
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
          child: _buildThemesWidget(),
        ),
      ],
    );
  }

  Widget _buildThemesWidget() {
    final isMostWatched = selectedWidget == 'Most Watched';
    final sortedEntries =
        (isMostWatched ? widget.themeCount : widget.themeRating)
            .entries
            .toList();

    final firstTwentyEntries = sortedEntries.take(20);

    if (firstTwentyEntries.isEmpty) return Row();

    final firstTwentyMap = Map.fromEntries(firstTwentyEntries);
    final entryKeys = firstTwentyMap.keys.toList();
    final middleIndex = (entryKeys.length / 2).ceil();

    final List<ThemeLetterboxd> leftKeys = entryKeys.sublist(0, middleIndex);
    List<ThemeLetterboxd> rightKeys = [];
    if (middleIndex < entryKeys.length)
      rightKeys = entryKeys.sublist(middleIndex);

    final max = firstTwentyMap[entryKeys[0]]!.toDouble();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ThemeColumn(
          keys: leftKeys,
          firstTwentyMap: firstTwentyMap,
          max: max,
          isMostWatched: isMostWatched,
          addExtra: false,
        ),
        ThemeColumn(
          keys: rightKeys,
          firstTwentyMap: firstTwentyMap,
          max: max,
          isMostWatched: isMostWatched,
          addExtra: (rightKeys.length < leftKeys.length),
        ),
      ],
    );
  }
}

class ThemeColumn<T> extends StatelessWidget {
  final List<ThemeLetterboxd> keys;
  final Map<ThemeLetterboxd, T> firstTwentyMap;
  final double max;
  final bool isMostWatched;
  final bool addExtra;

  const ThemeColumn(
      {super.key,
      required this.keys,
      required this.firstTwentyMap,
      required this.max,
      required this.isMostWatched,
      required this.addExtra});

  @override
  Widget build(BuildContext context) {
    if (keys.isEmpty) return Column();

    final theme = Theme.of(context);
    int fixed = 2;
    if (isMostWatched) fixed = 0;

    List<Widget> column = keys.map((key) {
      return Padding(
        padding: const EdgeInsets.all(4.0),
        child: Link(
          url: 'https://letterboxd.com/' + key.link,
          hoverConfig: HoverConfig(),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.47,
            height: MediaQuery.of(context).size.height *
                0.50 /
                (keys.length + (addExtra ? 1 : 0)),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [theme.primaryColor, theme.disabledColor],
                stops: [
                  _getValue(firstTwentyMap[key] as T) / max,
                  _getValue(firstTwentyMap[key] as T) / max,
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(0, 2),
                  blurRadius: 4.0,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 7),
                    child: Text(
                      key.name,
                      style: const TextStyle(color: Colors.white),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 7),
                  child: Text(
                    _getValue(firstTwentyMap[key] as T).toStringAsFixed(fixed),
                    style: const TextStyle(color: Colors.white),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }).toList();

    if (addExtra) {
      column.add(Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.47,
          height: MediaQuery.of(context).size.height *
              0.50 /
              (keys.length + (addExtra ? 1 : 0)),
          child: Row(),
        ),
      ));
    }

    return Expanded(
      child: Column(
        children: column,
      ),
    );
  }

  double _getValue(T value) {
    if (value is int) {
      return value.toDouble();
    } else if (value is double) {
      return value;
    } else {
      throw ArgumentError('Unsupported value type');
    }
  }
}
