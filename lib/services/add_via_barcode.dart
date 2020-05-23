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

void runBarcodeScan() async {
  ScanResult scanResult = await BarcodeScanner.scan();

  print(scanResult.type); // The result type (barcode, cancelled, failed)
  print(scanResult.rawContent); // The barcode content
  print(scanResult.format); // The barcode format (as enum)
  print(scanResult
      .formatNote); // If a unknown format was scanned this field contains a note
}
