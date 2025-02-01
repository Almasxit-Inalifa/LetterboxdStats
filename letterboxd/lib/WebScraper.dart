import 'dart:math';
import 'dart:ui';

import 'package:html/dom.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'package:letterboxd/Models/CountriesAndLanguages.dart';
import 'package:letterboxd/Models/MovieDetails.dart';
import 'package:letterboxd/Models/Person.dart';
import 'package:letterboxd/Models/GenresAndThemes.dart';
import 'package:letterboxd/Models/RatedMovie.dart';
import 'package:letterboxd/Models/ThemeLetterboxd.dart';
import 'package:letterboxd/MovieApi.dart';
import 'package:letterboxd/Sorting.dart';
import 'package:letterboxd/converter.dart';
import 'Constants.dart';
import 'Models/MovieData.dart';
import 'Models/Statistics.dart';

class Webscraper {
  Future<int> getSeenMoviesNum(String username) async {
    String profileLink = 'https://letterboxd.com/$username/';

    print(profileLink);

    final response = await http.get(Uri.parse(profileLink));

    if (response.statusCode == 200) {
      final document = parse(response.body);

      //print(document.outerHtml);
      String? numString = document.querySelector('.value')?.text;
      numString ??= '';
      numString = numString.replaceAll(',', '');

      print('NUMSTRING: $numString');

      if (int.tryParse(numString) != null) {
        return int.parse(numString);
      } else {
        return 0;
      }
    }
    return -1;
  }

  Future<Moviedata> fetchMovieData(
      RatedMovie movie, VoidCallback onDownloaded) async {
    final response = await http.get(Uri.parse(movie.movieLink));

    if (response.statusCode == 200) {
      final document = parse(response.body);

      int year = getYear(document);
      String title = getTitle(document);

      PosterUrlAndId posterUrlAndId =
          await MovieApi().getMoviePoster(title, year);

      movie.setImgLink(posterUrlAndId.posterUrl ??= '');
      movie.setName(title);

      MovieDetails movieDetails =
          await MovieApi().getMovieDetails(posterUrlAndId.id);

      print('Movie Details $movieDetails');

      GenresAndThemes genresAndThemes = getGenresAndThemes(document);
      CountriesAndLanguages countriesAndLanguages =
          getCountriesAndLanguages(document);

      // Call the callback to update progress
      onDownloaded();

      return Moviedata(movie, genresAndThemes, countriesAndLanguages,
          movieDetails.directors, movieDetails.cast, year, movieDetails.length);
    } else {
      // Call the callback to update progress even if the request fails
      onDownloaded();

      return Moviedata(movie, GenresAndThemes([], []),
          CountriesAndLanguages([], []), [], [], 0, 0);
    }
  }

  Future<List<RatedMovie>> fetchSeenMovies(String url) async {
    List<RatedMovie> movies = [];
    var pageNum = 1;
    bool morePages = true;

    Future<void> fetchPage(int pageNum) async {
      var curPageUrl = '${url}page/$pageNum/';
      try {
        final response = await http.get(Uri.parse(curPageUrl));

        if (response.statusCode == 200) {
          final document = parse(response.body);
          final posterContainers =
              document.querySelectorAll('li.poster-container');

          if (posterContainers.isNotEmpty) {
            for (final element in posterContainers) {
              // Extract the data-target-link attribute
              String? link = element
                  .querySelector('div[data-target-link]')
                  ?.attributes['data-target-link'];

              String? title = element
                      .querySelector('div[data-target-link]')
                      ?.attributes[
                  'data-film-slug']; // Retrieve the value of the data-film-name attribute

              print('Title: ${title!}');

              if (link != null && link.isNotEmpty) {
                String? rating =
                    element.querySelector('.poster-viewingdata .rating')?.text;
                print('Link: $link and rating $rating');

                rating ??= '';

                movies.add(RatedMovie('', 'https://letterboxd.com$link', '',
                    Converter().convertStarsToNumber(rating)));
              }
            }
            //morePages = false;
          } else {
            morePages = false;
          }
        } else {
          throw Exception('Failed to load movies');
        }
      } catch (e) {
        print('Error fetching page $pageNum: $e');
      }
    }

    Future<void> fetchPagesInParallel(int startPage, int endPage) async {
      List<Future<void>> futures = [];
      for (int i = startPage; i <= endPage; i++) {
        futures.add(fetchPage(i));
      }
      await Future.wait(futures);
    }

    const int batchSize = 5; // Number of pages to fetch in parallel
    while (morePages) {
      int startPage = pageNum;
      int endPage = pageNum + batchSize - 1;
      await fetchPagesInParallel(startPage, endPage);
      pageNum += batchSize;
    }

    return movies;
  }

  Future<Statistics> getStatistcis(
      List<RatedMovie> movieLinks, VoidCallback onDownloaded) async {
    Map<String, int> genresCount = {};
    Map<String, double> genresRating = {};

    Map<ThemeLetterboxd, int> themesCount = {};
    Map<ThemeLetterboxd, double> themesRating = {};

    Map<Person, int> directorsCount = {};
    Map<Person, double> directorsRating = {};

    Map<Person, int> actorsCount = {};
    Map<Person, double> actorsRating = {};

    Map<String, int> countriesCount = {};
    Map<String, double> countriesRating = {};

    Map<String, int> languageCount = {};
    Map<String, double> languageRating = {};

    Map<double, int> ratings = {};

    Map<int, int> yearsCount = {};
    Map<int, double> yearsRating = {};
    int totalMinutes = 0;

    Map<int, List<RatedMovie>> decades = {};

    Map<String, int> genreRated = {};
    Map<ThemeLetterboxd, int> themeRated = {};
    Map<Person, int> directorRated = {};
    Map<Person, int> actorRated = {};
    Map<String, int> countryRated = {};
    Map<String, int> languageRated = {};

    for (RatedMovie movie in movieLinks) {
      Moviedata curData = await fetchMovieData(movie, onDownloaded);
      int decade = curData.year - (curData.year % 10);

      ratings.update(movie.rating, (value) => value + 1, ifAbsent: () => 1);
      yearsCount.update(curData.year, (value) => value + 1, ifAbsent: () => 1);
      yearsRating.update(curData.year, (value) => value + movie.rating,
          ifAbsent: () => movie.rating);

      decades.update(decade, (value) {
        value.add(curData.movie);
        return value;
      }, ifAbsent: () {
        return [curData.movie];
      });

      for (String genre in curData.genresAndThemes.genres) {
        if (movie.rating > 0) {
          genreRated.update(genre, (value) => value + 1, ifAbsent: () => 1);
        }
        genresCount.update(genre, (value) => value + 1, ifAbsent: () => 1);
        genresRating.update(genre, (value) => value + movie.rating,
            ifAbsent: () => movie.rating);
      }

      for (ThemeLetterboxd theme in curData.genresAndThemes.themes) {
        if (movie.rating > 0) {
          themeRated.update(theme, (value) => value + 1, ifAbsent: () => 1);
        }

        themesCount.update(theme, (value) => value + 1, ifAbsent: () => 1);
        themesRating.update(theme, (value) => value + movie.rating,
            ifAbsent: () => movie.rating);
      }

      for (Person director in curData.directors) {
        if (movie.rating > 0) {
          directorRated.update(director, (value) => value + 1,
              ifAbsent: () => 1);
        }
        directorsCount.update(director, (value) => value + 1,
            ifAbsent: () => 1);

        directorsRating.update(director, (value) => value + movie.rating,
            ifAbsent: () => movie.rating);
      }

      for (Person actor in curData.actors) {
        if (movie.rating > 0) {
          actorRated.update(actor, (value) => value + 1, ifAbsent: () => 1);
        }
        actorsCount.update(actor, (value) => value + 1, ifAbsent: () => 1);

        actorsRating.update(actor, (value) => value + movie.rating,
            ifAbsent: () => movie.rating);
      }

      for (String country in curData.countriesAndLanguages.countries) {
        if (movie.rating > 0) {
          countryRated.update(country, (value) => value + 1, ifAbsent: () => 1);
        }
        countriesCount.update(country, (value) => value + 1, ifAbsent: () => 1);
        countriesRating.update(country, (value) => value + movie.rating,
            ifAbsent: () => movie.rating);
      }

      for (String language in curData.countriesAndLanguages.languages) {
        if (movie.rating > 0) {
          languageRated.update(language, (value) => value + 1,
              ifAbsent: () => 1);
        }
        languageCount.update(language, (value) => value + 1, ifAbsent: () => 1);
        languageRating.update(language, (value) => value + movie.rating,
            ifAbsent: () => movie.rating);
      }

      totalMinutes += curData.minutes;
    }

    Statistics result = Sorting().sortStatistics(
        Statistics(
            genresCount,
            genresRating,
            themesCount,
            themesRating,
            directorsCount,
            directorsRating,
            actorsCount,
            actorsRating,
            countriesCount,
            countriesRating,
            languageCount,
            languageRating,
            yearsCount,
            yearsRating,
            decades,
            movieLinks.length,
            totalMinutes ~/ 60),
        genreRated,
        themeRated,
        directorRated,
        actorRated,
        countryRated,
        languageRated);

    print('Statistics: $result.toString()');

    return result;
  }

  GenresAndThemes getGenresAndThemes(Document document) {
    final genreTab = document.querySelector('#tab-genres');

    if (genreTab == null) return GenresAndThemes([], []);
    final elements = genreTab.querySelectorAll('.text-slug');

    List<String> genres = elements
        .map((e) => e.text.trim())
        .where((genre) => Constants.GENRES.contains(genre))
        .toList();

    List<String> themeNames = elements
        .map((e) => e.text.trim())
        .where((theme) =>
            !Constants.GENRES.contains(theme) && !theme.startsWith('Show All'))
        .toList();

    List<String> themeLinks = elements
        .map((e) {
          String? href = e.attributes['href'];
          return href?.trim() ?? ''; // Trim the href if not null
        })
        .where((themeLink) => !themeLink.contains('genre'))
        .toList();

    themeLinks.removeLast;

    // print('Count: ${themeLinks.length}');
    // for (final theme in themeLinks) {
    //   print(theme);
    // }

    List<ThemeLetterboxd> themes = [];
    for (int i = 0; i < (min(themeNames.length, themeLinks.length)); i++) {
      themes.add(ThemeLetterboxd(themeNames[i], themeLinks[i]));
    }

    return GenresAndThemes(genres, themes);
  }

  CountriesAndLanguages getCountriesAndLanguages(Document document) {
    final detailsTab = document.querySelector("#tab-details");

    if (detailsTab == null) return CountriesAndLanguages([], []);
    final details = detailsTab.querySelectorAll('a');

    List<String> links = details.map((e) {
      String? href = e.attributes['href'];
      return href?.trim() ?? '';
    }).toList();

    List<String> countries = links
        .where((link) => (link.contains('country')))
        .map((link) => link.substring(link.indexOf('country') + 8))
        .map((countryWithSlash) =>
            countryWithSlash.substring(0, countryWithSlash.length - 1))
        .map((country) =>
            country.substring(0, 1).toUpperCase() +
            country.substring(1).toLowerCase())
        .map((country) => Converter().convertCountryToCamelCase(country))
        .toList();

    print(countries);

    List<String> languages = links
        .where((link) => (link.contains('language')))
        .map((link) => link.substring(link.indexOf('language') + 9))
        .map((languageWithSlash) =>
            languageWithSlash.substring(0, languageWithSlash.length - 1))
        .map((language) =>
            language.substring(0, 1).toUpperCase() +
            language.substring(1).toLowerCase())
        .map((country) => Converter().convertToCamelCase(country))
        .toList();

    // print('Count: ${countries.length}');
    // for (final country in countries) {
    //   print(country);
    // }

    // print('Count: ${languages.length}');
    // for (final language in languages) {
    //   print(language);
    // }

    return CountriesAndLanguages(countries, languages);
  }

  int getYear(Document document) {
    var yearElement = document
        .querySelector('.releaseyear a'); // Select <a> inside .releaseyear
    if (yearElement == null) {
      print("Year not found!");
      return 0;
    }

    String year = yearElement.text.trim();
    print('YEAR EXTRACTED: $year');

    return int.tryParse(year) ?? 0; // Ensure valid integer
  }

  String getTitle(Document document) {
    // Try extracting from .js-title
    Element? titleElement = document.querySelector('.js-title');
    if (titleElement != null && titleElement.text.trim().isNotEmpty) {
      // print("TITLE EXTRACTED FROM .js-title: ${titleElement.text.trim()}");
      return titleElement.text.trim();
    }

    // Fallback: Extract from <title>
    Element? pageTitle = document.querySelector('title');
    if (pageTitle != null && pageTitle.text.contains(" • Letterboxd")) {
      String extractedTitle = pageTitle.text.split(" • ").first.trim();

      // Remove any year (like "(2002)") or director name if present
      extractedTitle =
          extractedTitle.replaceAll(RegExp(r'\(\d{4}\).*'), '').trim();

      // print("TITLE EXTRACTED FROM <title>: $extractedTitle");
      return extractedTitle;
    }

    // print("TITLE NOT FOUND");
    return '';
  }
}
