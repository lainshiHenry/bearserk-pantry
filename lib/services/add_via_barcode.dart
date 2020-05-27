import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';

class AddViaBarcode extends StatefulWidget {
  static String id = 'add_via_barcode';
  @override
  _AddViaBarcodeState createState() => _AddViaBarcodeState();
}

class _AddViaBarcodeState extends State<AddViaBarcode> {
  //ScanResult scanResult;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(onPressed: () {
        runBarcodeScan();
      }),
    );
  }
}

Future<String> runBarcodeScan() async {
  var barcodeOptions =
      ScanOptions(restrictFormat: [BarcodeFormat.upce, BarcodeFormat.ean13]);
  ScanResult scanResult = await BarcodeScanner.scan(options: barcodeOptions);

  print(scanResult.type); // The result type (barcode, cancelled, failed)
  print(scanResult.rawContent); // The barcode content
  print(scanResult.format); // The barcode format (as enum)
  print(scanResult
      .formatNote); // If a unknown format was scanned this field contains a note

  return scanResult.rawContent;
}
