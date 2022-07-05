import 'package:flutter/material.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/services.dart';
import 'package:isbn_reader/models/isbn_data.dart';
import 'package:isbn_reader/helpers/isbn_api_handler.dart';
import 'package:isbn_reader/screens/view_isbn_data.dart';

class BarcodeReader extends StatefulWidget {
  @override
  _BarcodeReaderState createState() => _BarcodeReaderState();
}

class _BarcodeReaderState extends State<BarcodeReader> {
  late String isbnNumView = "";
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Read ISBN barcode'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                  ),
                  onPressed: barcodeScan,
                  child: const Text("Scan"),
                ),
              ),
              Text("ISBN Number: $isbnNumView"),
            ],
          ),
        ),
      ),
    );
  }

  Future barcodeScan() async {
    try {
      final result = await BarcodeScanner.scan();
      isbnNumView = result.rawContent;

      ISBNApiHandler a = ISBNApiHandler(isbnNumber: isbnNumView);
      Future<ISBNData> response = a.loadISBNData();

        response.then((ISBNData d) async {
          //data = d;

          print("ISBN 10 from data: ${d.isbn10}");

          await Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => ViewISBNData(d)));
        });
    } on PlatformException catch (e) {
      print("Error occured: ${e.stacktrace}");
      }
    }
  }