import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:letterboxd/Models/MovieDetails.dart';
import 'package:letterboxd/Models/Person.dart';

class MovieApi {
  final String API_KEY = '329f9554661d8ec74f3940e9648b4a69';
  final String baseUrl = 'https://api.themoviedb.org/3';

  Future<PosterUrlAndId> getMoviePoster(String movieName, int year) async {
    var url = Uri.parse(
        '$baseUrl/search/movie?api_key=$API_KEY&query=$movieName&year=$year');

    var response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final results = data['results'];
      if (results.isNotEmpty) {
        final posterPath = results[0]['poster_path'];
        final movieId = results[0]['id'];

        print('MovieName: $movieName, PosterPath: $posterPath Id: movieId');

        return PosterUrlAndId(
            'https://image.tmdb.org/t/p/w500$posterPath', movieId);
      } else {
        url = Uri.parse(
            '$baseUrl/search/tv?api_key=$API_KEY&query=$movieName&year=$year');
        response = await http.get(url);
        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          final results = data['results'];
          if (results.isNotEmpty) {
            final posterPath = results[0]['poster_path'];
            final movieId = results[0]['id'];

            print(
                'MovieName: $movieName, PosterPath: $posterPath Id: $movieId');

            return PosterUrlAndId(
                'https://image.tmdb.org/t/p/w500$posterPath', movieId);
          } else if (movieName.contains(':')) {
            String movieNameWithoutEpisode =
                movieName.substring(0, movieName.indexOf(':'));
            url = Uri.parse(
                '$baseUrl/search/tv?api_key=$API_KEY&query=$movieNameWithoutEpisode');
            response = await http.get(url);
            if (response.statusCode == 200) {
              final data = json.decode(response.body);
              final results = data['results'];
              if (results.isNotEmpty) {
                final posterPath = results[0]['poster_path'];
                final movieId = results[0]['id'];

                print(
                    'MovieName: $movieName, PosterPath: $posterPath Id: $movieId');

                return PosterUrlAndId(
                    'https://image.tmdb.org/t/p/w500$posterPath', movieId);
              }
            }
          }
        }
      }
    } else {
      print('Failed to load poster');
    }
    return PosterUrlAndId('', -1);
  }

  Future<MovieDetails> getMovieDetails(int id) async {
    // Step 2: Fetch the cast using the movie ID
    final creditsUrl = Uri.parse('$baseUrl/movie/$id/credits?api_key=$API_KEY');
    final creditsResponse = await http.get(creditsUrl);

    if (creditsResponse.statusCode == 200) {
      final creditsData = json.decode(creditsResponse.body);
      final castList = creditsData['cast'];

      final detailsResponse = await http.get(
        Uri.parse('$baseUrl/movie/$id?api_key=$API_KEY'),
      );

      final movieDetails = jsonDecode(detailsResponse.body);

      final int length = movieDetails['runtime'];

      // final List genres = movieDetails['genres'];
      // List<String> genreNames =
      //     genres.map<String>((genre) => genre['name'] as String).toList();

      List<Person> cast = castList.map<Person>((castData) {
        final profilePath = castData['profile_path'];
        return Person(
            castData['name'],
            profilePath != null
                ? 'https://image.tmdb.org/t/p/w500$profilePath'
                : '',
            false);
      }).toList();

      final crew = creditsData['crew'] as List;
      final directorsInfo =
          crew.where((person) => person['job'] == 'Director').toList();

      List<Person> directors = directorsInfo.map<Person>((director) {
        final String directorName = director['name'];
        final String? profilePath = director['profile_path'];
        final String directorImageUrl = profilePath != null
            ? 'https://image.tmdb.org/t/p/w500$profilePath'
            : ''; // Return empty string if no image

        return Person(directorName, directorImageUrl, true);
      }).toList();

      return MovieDetails(length, cast, directors);
    }
    return MovieDetails(0, [], []);
  }
}

class PosterUrlAndId {
  late String? posterUrl;
  late int id;

  PosterUrlAndId(String? posterUrl, int id) {
    this.posterUrl = posterUrl;
    this.id = id;
  }
}
