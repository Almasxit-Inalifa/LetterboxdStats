import 'package:letterboxd/Models/Person.dart';
import 'package:letterboxd/Models/RatedMovie.dart';
import 'package:letterboxd/Models/Statistics.dart';
import 'package:letterboxd/Models/ThemeLetterboxd.dart';

class Sorting {
  Statistics sortStatistics(
      Statistics stats,
      Map<String, int> genreRated,
      Map<ThemeLetterboxd, int> themeRated,
      Map<Person, int> directorRated,
      Map<Person, int> actorRated,
      Map<String, int> countryRated,
      Map<String, int> languageRated) {
    return Statistics(
        stats.genreCount,
        sortDesc(removeLessThanThreeAndGetAvg(genreRated, stats.genreRating)),
        sortDesc(stats.themeCount),
        sortDesc(removeLessThanThreeAndGetAvg(themeRated, stats.themeRating)),
        sortDesc(stats.directorCount),
        sortDesc(
            removeLessThanThreeAndGetAvg(directorRated, stats.directorRating)),
        sortDesc(stats.actorCount),
        sortDesc(removeLessThanThreeAndGetAvg(actorRated, stats.actorRating)),
        sortDesc(stats.countryCount),
        sortDesc(
            removeLessThanThreeAndGetAvg(countryRated, stats.countryRating)),
        sortDesc(stats.languageCount),
        sortDesc(
            removeLessThanThreeAndGetAvg(languageRated, stats.languageRating)),
        sortAscByYear(stats.yearCount),
        sortAscByYear(getAvg(stats.yearCount, stats.yearRating)),
        sortDescRating(stats.decades),
        stats.moviesCount,
        stats.hours);
  }

  Map<int, List<RatedMovie>> sortDescRating(
      Map<int, List<RatedMovie>> decades) {
    List<int> sortedKeys = decades.keys.toList()
      ..sort((a, b) => b.compareTo(a));

    Map<int, List<RatedMovie>> sortedDecades = {};

    for (var decade in sortedKeys) {
      List<RatedMovie> movies = decades[decade]!;

      movies.sort((a, b) => b.rating.compareTo(a.rating));
      sortedDecades[decade] = movies;
    }

    return sortedDecades;
  }

  Map<K, V> sortDesc<K, V extends Comparable<dynamic>>(Map<K, V> map) {
    return Map.fromEntries(
      map.entries.toList()..sort((a, b) => b.value.compareTo(a.value)),
    );
  }

  Map<K, V> sortAscByYear<K extends Comparable, V>(Map<K?, V> map) {
    return Map.fromEntries(
      map.entries
          .where((e) => e.key != null) // Filter out entries with null keys
          .map((e) => MapEntry(e.key!, e.value)) // Map to non-nullable entries
          .toList()
        ..sort((a, b) => a.key.compareTo(b.key)),
    );
  }

  Map<K, V> getAvg<K, V extends Comparable<dynamic>>(
      Map<K, int> counts, Map<K, V> ratings) {
    ratings.forEach((key, sum) {
      int? count = counts[key];

      if (count == null || count == 0) ratings.remove(key);

      if (sum is num) {
        V newSum = (sum / count!) as V; // Cast the result back to `V`
        ratings[key] = newSum;
      }
    });

    return ratings;
  }

  Map<K, V> removeLessThanThreeAndGetAvg<K, V extends Comparable<dynamic>>(
      Map<K, int> counts, Map<K, V> ratings) {
    List<K> toRemove = [];

    ratings.forEach((key, sum) {
      int? count = counts[key];

      if (count == null || count < 3) {
        toRemove.add(key);
      } else {
        // Ensure `sum` can be divided by `count`, handle type conversion
        if (sum is num) {
          V newSum = (sum / count) as V; // Cast the result back to `V`
          ratings[key] = newSum;
        } else {
          // Handle cases where `sum` is not a numeric type
          // You might want to log an error or handle it differently
          throw ArgumentError('Values in ratings map are not numeric.');
        }
      }
    });

    for (var key in toRemove) {
      ratings.remove(key);
    }

    return ratings;
  }
}
