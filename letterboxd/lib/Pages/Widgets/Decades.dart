import 'dart:math';
import 'package:flutter/material.dart';
import 'package:letterboxd/Models/RatedMovie.dart';
import 'package:letterboxd/Pages/Widgets/Link.dart';

class Decades extends StatelessWidget {
  final Map<int, List<RatedMovie>> decades;

  const Decades({super.key, required this.decades});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    List<Widget> decadeRows = decades.entries.map((entry) {
      int decade = entry.key;
      List<RatedMovie> movies = entry.value;
      if (movies.isEmpty) return Row();

      List<RatedMovie> firstTen = movies.sublist(0, min(10, movies.length));
      print(firstTen.toString());

      List<RatedMovie> secondTen = [];
      if (movies.length > 10) {
        secondTen = movies.sublist(10, min(20, movies.length));
      }

      double avgRating =
          movies.fold(0.0, (sum, movie) => sum + movie.rating) / movies.length;
      String avg = avgRating.toStringAsFixed(2);

      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${decade}s',
                          style: theme.textTheme.bodyLarge?.copyWith(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '★ Average: $avg',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    )),
                Column(children: [
                  GetTenMovies(movies: firstTen),
                  if (secondTen.isNotEmpty) GetTenMovies(movies: secondTen)
                ])
              ],
            ),
          ),
        ),
      );
    }).toList();

    return Column(children: decadeRows);
  }
}

class GetTenMovies extends StatelessWidget {
  final List<RatedMovie> movies;

  const GetTenMovies({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    List<Widget> movieRow = movies.map((movie) {
      double width = MediaQuery.of(context).size.width * 0.8 / 11;
      double height = width * 1.5;

      Widget poster = Stack(
        children: [
          Image.network(
            //'https://i.pinimg.com/474x/50/86/1c/50861ccde3632eb03c58d6ab085564f3.jpg',
            'https://static.wixstatic.com/media/b5a3bf_5357f8f2e9304bb6921e6600be8c8c31~mv2.jpg/v1/fill/w_553,h_866,al_c,q_85,enc_auto/b5a3bf_5357f8f2e9304bb6921e6600be8c8c31~mv2.jpg',
            width: width,
            height: height,
            fit: BoxFit.cover,
          ),
          SizedBox(
              width: width,
              height: height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    movie.name,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      //overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              )),
        ],
      );

      if (movie.imgLink.isNotEmpty &&
          movie.name.isNotEmpty &&
          !movie.imgLink.endsWith('null')) {
        poster = Image.network(
          movie.imgLink,
          width: width,
          height: height,
          fit: BoxFit.cover,
        );
      }

      String name = movie.name;
      String link = movie.movieLink;
      String rating = movie.rating.toStringAsFixed(2);

      return Padding(
        padding: const EdgeInsets.all(3.0),
        child: Tooltip(
            message:
                '$name\n$link\n${(rating == '0.00') ? 'No Rating' : rating}',
            child: Link(
              url: movie.movieLink,
              hoverConfig: HoverConfig(
                hoverColor: Colors.blue[100],
                elevationOnHover: 12,
                translationYOnHover: -6,
              ),
              child: poster,
            )),
      );
    }).toList();

    return Row(children: movieRow);
  }
}
