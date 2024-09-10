import 'package:letterboxd/Models/Person.dart';

class MovieDetails {
  late int length;
  //late List<String> genres;
  late List<Person> cast;
  late List<Person> directors;

  MovieDetails(int length, List<Person> cast, List<Person> directors) {
    this.length = length;
    //this.genres = genres;
    this.cast = cast;
    this.directors = directors;
  }

  @override
  String toString() {
    return 'Length: $length, Cast: $cast, Directors: $directors';
  }
}
