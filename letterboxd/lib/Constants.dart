import 'package:flutter/material.dart';

class Constants {
  static const List<String> GENRES = [
    'Action',
    'Adventure',
    'Animation',
    'Comedy',
    'Crime',
    'Documentary',
    'Drama',
    'Family',
    'Fantasy',
    'History',
    'Horror',
    'Music',
    'Mystery',
    'Romance',
    'Science Fiction',
    'Thriller',
    'TV Movie',
    'War',
    'Western'
  ];

  static const List<Color> COLORS = [
    Color.fromARGB(255, 0, 63, 92),
    Color.fromARGB(255, 121, 130, 185),
    Color.fromRGBO(34, 131, 169, 0.886),
    Colors.teal,
    Color.fromRGBO(59, 181, 106, 0.878),
    Color.fromARGB(255, 97, 202, 127),
    Colors.greenAccent,
    Color.fromARGB(255, 133, 252, 252),
    Color.fromARGB(255, 64, 188, 244),
    Color.fromARGB(255, 255, 241, 201),
    Color.fromARGB(255, 247, 183, 163),
    Color.fromARGB(255, 255, 133, 85),
    Color.fromARGB(255, 255, 100, 92),
    Colors.deepOrange,
    Color.fromARGB(255, 234, 95, 137),
    Colors.pink,
    Color.fromARGB(255, 155, 49, 146),
    Color.fromARGB(255, 87, 22, 126),
    Color.fromARGB(255, 43, 11, 63),
  ];

  static const Map<String, String> countryCodes = {
    "afghanistan": "af",
    "aland islands": "ax",
    "albania": "al",
    "algeria": "dz",
    "american samoa": "as",
    "andorra": "ad",
    "angola": "ao",
    "anguilla": "ai",
    "antarctica": "aq",
    "antigua and barbuda": "ag",
    "argentina": "ar",
    "armenia": "am",
    "aruba": "aw",
    "australia": "au",
    "austria": "at",
    "azerbaijan": "az",
    "bahamas": "bs",
    "bahrain": "bh",
    "bangladesh": "bd",
    "barbados": "bb",
    "belarus": "by",
    "belgium": "be",
    "belize": "bz",
    "benin": "bj",
    "bermuda": "bm",
    "bhutan": "bt",
    "bolivia": "bo",
    "bosnia and herzegovina": "ba",
    "bolivarian republic of venezuela": "ve",
    "botswana": "bw",
    "brazil": "br",
    "british indian ocean territory": "io",
    "brunei darussalam": "bn",
    "bulgaria": "bg",
    "burkina faso": "bf",
    "burundi": "bi",
    "cabo verde": "cv",
    "cambodia": "kh",
    "cameroon": "cm",
    "canada": "ca",
    "cayman islands": "ky",
    'czechia': 'cz',
    'czechoslovakia': 'cz',
    "central african republic": "cf",
    "chad": "td",
    "chile": "cl",
    "china": "cn",
    "christmas island": "cx",
    "cocos keeling islands": "cc",
    "colombia": "co",
    "comoros": "km",
    "congo": "cg",
    "democratic republic of congo": "cd",
    "congo (democratic republic of the)": "cd",
    "cook islands": "ck",
    "costa rica": "cr",
    "croatia": "hr",
    "cuba": "cu",
    "curaçao": "cw",
    "cyprus": "cy",
    "czech republic": "cz",
    "denmark": "dk",
    "djibouti": "dj",
    "dominica": "dm",
    "dominican republic": "do",
    "ecuador": "ec",
    "egypt": "eg",
    "el salvador": "sv",
    "equatorial guinea": "gq",
    "eritrea": "er",
    "estonia": "ee",
    "eswatini": "sz",
    "ethiopia": "et",
    "falkland islands": "fk",
    "malvinas": "fk",
    "faroe islands": "fo",
    "fiji": "fj",
    "finland": "fi",
    "france": "fr",
    "french guiana": "gf",
    "french polynesia": "pf",
    "french southern territories": "tf",
    "gabon": "ga",
    "gambia": "gm",
    "georgia": "ge",
    "germany": "de",
    "ghana": "gh",
    "gibraltar": "gi",
    "greece": "gr",
    "greenland": "gl",
    "grenada": "gd",
    "guadeloupe": "gp",
    "guam": "gu",
    "guatemala": "gt",
    "guernsey": "gg",
    "guinea": "gn",
    "guinea-bissau": "gw",
    "guyana": "gy",
    "haiti": "ht",
    "heard island and mcdonald islands": "hm",
    "holy see": "va",
    "honduras": "hn",
    "hong kong": "hk",
    "hungary": "hu",
    "iceland": "is",
    "india": "in",
    "indonesia": "id",
    "iran": "ir",
    "iraq": "iq",
    "ireland": "ie",
    "isle of man": "im",
    "israel": "il",
    "italy": "it",
    "jamaica": "jm",
    "japan": "jp",
    "jersey": "je",
    "jordan": "jo",
    "kazakhstan": "kz",
    "kenya": "ke",
    "kiribati": "ki",
    "north korea": "kp",
    "south korea": "kr",
    "kuwait": "kw",
    "kyrgyzstan": "kg",
    "lao peoples democratic republic": "la",
    "latvia": "lv",
    "lebanon": "lb",
    "lesotho": "ls",
    "liberia": "lr",
    "libya": "ly",
    "liechtenstein": "li",
    "lithuania": "lt",
    "luxembourg": "lu",
    "macao": "mo",
    "madagascar": "mg",
    "malawi": "mw",
    "malaysia": "my",
    "maldives": "mv",
    "mali": "ml",
    "malta": "mt",
    "marshall islands": "mh",
    "martinique": "mq",
    "mauritania": "mr",
    "mauritius": "mu",
    "mayotte": "yt",
    "mexico": "mx",
    "federated states of micronesia": "fm",
    "republic of moldova": "md",
    "monaco": "mc",
    "mongolia": "mn",
    "montenegro": "me",
    "montserrat": "ms",
    "morocco": "ma",
    "mozambique": "mz",
    "myanmar": "mm",
    "namibia": "na",
    "nauru": "nr",
    "nepal": "np",
    "netherlands": "nl",
    "new caledonia": "nc",
    "new zealand": "nz",
    "nicaragua": "ni",
    "niger": "ne",
    "nigeria": "ng",
    "niue": "nu",
    "norfolk island": "nf",
    "northern mariana islands": "mp",
    "norway": "no",
    "oman": "om",
    "pakistan": "pk",
    "palau": "pw",
    "state of palestine": "ps",
    "panama": "pa",
    "papua new guinea": "pg",
    "paraguay": "py",
    "peru": "pe",
    "philippines": "ph",
    "pitcairn": "pn",
    "poland": "pl",
    "portugal": "pt",
    "puerto rico": "pr",
    "qatar": "qa",
    "reunion": "re",
    "romania": "ro",
    "russian federation": "ru",
    "russia": "ru",
    "rwanda": "rw",
    "saint barthelemy": "bl",
    "saint helena ascension and tristan da cunha": "sh",
    "saint kitts and nevis": "kn",
    "saint lucia": "lc",
    "saint martin": "mf",
    "saint pierre and miquelon": "pm",
    "saint vincent and the grenadines": "vc",
    "samoa": "ws",
    "san marino": "sm",
    "sao tome and principe": "st",
    "saudi arabia": "sa",
    "senegal": "sn",
    "serbia": "rs",
    "seychelles": "sc",
    "sierra leone": "sl",
    "singapore": "sg",
    "sint maarten": "sx",
    "slovakia": "sk",
    "slovenia": "si",
    "solomon islands": "sb",
    "somalia": "so",
    "south africa": "za",
    "south georgia and the south sandwich islands": "gs",
    "south sudan": "ss",
    "spain": "es",
    "sri lanka": "lk",
    "sudan": "sd",
    "suriname": "sr",
    "svalbard and jan mayen": "sj",
    "sweden": "se",
    "switzerland": "ch",
    "syrian arab republic": "sy",
    "taiwan": "tw",
    "tajikistan": "tj",
    "united republic of tanzania": "tz",
    "thailand": "th",
    "timor-leste": "tl",
    "togo": "tg",
    "tokelau": "tk",
    "tonga": "to",
    "trinidad and tobago": "tt",
    "tunisia": "tn",
    "turkey": "tr",
    "turkmenistan": "tm",
    "turks and caicos islands": "tc",
    "tuvalu": "tv",
    "uganda": "ug",
    "ukraine": "ua",
    "united arab emirates": "ae",
    "united kingdom": "gb",
    "uk": "gb",
    "united states of america": "us",
    "united states minor outlying islands": "us",
    "us": "us",
    "uruguay": "uy",
    "uzbekistan": "uz",
    "vatican city": "va",
    "vanuatu": "vu",
    "venezuela": "ve",
    "vietnam": "vn",
    "british virgin islands": "vg",
    "us virgin islands": "vi",
    "wallis and futuna": "wf",
    "western sahara": "eh",
    "yemen": "ye",
    "zambia": "zm",
    "zimbabwe": "zw"
  };

  static const Map<String, String> flagImageLinks = {
    'ussr': 'https://thumbs.dreamstime.com/b/flag-soviet-union-6583007.jpg',
    'latin':
        'https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/20127d25-c622-47fe-9252-a6e48014395f/ddirscz-16c91fea-5bfb-4a7e-b822-bf153255e8e8.png/v1/fill/w_1248,h_640,q_70,strp/flag_of_latin_languages_by_politicalflags_ddirscz-pre.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7ImhlaWdodCI6Ijw9NjU3IiwicGF0aCI6IlwvZlwvMjAxMjdkMjUtYzYyMi00N2ZlLTkyNTItYTZlNDgwMTQzOTVmXC9kZGlyc2N6LTE2YzkxZmVhLTViZmItNGE3ZS1iODIyLWJmMTUzMjU1ZThlOC5wbmciLCJ3aWR0aCI6Ijw9MTI4MCJ9XV0sImF1ZCI6WyJ1cm46c2VydmljZTppbWFnZS5vcGVyYXRpb25zIl19.iGmtf3eCFx0weuX-s4GYZG5GmSmP7emQWpXD6nO385k',
    'yugoslavia':
        'https://upload.wikimedia.org/wikipedia/commons/thumb/6/61/Flag_of_Yugoslavia_%281946-1992%29.svg/1200px-Flag_of_Yugoslavia_%281946-1992%29.svg.png',
    'netherlands antilles':
        'https://upload.wikimedia.org/wikipedia/commons/thumb/e/eb/Flag_of_the_Netherlands_Antilles_%281959%E2%80%931986%29.svg/1200px-Flag_of_the_Netherlands_Antilles_%281959%E2%80%931986%29.svg.png',
    'east germany':
        'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a1/Flag_of_East_Germany.svg/640px-Flag_of_East_Germany.svg.png',
  };

  static const Map<String, String> languageCodes = {
    'english': 'GB', // United Kingdom
    'spanish': 'ES', // Spain
    'french': 'FR', // France
    'german': 'DE', // Germany
    'chinese': 'CN', // China
    'japanese': 'JP', // Japan
    'korean': 'KR', // South Korea
    'portuguese': 'PT', // Portugal
    'russian': 'RU', // Russia
    'arabic': 'SA', // Saudi Arabia
    'italian': 'IT', // Italy
    'dutch': 'NL', // Netherlands
    'swedish': 'SE', // Sweden
    'hindi': 'IN', // India
    'turkish': 'TR', // Turkey
    'polish': 'PL', // Poland
    'thai': 'TH', // Thailand
    'vietnamese': 'VN', // Vietnam
    'greek': 'GR', // Greece
    'greekmodern': 'GR', // Greece
    'hebrew': 'IL', // Israel
    'hungarian': 'HU', // Hungary
    'indonesian': 'ID', // Indonesia
    'malay': 'MY', // Malaysia
    'persian': 'IR', // Iran
    'persianfarsi': 'IR', // Iran
    'romanian': 'RO', // Romania
    'ukrainian': 'UA', // Ukraine
    'bulgarian': 'BG', // Bulgaria
    'danish': 'DK', // Denmark
    'finnish': 'FI', // Finland
    'norwegian': 'NO', // Norway
    'czech': 'CZ', // Czech Republic
    'slovak': 'SK', // Slovakia
    'serbian': 'RS', // Serbia
    'croatian': 'HR', // Croatia
    'bosnian': 'BA', // Bosnia and Herzegovina
    'slovenian': 'SI', // Slovenia
    'lithuanian': 'LT', // Lithuania
    'estonian': 'EE', // Estonia
    'latvian': 'LV', // Latvia
    'filipino': 'PH', // Philippines
    'bengali': 'BD', // Bangladesh
    'urdu': 'PK', // Pakistan
    'tamil': 'LK', // Sri Lanka
    'telugu': 'IN', // India (Telugu is spoken in India)
    'marathi': 'IN', // India (Marathi is spoken in India)
    'punjabi': 'PK', // Pakistan
    'swahili': 'KE', // Kenya
    'amharic': 'ET', // Ethiopia
    'afrikaans': 'ZA', // South Africa
    'irish': 'IE', // Ireland
    'scottish gaelic': 'GB', // United Kingdom
    'welsh': 'GB', // United Kingdom
    'icelandic': 'IS', // Iceland
    'georgian': 'GE', // Georgia
    'armenian': 'AM', // Armenia
    'mongolian': 'MN', // Mongolia
    'khmer': 'KH', // Cambodia
    'lao': 'LA', // Laos
    'burmese': 'MM', // Myanmar
    'nepali': 'NP', // Nepal
    'sinhalese': 'LK', // Sri Lanka
    'malagasy': 'MG', // Madagascar
    'xhosa': 'ZA', // South Africa
    'zulu': 'ZA', // South Africa
    'sundanese': 'ID', // Indonesia
    'javanese': 'ID', // Indonesia
    'gujarati': 'IN', // India
    'malayalam': 'IN', // India
    'kannada': 'IN', // India
    'basque': 'ES', // Spain
    'galician': 'ES', // Spain
    'catalan': 'ES', // Spain
    'esperanto':
        'PL', // Poland (Esperanto is a constructed language but can be associated with Poland)
    'albanian': 'AL', // Albania
    'macedonian': 'MK', // North Macedonia
    'belarusian': 'BY', // Belarus
    'azerbaijani': 'AZ', // Azerbaijan
    'kazakh': 'KZ', // Kazakhstan
    'uzbek': 'UZ', // Uzbekistan
    'kyrgyz': 'KG', // Kyrgyzstan
    'tatar': 'RU', // Russia (Tatar is spoken in Russia)
    'turkmen': 'TM', // Turkmenistan
    'tajik': 'TJ', // Tajikistan
    'yoruba': 'NG', // Nigeria
    'hausa': 'NG', // Nigeria
    'igbo': 'NG', // Nigeria
    'somali': 'SO', // Somalia
    'tigrinya': 'ER', // Eritrea
    'maldivian': 'MV', // Maldives
    'haitian haitian creole': 'ht',
    'cantonese': 'CN'
  };
}
