class RatedMovie {
  late String name;
  late String movieLink;
  late String imgLink;
  late double rating;

  RatedMovie(String name, String link, String imgLink, double rating) {
    this.name = name;
    this.movieLink = link;
    this.imgLink = imgLink;
    this.rating = rating;
  }

  void setName(String name) {
    this.name = name;
  }

  void setImgLink(String imageLink) {
    this.imgLink = imageLink;
  }

  @override
  String toString() {
    return 'Name: $name, Movie Link: $movieLink, Img Link: $imgLink, Rating: $rating';
  }
}
