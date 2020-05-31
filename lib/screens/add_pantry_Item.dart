import 'package:bearserkpantry/services/add_via_barcode.dart';
import 'package:bearserkpantry/utilities/app_drawer.dart';
import 'package:bearserkpantry/utilities/bottom_nav_bar.dart';
import 'package:bearserkpantry/utilities/constants.dart';
import 'package:bearserkpantry/services/stream_builder_functions.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class AddPantryItem extends StatefulWidget {
  static String id = 'add_pantry_item';

  @override
  _AddPantryItemState createState() => _AddPantryItemState();
}

class _AddPantryItemState extends State<AddPantryItem> {
  String _itemName;
  int _itemQuantity;
  String _itemStorageLocation;
  String _itemBarcodeStr;
  TextEditingController _itemBarcodeTextEditingController =
      TextEditingController();

  void runBCScan() async {
    _itemBarcodeStr = await runBarcodeScan();
    setState(() {
      _itemBarcodeTextEditingController.text = _itemBarcodeStr;
    });
  }

  @override
  void dispose() {
    _itemBarcodeTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Pantry Item'),
        actions: <Widget>[
          IconButton(
              icon: Transform.rotate(
                child: Icon(
                  Icons.format_align_justify,
                  color: Colors.white,
                ),
                angle: pi / 2,
              ),
              onPressed: () {
                runBCScan();
              })
        ],
      ),
      drawer: AppDrawer(),
      bottomNavigationBar: BottomNavBar(),
      body: Column(
        children: <Widget>[
          TextField(
            decoration: kTextFieldDecoration.copyWith(hintText: 'Item Name'),
            onChanged: (value) {
              _itemName = value;
            },
          ),
          TextField(
            decoration: kTextFieldDecoration.copyWith(hintText: 'Quantity'),
            onChanged: (value) {
              _itemQuantity = int.parse(value);
            },
          ),
          TextField(
            decoration:
                kTextFieldDecoration.copyWith(hintText: 'Storage Location'),
            onChanged: (value) {
              _itemStorageLocation = value;
            },
          ),
          TextField(
            controller: _itemBarcodeTextEditingController,
            decoration: kTextFieldDecoration.copyWith(hintText: 'Item Barcode'),
            onChanged: (value) {
              _itemBarcodeStr = value;
            },
          ),
          RaisedButton(
            child: Text('Submit'),
            onPressed: () {
              addToPantry(
                itemName: _itemName,
                quantity: _itemQuantity,
                storageLocation: _itemStorageLocation,
                barcode: _itemBarcodeStr,
              );
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
