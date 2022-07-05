import 'package:flutter/material.dart';
import 'package:isbn_reader/models/isbn_data.dart';
import 'package:isbn_reader/helpers/constants.dart';
import 'package:flutter/services.dart';

import '../helpers/constants.dart';
import '../models/isbn_data.dart';

class ViewISBNData extends StatelessWidget {
  final ISBNData isbnData;

  ViewISBNData(this.isbnData);

  Widget androidColumn() {
    String amazonURL = isbnData.amazonIdentifier.isNotEmpty
        ? "https://www.amazon.com/s?k=${isbnData.amazonIdentifier}"
        : "";
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(
              isbnData.mediumBookImage.isNotEmpty
                  ? "Medium Image of Book"
                  : "Image not found",
              style: ISBNTextStyle,
            ),
          ),

    Center(child: isbnData.mediumBookImage.isNotEmpty? Image.network(isbnData.mediumBookImage): Image.asset('assets/images/white_image.jpeg'),),

          Center(
            child: Text(
              isbnData.publisher.isNotEmpty
                  ? "Publisher : ${isbnData.publisher}"
                  : "Publisher : -",
              style: ISBNTextStyle,
            ),
          ),
          Center(
            child: Text(
              isbnData.title.isNotEmpty
                  ? "Title : ${isbnData.title}"
                  : "Title : -",
              style: ISBNTextStyle,
            ),
          ),
          Center(
            child: Text(
              isbnData.publishDate.isNotEmpty
                  ? "Publishing Date : ${isbnData.publishDate}"
                  : "Publishing Date : -",
              style: ISBNTextStyle,
            ),
          ),
          Center(
            child: Text(
              isbnData.numberOfPages != -1
                  ? "Number of Pages : ${isbnData.numberOfPages}"
                  : "Number of Pages : -",
              style: ISBNTextStyle,
            ),
          ),
          Center(
            child: Text(
              isbnData.validData
                  ? "Author Name : ${isbnData.authorName}"
                  : "Author Name : -",
              style: ISBNTextStyle,
            ),
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  isbnData.validData
                      ? "ISBN 10 : ${isbnData.isbn10}"
                      : "ISBN 10 : -",
                  style: ISBNTextStyle,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.teal,
                  ),
                  onPressed: isbnData.validData
                      ? () {
                    Clipboard.setData(
                        ClipboardData(text: isbnData.isbn10));
                  }
                      : null,
                  child: const Text(
                    "Copy ISBN 10",
                    style: ISBNTextStyle,
                  ),
                )
              ],
            ),
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  isbnData.validData
                      ? "ISBN 13 : ${isbnData.isbn13}"
                      : "ISBN 13 : -",
                  style: ISBNTextStyle,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.teal,
                  ),
                  onPressed: isbnData.validData
                      ? () {
                    Clipboard.setData(
                        ClipboardData(text: isbnData.isbn13));
                  }
                      : null,
                  child: const Text(
                    "Copy ISBN 13",
                    style: ISBNTextStyle,
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Colors.teal,
            ),
            onPressed: amazonURL != ""
                ? () {
              Clipboard.setData(
                ClipboardData(text: amazonURL),
              );
            }
                : null,
            child: const Text(
              "Copy Amazon URL",
              style: ISBNTextStyle,
            ),
          ),
        ],
      ),
    );
  }

  Widget viewData() {
    if (!isbnData.validData) {
      return Center(
        child: Text(
          "Entered ISBN is ${isbnData.isbn13}\nInvalid ISBN or Data not found",
          style: ISBNTextStyle,
        ),
      );
    }
    // If the data is valid, this is returned
    return androidColumn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ISBN Data"),
      ),
      body: viewData(),
    );
  }
}
