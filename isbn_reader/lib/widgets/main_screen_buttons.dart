import 'package:isbn_reader/screens/enter_isbn.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:isbn_reader/screens/barcode_reader.dart';
import 'dart:io' show Platform;

class MainScreenButtons extends StatefulWidget {
  const MainScreenButtons({Key? key}) : super(key: key);

  @override
  _MainScreenButtonsState createState() => _MainScreenButtonsState();
}

class _MainScreenButtonsState extends State<MainScreenButtons> {
  final bool isIos = Platform.isIOS;

  List<Widget> iosButtons() {
    return <Widget>[
      CupertinoButton(
          color: Colors.blue,
          child: const Text("Enter ISBN-10 or ISBN 13 Code"),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => EnterISBN()));
          }),
      CupertinoButton(
        color: Colors.blue,
        child: const Text("Scan the barcode of the book"),
        onPressed: () {
          print("Scan button pressed");
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => BarcodeReader()));
        },
      ),
    ];
  }

  List<Widget> androidButtons() {
    return <Widget>[
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.grey,
        ),
          child: const Text(
            "Enter ISBN-10 or ISBN 13 Code",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => EnterISBN()));
          }),
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.grey,
        ),
        child: const Text(
          "Scan the barcode of the book",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        onPressed: () {
          print("Scan button pressed");
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => BarcodeReader()));
        },
      ),
    ];
  }

  Column generateButtons() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: isIos ? iosButtons() : androidButtons(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return generateButtons();
  }
}
