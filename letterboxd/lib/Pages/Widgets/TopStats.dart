import 'package:flutter/material.dart';
import 'package:letterboxd/Models/Statistics.dart';
import 'package:letterboxd/Pages/Widgets/Link.dart';

class Topstats extends StatelessWidget {
  final Statistics data;
  final String username;

  const Topstats({super.key, required this.data, required this.username});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    List<String> stats = ['HOURS', 'DIRECTORS', 'COUNTRIES', 'LANGUAGES'];
    List<int> nums = [
      data.hours,
      data.directorCount.length,
      data.countryCount.length,
      data.languageCount.length
    ];

    List<Widget> titles = stats.map((title) {
      return Column(
        children: [
          Text(
            nums[stats.indexOf(title)].toString(),
            style: theme.textTheme.bodyLarge?.copyWith(
              color: Colors.white,
            ),
          ),
          Text(
            title,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: Colors.white,
            ),
          ),
        ],
      );
    }).toList();

    titles.insert(
        0,
        Column(
          children: [
            Text(
              data.moviesCount.toString(),
              style: theme.textTheme.bodyLarge?.copyWith(
                color: Colors.white,
              ),
            ),
            Link(
              url: 'https://letterboxd.com/$username/films/',
              hoverConfig: HoverConfig(translationYOnHover: -2),
              child: Text(
                'FILMS',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ));

    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        children: [
          Title(
            color: Colors.white,
            child: const Text(
              'A Life in Film',
              style: TextStyle(
                fontSize: 34,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Wrap(spacing: 100, alignment: WrapAlignment.center, children: titles),
        ],
      ),
    );
  }
}
