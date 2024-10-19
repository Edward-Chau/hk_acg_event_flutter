class Doujinshimodel {
  const Doujinshimodel({
    required this.bookURL,
    required this.bookName,
    required this.imageUrl,
    required this.summary,
    required this.information,
    required this.animename,
  });

  final String animename;
  final String bookName;
  final String imageUrl;
  final List<String> summary;
  final BookInformation information;
  final String bookURL;
}

class BookInformation {
  const BookInformation({
    required this.pages,
    required this.date,
  });

  final int pages;
  final DateTime date;
}
