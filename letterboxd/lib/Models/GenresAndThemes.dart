import 'package:letterboxd/Models/ThemeLetterboxd.dart';

class GenresAndThemes {
  late List<String> genres;
  late List<ThemeLetterboxd> themes;

  GenresAndThemes(List<String> genres, List<ThemeLetterboxd> themes) {
    this.genres = genres;
    this.themes = themes;
  }
}
