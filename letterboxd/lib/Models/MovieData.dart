import 'package:letterboxd/Models/CountriesAndLanguages.dart';
import 'package:letterboxd/Models/Person.dart';
import 'package:letterboxd/Models/GenresAndThemes.dart';
import 'package:letterboxd/Models/RatedMovie.dart';

class Moviedata {
  late RatedMovie movie;
  late GenresAndThemes genresAndThemes;
  late CountriesAndLanguages countriesAndLanguages;
  late List<Person> directors;
  late List<Person> actors;
  late int year;
  int minutes = 0;

  Moviedata(
      RatedMovie movie,
      GenresAndThemes genresAndThemes,
      CountriesAndLanguages countriesAndLanguages,
      List<Person> directors,
      List<Person> actors,
      int year,
      int minutes) {
    this.movie = movie;
    this.genresAndThemes = genresAndThemes;
    this.countriesAndLanguages = countriesAndLanguages;
    this.directors = directors;
    this.actors = actors;
    this.year = year;
    this.minutes = minutes;
  }
}
