import 'package:bearserkpantry/services/add_via_barcode.dart';
import 'package:bearserkpantry/utilities/app_drawer.dart';
import 'package:bearserkpantry/utilities/bottom_nav_bar.dart';
import 'package:bearserkpantry/utilities/constants.dart';
import 'package:bearserkpantry/services/stream_builder_functions.dart';
import 'package:bearserkpantry/services/math_functions.dart';
import 'package:bearserkpantry/utilities/snackbar.dart';
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
  bool _inputNameError = false;
  bool _inputQuantityError = false;
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
      body: Builder(builder: (BuildContext context) {
        return Column(
          children: <Widget>[
            TextField(
              decoration: _inputNameError
                  ? kErrorTextFieldDecoration.copyWith(
                      hintText: 'Invalid Item Name')
                  : kTextFieldDecoration.copyWith(hintText: 'Item Name'),
              onChanged: (value) {
                _itemName = value;
              },
            ),
            TextField(
              decoration: _inputQuantityError
                  ? kErrorTextFieldDecoration.copyWith(
                      hintText: 'Invalid Quantity')
                  : kTextFieldDecoration.copyWith(hintText: 'Quantity'),
              onChanged: (value) {
                if (isNumeric(value)) {
                  _itemQuantity = int.parse(value);
                  setState(() {
                    _inputQuantityError = false;
                  });
                } else {
                  setState(() {
                    _inputQuantityError = true;
                  });
                }
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
              decoration:
                  kTextFieldDecoration.copyWith(hintText: 'Item Barcode'),
              onChanged: (value) {
                _itemBarcodeStr = value;
              },
            ),
            RaisedButton(
              child: Text('Submit'),
              onPressed: () {
                try {
                  if (_itemQuantity >= 0) {
                    setState(() {
                      _inputNameError = false;
                      _inputQuantityError = false;
                    });
                    addToPantry(
                      itemName: _itemName,
                      quantity: _itemQuantity,
                      storageLocation: _itemStorageLocation,
                      barcode: _itemBarcodeStr,
                    );
                    Navigator.pop(context);
                  } else {
                    setState(() {
                      _inputNameError = true;
                      _inputQuantityError = true;
                    });
                  }
                } catch (e) {
                  print(e);
                }
              },
            ),
          ],
        );
      }),
    );
  }
}
