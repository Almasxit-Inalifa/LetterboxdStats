import 'package:flutter/material.dart';
import 'package:letterboxd/Models/RatedMovie.dart';
import 'package:letterboxd/Models/Statistics.dart';
import 'package:letterboxd/Pages/StatisticsPage.dart';
import 'package:letterboxd/Pages/Widgets/EnterUsername.dart';
import 'package:letterboxd/Pages/Widgets/MyAppBar.dart';
import '../WebScraper.dart';

class DisplayPage extends StatefulWidget {
  final String username;

  DisplayPage({Key? key, required this.username}) : super(key: key);

  @override
  _DisplayPageState createState() => _DisplayPageState();
}

class _DisplayPageState extends State<DisplayPage> {
  Webscraper scraper = Webscraper();
  int totalLinks = -2;
  int alreadyDownloaded = 0;
  late Future<Statistics?> _statisticsFuture;

  @override
  void initState() {
    super.initState();
    _statisticsFuture = _getStatistics();
  }

  Future<Statistics?> _getStatistics() async {
    int totalMoviesNum = await scraper.getSeenMoviesNum(widget.username);
    print('TOTAL NUMBER OF MOVIES: $totalMoviesNum');
    setState(() {
      totalLinks = totalMoviesNum;
    });

    if (totalMoviesNum > 0) {
      List<RatedMovie> movieLinks = await scraper
          .fetchSeenMovies('https://letterboxd.com/${widget.username}/films/');

      // Use a Future to handle progress updates
      final statisticsFuture = scraper.getStatistcis(movieLinks, () {
        setState(() {
          alreadyDownloaded++;
        });
      });

      // Wait for the statistics future to complete
      final statistics = await statisticsFuture;

      return statistics;
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    int selectedIndex = 1;

    void onTapSelected(int index) {
      setState(() {
        selectedIndex = index;
      });

      print('SELECTED INDEX IS $index');
    }

    late Widget displayWidget;

    if (totalLinks == -1) {
      displayWidget = Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            EnterUsername(),
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Text(
                'Invalid username. Please, try again.',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: Colors.grey, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      );
    } else if (totalLinks == 0) {
      displayWidget = Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            EnterUsername(),
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Text(
                'This user has not seen any movies.',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: Colors.grey, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      );
    } else {
      displayWidget = FutureBuilder<Statistics?>(
        future: _statisticsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show linear progress bar when loading
            return Center(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.8,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: LinearProgressIndicator(
                        value: totalLinks > 0
                            ? alreadyDownloaded / totalLinks
                            : null, // Indeterminate if no totalLinks known
                        minHeight: 5,
                        backgroundColor: Colors.grey[300],
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Theme.of(context).primaryColor),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Loading statistics...',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.grey,
                          ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Approximate time = (Number of films seen) x 2.5 seconds',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.grey,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Apologies for the delay.',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.grey,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final data = snapshot.data!;

            void showStats(int index) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StatisticsPage(
                      data: data, index: index + 1, username: widget.username),
                ),
              );
            }

            final List<String> buttonNames = [
              'Genres',
              'Themes',
              'Years',
              'Decades',
              'Directors',
              'Actors',
              'Countries',
              'Languages'
            ];
            final List<Widget> buttons = buttonNames.map((buttonName) {
              return ElevatedButton(
                onPressed: () => showStats(buttonNames.indexOf(buttonName)),
                child: Text(buttonName),
              );
            }).toList();

            // Once loading is done, display the buttons
            return Center(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.8,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: buttons,
                ),
              ),
            );
          } else {
            return const Center(child: Text('No data available.'));
          }
        },
      );
    }

    return Scaffold(
      appBar: MyAppBar(
        type: 'logo',
        onTap: onTapSelected,
        selectedIndex: selectedIndex,
      ),
      body: SingleChildScrollView(
        child: displayWidget,
      ),
    );
  }
}
