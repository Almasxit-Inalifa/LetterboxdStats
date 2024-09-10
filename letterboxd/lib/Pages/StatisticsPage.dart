import 'package:flutter/material.dart';
import 'package:letterboxd/Models/Statistics.dart';
import 'package:letterboxd/Pages/Widgets/CountriesAndLanguages.dart.dart';
import 'package:letterboxd/Pages/Widgets/Decades.dart';
import 'package:letterboxd/Pages/Widgets/People.dart';
import 'package:letterboxd/Pages/Widgets/Genres.dart';
import 'package:letterboxd/Pages/Widgets/MyAppBar.dart';
import 'package:letterboxd/Pages/Widgets/Themes.dart';
import 'package:letterboxd/Pages/Widgets/TopStats.dart';
import 'package:letterboxd/Pages/Widgets/Years.dart';
import 'package:letterboxd/Pages/Widgets/enterUsername.dart';

class StatisticsPage extends StatefulWidget {
  final Statistics data;
  final int index;
  final String username;

  const StatisticsPage(
      {super.key,
      required this.data,
      required this.index,
      required this.username});

  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  late int selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    void onTapSelected(int index) {
      setState(() {
        selectedIndex = index;
      });
    }

    final List<Widget> stats = [
      EnterUsername(),
      Genres(
          genreCount: widget.data.genreCount,
          genreRating: widget.data.genreRating,
          username: widget.username),
      Themes(
          themeCount: widget.data.themeCount,
          themeRating: widget.data.themeRating),
      Years(
          yearCount: widget.data.yearCount,
          yearRating: widget.data.yearRating,
          username: widget.username),
      Decades(decades: widget.data.decades),
      People(
          peopleCount: widget.data.directorCount,
          peopleRating: widget.data.directorRating,
          isDirector: true),
      People(
          peopleCount: widget.data.actorCount,
          peopleRating: widget.data.actorRating,
          isDirector: false),
      CountriesAndLanguages(
          count: widget.data.countryCount,
          rating: widget.data.countryRating,
          isCountry: true),
      CountriesAndLanguages(
          count: widget.data.languageCount,
          rating: widget.data.languageRating,
          isCountry: false)
    ];

    String appBarType = 'logo';
    if (selectedIndex > 0) appBarType = 'stats';

    return Scaffold(
      appBar: MyAppBar(
        type: appBarType,
        onTap: onTapSelected,
        selectedIndex: selectedIndex,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (selectedIndex > 0)
                Topstats(data: widget.data, username: widget.username),
              stats[selectedIndex]
            ],
          ),
        ),
      ),
    );
  }
}
