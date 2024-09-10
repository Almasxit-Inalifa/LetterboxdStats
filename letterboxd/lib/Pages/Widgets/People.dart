import 'dart:math';
import 'package:flutter/material.dart';
import 'package:letterboxd/Models/Person.dart';
import 'package:letterboxd/Pages/Widgets/Link.dart';
import 'package:letterboxd/Pages/Widgets/DropDown.dart';

class People extends StatefulWidget {
  final Map<Person, int> peopleCount;
  final Map<Person, double> peopleRating;
  final bool isDirector;

  const People(
      {super.key,
      required this.peopleCount,
      required this.peopleRating,
      required this.isDirector});

  @override
  State<People> createState() => _PeopleState();
}

class _PeopleState extends State<People> {
  bool showAll = false;
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
    var theme = Theme.of(context);

    switch (selectedWidget) {
      case 'Most Watched':
        return _buildPeopleList(
            widget.peopleCount, (person) => person.toString(), theme, false);
      case 'Highest Rated':
        return _buildPeopleList(widget.peopleRating,
            (rating) => 'Average: ' + rating.toStringAsFixed(2), theme, true);
      default:
        return Container();
    }
  }

  Widget _buildPeopleList<T>(Map<Person, T> stats,
      String Function(T value) displayText, var theme, bool rating) {
    var sortedEntries = stats.entries.toList();
    var rowsToShow = showAll ? 4 : 2;

    int peopleNum = sortedEntries.length;

    var rowInfoList = [sortedEntries.take(5)];
    if (sortedEntries.length > 5)
      rowInfoList.add(sortedEntries.sublist(5, min(10, peopleNum)));
    if (sortedEntries.length > 10)
      rowInfoList.add(sortedEntries.sublist(10, min(15, peopleNum)));
    if (sortedEntries.length > 15)
      rowInfoList.add(sortedEntries.sublist(15, min(20, peopleNum)));

    List<Widget> rows = [];
    for (int i = 0; i < min(rowsToShow, rowInfoList.length); i++) {
      List<Widget> row = rowInfoList[i].map((personInfo) {
        return PersonCard(
          person: personInfo.key,
          displayText: displayText(personInfo.value),
        );
      }).toList();

      rows.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: row,
      ));
    }

    return Column(
      children: [
        if (rating)
          Padding(
            padding: const EdgeInsets.only(top: 4, bottom: 10),
            child: Text(
              'Only ${widget.isDirector ? 'directors' : 'actors'} with at least three rated films are included.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: const Color.fromARGB(255, 153, 153, 153),
              ),
            ),
          ),
        Column(
          children: rows,
        ),
        if (!showAll && sortedEntries.length > 10)
          TextButton(
            onPressed: () {
              setState(() {
                showAll = true;
              });
            },
            child: const Text('See More'),
          ),
      ],
    );
  }
}

class PersonCard extends StatelessWidget {
  final Person person;
  final String displayText;

  const PersonCard({
    super.key,
    required this.person,
    required this.displayText,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var minSize = min(
        MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);
    var size = minSize / 5;

    String picLink = person.imageLink.isNotEmpty
        ? person.imageLink
        : 'https://zeru.com/blog/wp-content/uploads/How-Do-You-Have-No-Profile-Picture-on-Facebook_25900';

    return Container(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Link(
                url: person.personLink,
                child: ClipOval(
                  child: Image.network(
                    picLink,
                    width: size,
                    height: size,
                    fit: BoxFit.cover,
                  ),
                ),
                hoverConfig: HoverConfig(
                  elevationOnHover: 0,
                  translationYOnHover: -5,
                ),
              ),
            ),
            Text(
              person.name,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.white,
              ),
            ),
            Text(
              displayText,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
