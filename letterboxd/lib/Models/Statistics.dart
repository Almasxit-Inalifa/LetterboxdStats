import 'package:letterboxd/Models/Person.dart';
import 'package:letterboxd/Models/RatedMovie.dart';
import 'package:letterboxd/Models/ThemeLetterboxd.dart';

class Statistics {
  late RatedMovie movie;
  late Map<String, int> genreCount;
  late Map<String, double> genreRating;
  late Map<ThemeLetterboxd, int> themeCount;
  late Map<ThemeLetterboxd, double> themeRating;
  late Map<Person, int> directorCount;
  late Map<Person, double> directorRating;
  late Map<Person, int> actorCount;
  late Map<Person, double> actorRating;
  late Map<String, int> countryCount;
  late Map<String, double> countryRating;
  late Map<String, int> languageCount;
  late Map<String, double> languageRating;
  late Map<int, int> yearCount;
  late Map<int, double> yearRating;
  late Map<int, List<RatedMovie>> decades;
  int moviesCount = 0;
  int hours = 0;

  Statistics(
      Map<String, int> genreCount,
      Map<String, double> genreRating,
      Map<ThemeLetterboxd, int> themeCount,
      Map<ThemeLetterboxd, double> themeRating,
      Map<Person, int> directorCount,
      Map<Person, double> directorRating,
      Map<Person, int> actorCount,
      Map<Person, double> actorRating,
      Map<String, int> countryCount,
      Map<String, double> countryRating,
      Map<String, int> languageCount,
      Map<String, double> languageRating,
      Map<int, int> yearCount,
      Map<int, double> yearRating,
      Map<int, List<RatedMovie>> decades,
      int moviesCount,
      int hours) {
    this.genreCount = genreCount;
    this.genreRating = genreRating;
    this.themeCount = themeCount;
    this.themeRating = themeRating;
    this.directorCount = directorCount;
    this.directorRating = directorRating;
    this.actorCount = actorCount;
    this.actorRating = actorRating;
    this.countryCount = countryCount;
    this.countryRating = countryRating;
    this.languageCount = languageCount;
    this.languageRating = languageRating;
    this.yearCount = yearCount;
    this.yearRating = yearRating;
    this.decades = decades;
    this.moviesCount = moviesCount;
    this.hours = hours;
  }

  @override
  String toString() {
    return '$genreCount\n$genreRating\n$themeCount\n$themeRating\n$directorCount\n$directorRating\n$actorCount\n$actorRating\n$countryCount\n$countryRating\n$languageCount\n$languageRating\n$yearCount\n$yearRating\n$decades\n[Movie Count: $moviesCount]\n[Hours: $hours]';
  }
}
