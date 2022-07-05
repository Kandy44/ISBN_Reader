import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:isbn_reader/models/isbn_data.dart';

class ISBNApiHandler {
  final String isbnNumber;

  ISBNApiHandler({required this.isbnNumber});

  http.Client client = http.Client();

  Future<ISBNData> loadISBNData() async {
    print("ISBN Number inside API Handler: $isbnNumber");

    final response = await client.get(Uri.parse("https://openlibrary.org/api/books?bibkeys=ISBN:$isbnNumber&jscmd=data&format=json"));

    var jsonData = json.decode(response.body);

    if (jsonData.containsKey('ISBN:$isbnNumber')) {
      print(jsonData);
      jsonData = jsonData['ISBN:$isbnNumber'];

      var identifiers = jsonData['identifiers'];
      var cover = jsonData.containsKey('cover') ? jsonData['cover'] : null;
      jsonData['publishers'] =
      jsonData.containsKey('publishers') ? jsonData['publishers'][0]['name'] : null;
      jsonData['title'] =
      jsonData.containsKey('title') ? jsonData['title'] : null;
      jsonData['publish_date'] = jsonData.containsKey('publish_date')
          ? jsonData['publish_date']
          : null;
      jsonData['identifiers']['isbn_10'] = identifiers.containsKey('isbn_10')
          ? jsonData['identifiers']['isbn_10']
          : [isbnNumber];
      jsonData['identifiers']['isbn_13'] = identifiers.containsKey('isbn_13')
          ? jsonData['identifiers']['isbn_13']
          : [isbnNumber];
      jsonData['identifiers']['amazon'] = identifiers.containsKey('amazon')
          ? jsonData['identifiers']['amazon']
          : [''];
      jsonData['authors'] =
      jsonData.containsKey('authors') ? jsonData['authors'] : null;
      if(cover == null) {
        jsonData['cover'] = '';
      } else {
        if(!cover.containsKey('medium')) {
          jsonData['cover'] = '';
        } else {
          jsonData['cover'] = jsonData['cover']['medium'];
        }
      }
      // jsonData['cover']['medium'] =
      // cover != null ? cover.containsKey('medium') ? jsonData['cover']['medium'] : null : null;
      jsonData['number_of_pages'] = jsonData.containsKey('number_of_pages')
          ? jsonData['number_of_pages']
          : null;
    }

    // print(jsonData);
    ISBNData data = ISBNData.fromJson(jsonData, isbnNumber);
    return data;
  }
}