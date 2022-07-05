class ISBNData {
  String publisher;
  String title;
  String publishDate;
  String isbn10;
  String isbn13;
  String amazonIdentifier;
  String authorName;
  String mediumBookImage;
  int numberOfPages;
  bool validData;

  ISBNData(
      {required this.publisher,
        required this.title,
        required this.publishDate,
        required this.isbn10,
        required this.isbn13,
        required this.amazonIdentifier,
        required this.authorName,
        required this.mediumBookImage,
        required this.numberOfPages,
        required this.validData});

  factory ISBNData.fromJson(Map parsedJsonData, String isbnNumber) {
    if (parsedJsonData.toString() == "{}" || parsedJsonData.toString().startsWith("{\"error\"")) {
      return ISBNData(
          publisher: '',
          title: '',
          publishDate: '',
          isbn10: isbnNumber,
          isbn13: isbnNumber,
          amazonIdentifier: '',
          authorName: '',
          mediumBookImage: '',
          numberOfPages: -1,
          validData: false);
    }
    return ISBNData(
      publisher: parsedJsonData['publishers'][0],
      title: parsedJsonData['title'],
      publishDate: parsedJsonData['publish_date'],
      isbn10: parsedJsonData['identifiers']['isbn_10'][0],
      isbn13: parsedJsonData['identifiers']['isbn_13'][0],
      amazonIdentifier: parsedJsonData['identifiers']['amazon'][0],
      authorName: parsedJsonData['authors'][0]['name'],
      mediumBookImage: parsedJsonData['cover'],
      numberOfPages: parsedJsonData['number_of_pages'],
      validData: parsedJsonData['identifiers']['isbn_10'][0] != null ||
          parsedJsonData['identifiers']['isbn_13'][0] != null,
    );
  }
}