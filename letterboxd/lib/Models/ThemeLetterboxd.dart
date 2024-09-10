class ThemeLetterboxd {
  late String name;
  late String link;

  ThemeLetterboxd(String name, String link) {
    this.name = name;
    this.link = link;
  }

  // @override
  // int compareTo(other) {
  //   return name.compareTo(other.name);
  // }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ThemeLetterboxd && other.name == name;
  }

  @override
  int get hashCode => name.hashCode;
}
