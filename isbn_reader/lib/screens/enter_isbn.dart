import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:isbn_reader/models/isbn_data.dart';
import 'package:isbn_reader/helpers/isbn_api_handler.dart';
import 'package:isbn_reader/screens/view_isbn_data.dart';
import 'dart:io' show Platform;

class EnterISBN extends StatefulWidget {
  const EnterISBN({Key? key}) : super(key: key);

  @override
  _EnterISBNState createState() => _EnterISBNState();
}

class _EnterISBNState extends State<EnterISBN> {
  final bool isIos = Platform.isIOS;
  final isbnTextController = TextEditingController();
  late String isbnNumber;

  Column enterDataIOS() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CupertinoTextField(
          controller: isbnTextController,
//          decoration: InputDecoration(
//            labelStyle: TextStyle(
//              fontSize: 20,
//            ),
//            labelText: "Enter ISBN Number",
//            fillColor: Colors.white,
//            border: OutlineInputBorder(
//              borderRadius: BorderRadius.circular(23),
//              borderSide: BorderSide(),
//            ),
//          ),
          placeholderStyle: const TextStyle(fontSize: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(23),
          ),
          keyboardType: TextInputType.number,
          style: const TextStyle(fontFamily: "Poppins"),
        ),
        CupertinoButton(
          child: const Text("View Book Data"),
          onPressed: () async {
            ISBNData data;
            setState(() {
              isbnNumber = isbnTextController.text;
            });
            //ISBNApiHandler a = ISBNApiHandler(isbnNumber: "9780980200447");
            ISBNApiHandler a = ISBNApiHandler(isbnNumber: isbnNumber);
            Future<ISBNData> response = a.loadISBNData();

            response.then((ISBNData d) async {
              data = d;
              print(data.isbn10);
              await Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ViewISBNData(data)));
            });
          },
        )
      ],
    );
  }

  Column enterDataAndroid() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextFormField(
          controller: isbnTextController,
          decoration: InputDecoration(
            labelStyle: const TextStyle(
              fontSize: 20,
            ),
            labelText: "Enter ISBN Number",
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(23),
              borderSide: const BorderSide(),
            ),
          ),
          validator: null,
          keyboardType: TextInputType.number,
          style: const TextStyle(fontFamily: "Poppins"),
        ),
        ElevatedButton(
          child: const Text("View Book Data"),
          onPressed: () async {
            ISBNData data;
            setState(() {
              isbnNumber = isbnTextController.text;
            });

            //ISBNApiHandler a = ISBNApiHandler(isbnNumber: "9780980200447");

            ISBNApiHandler a = ISBNApiHandler(isbnNumber: isbnNumber);
            Future<ISBNData> response = a.loadISBNData();

            response.then((ISBNData d) async {
              data = d;
              print(data.isbn10);
              await Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ViewISBNData(data)));
            });
          },
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isIos ? enterDataIOS() : enterDataAndroid(),
      appBar: AppBar(
        title: const Text("Enter ISBN"),
      ),
    );
  }
}
