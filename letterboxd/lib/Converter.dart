class Converter {
  double convertStarsToNumber(String rating) {
    double stars = 0.0;
    stars += rating.split('★').length - 1;
    if (rating.contains('½')) {
      stars += 0.5;
    }
    return stars;
  }

  String convertFromCamelCaseToLinkPrefix(String str) {
    return str.replaceAll(' ', '-').toLowerCase();
  }

  String convertCountryToCamelCase(String country) {
    if (['Usa', 'Uk', 'Uae', 'Ussr'].contains(country))
      return country.toUpperCase();

    return convertToCamelCase(country);
  }

  String convertToCamelCase(String country) {
    while (country.contains('-')) {
      int hyphenInd = country.indexOf('-');
      String letter =
          country.substring(hyphenInd + 1, hyphenInd + 2).toUpperCase();
      country =
          '${country.substring(0, hyphenInd)} $letter${country.substring(hyphenInd + 2)}';
    }

    return country;
  }
}
