class Person implements Comparable {
  late String name;
  late String imageLink;
  late bool isDirector;
  late String personLink;

  Person(String name, String imageLink, bool isDirector) {
    this.name = name;
    this.imageLink = imageLink;
    this.personLink = convertToPrefix(name, isDirector);
  }

  @override
  String toString() {
    return 'Name: $name, ImgLink: $imageLink';
  }

  @override
  int compareTo(other) {
    return name.compareTo(other.name);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Person && other.name == name;
  }

  @override
  int get hashCode => name.hashCode;

  String convertToPrefix(String name, bool isDirector) {
    return 'https://letterboxd.com/${isDirector ? 'director' : 'actor'}/${name.replaceAll(' ', '-').replaceAll('.', '').replaceAll('é', 'e').toLowerCase()}';
  }
}
