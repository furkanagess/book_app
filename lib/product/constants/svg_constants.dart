class SVGConstants {
  SVGConstants._init();
  static SVGConstants? _instace;

  static SVGConstants get instance => _instace ??= SVGConstants._init();

  String toSVG(String name) => "assets/svg/$name.svg";

  String get bookCategory => toSVG("book_category");
  String get bookFavorite => toSVG("book_favorite");
  String get bookLover => toSVG("book_lover");
  String get bookRead => toSVG("book_read");
  String get book => toSVG("books");
}
