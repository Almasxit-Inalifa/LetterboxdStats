import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:letterboxd/Pages/Widgets/DropDown.dart';
import 'package:letterboxd/Pages/Widgets/Link.dart';
import 'package:letterboxd/Constants.dart';
import 'package:letterboxd/converter.dart';

class CountriesAndLanguages extends StatefulWidget {
  final Map<String, int> count;
  final Map<String, double> rating;
  final bool isCountry;

  const CountriesAndLanguages(
      {super.key,
      required this.count,
      required this.rating,
      required this.isCountry});

  @override
  State<CountriesAndLanguages> createState() => _CountriesAndLanguagesState();
}

class _CountriesAndLanguagesState extends State<CountriesAndLanguages> {
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

  Widget _getSelectedWidget<V extends num>() {
    late List<MapEntry<String, num>> sortedEntries;
    late bool isMostWatched;

    if (selectedWidget == 'Most Watched') {
      sortedEntries = widget.count.entries.toList();
      isMostWatched = true;
    } else {
      sortedEntries = widget.rating.entries.toList();
      isMostWatched = false;
    }

    Widget limited = Text(
      'Only ${widget.isCountry ? 'countries' : 'languages'} with at least three rated films are included.',
      style: TextStyle(color: Color.fromARGB(255, 153, 153, 153)),
      overflow: TextOverflow.ellipsis,
    );

    var firstTenEntries = sortedEntries.take(10);
    Map<String, num> firstTenMap = Map.fromEntries(firstTenEntries);
    if (firstTenMap.isEmpty)
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [limited],
      );

    num? max = firstTenMap[firstTenMap.keys.toList()[0]];

    List<Widget> countries = firstTenMap.entries.map((key) {
      return Container(
        child: Card<V>(
            entry: key,
            max: max!,
            isMostWatched: isMostWatched,
            isCountry: widget.isCountry),
      );
    }).toList();

    if (!isMostWatched) {
      countries.insert(
          0,
          Container(
            child: Padding(padding: EdgeInsets.all(4.0), child: limited),
          ));
    }

    return Column(children: countries);
  }
}

class Card<V extends num> extends StatelessWidget {
  final MapEntry<String, num> entry;
  final num max;
  final bool isMostWatched;
  final bool isCountry;

  const Card(
      {super.key,
      required this.entry,
      required this.max,
      required this.isMostWatched,
      required this.isCountry});

  @override
  Widget build(BuildContext context) {
    int fixed = 2;
    Color color = Colors.green;

    if (isMostWatched) {
      fixed = 0;
      color = Colors.orange;
    }
    var theme = Theme.of(context);
    late String code;
    late String link;
    late Widget flag;

    String key = entry.key.toLowerCase();
    bool foundFlag = false;

    if (Constants.flagImageLinks.containsKey(key)) {
      flag = Image.network(
        Constants.flagImageLinks[key] ?? 'us',
        width: 30,
        height: 20,
      );

      foundFlag = true;
    }

    if (isCountry) {
      link =
          'https://letterboxd.com/films/country/${Converter().convertFromCamelCaseToLinkPrefix(entry.key)}';
      if (!foundFlag) {
        code = Constants.countryCodes[entry.key.toLowerCase()] ?? 'us';
        flag = CountryFlag.fromCountryCode(
          code,
          width: 30,
          height: 20,
        );
      }
    } else {
      if (!foundFlag) {
        code = Constants.languageCodes[entry.key.toLowerCase()] ?? 'uk';
        flag = CountryFlag.fromCountryCode(
          code,
          width: 30,
          height: 20,
        );
      }
      link =
          'https://letterboxd.com/films/language/${Converter().convertFromCamelCaseToLinkPrefix(entry.key)}';
    }

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.90,
      height: MediaQuery.of(context).size.height * 0.065,
      child: Link(
        url: link,
        hoverConfig: HoverConfig(
            hoverColor: Colors.transparent, translationYOnHover: -2),
        child: Row(
          children: [
            const SizedBox(width: 4),
            flag,
            const SizedBox(width: 12),
            SizedBox(
              width: MediaQuery.of(context).size.width *
                  0.18, // Adjust this value as needed
              child: Text(
                entry.key,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: Colors.white,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Container(
              height: 20,
              width:
                  MediaQuery.of(context).size.width * 0.6 * (entry.value / max),
              color: color,
            ),
            const SizedBox(width: 8),
            Text(
              entry.value.toStringAsFixed(fixed),
              style: theme.textTheme.bodyLarge?.copyWith(
                color: Colors.white,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
