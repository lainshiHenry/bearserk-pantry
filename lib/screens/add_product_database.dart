import 'package:bearserkpantry/services/add_via_barcode.dart';
import 'package:bearserkpantry/utilities/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:bearserkpantry/utilities/app_drawer.dart';
import 'dart:math';
import 'package:bearserkpantry/utilities/constants.dart';
import 'package:bearserkpantry/services/stream_builder_functions.dart';

class AddProductDatabase extends StatefulWidget {
  static String id = 'add_product_database';
  @override
  _AddProductDatabaseState createState() => _AddProductDatabaseState();
}

class _AddProductDatabaseState extends State<AddProductDatabase> {
  String _errorMessage;
  bool _gotError = false;
  String _returnedMessage;
  String _itemBarcode;
  String _itemProductBrand;
  String _itemProductName;
  int _itemProductQuantity;
  String _itemProductQuantityUnit;
  TextEditingController _barcodeTextEditingController = TextEditingController();
  TextEditingController _productBrandTextEditingController =
      TextEditingController();
  TextEditingController _productNameTextEditingController =
      TextEditingController();
  TextEditingController _productQuantityTextEditingController =
      TextEditingController();
  TextEditingController _quantityUnitTextEditingController =
      TextEditingController();

  void runBCScan() async {
    _itemBarcode = await runBarcodeScan();
    setState(() {
      _barcodeTextEditingController.text = _itemBarcode;
    });
  }

  @override
  void dispose() {
    _barcodeTextEditingController.dispose();
    _productBrandTextEditingController.dispose();
    _productNameTextEditingController.dispose();
    _productQuantityTextEditingController.dispose();
    _quantityUnitTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      bottomNavigationBar: BottomNavBar(),
      appBar: AppBar(
        title: Text('Add To Product DB'),
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
      body: Column(
        children: <Widget>[
          TextField(
            controller: _barcodeTextEditingController,
            decoration: kTextFieldDecoration.copyWith(hintText: 'barcode'),
            onChanged: (value) {
              _itemBarcode = value;
            },
          ),
          TextField(
            controller: _productBrandTextEditingController,
            decoration:
                kTextFieldDecoration.copyWith(hintText: 'product Brand'),
            onChanged: (value) {
              _itemProductBrand = value;
            },
          ),
          TextField(
            controller: _productNameTextEditingController,
            decoration: kTextFieldDecoration.copyWith(hintText: 'product Name'),
            onChanged: (value) {
              _itemProductName = value;
            },
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  controller: _productQuantityTextEditingController,
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'product Quantity'),
                  onChanged: (value) {
                    _itemProductQuantity = int.parse(value);
                  },
                ),
              ),
              Expanded(
                child: TextField(
                  controller: _quantityUnitTextEditingController,
                  decoration:
                      kTextFieldDecoration.copyWith(hintText: 'quantity Unit'),
                  onChanged: (value) {
                    _itemProductQuantityUnit = value;
                  },
                ),
              ),
            ],
          ),
          _gotError
              ? Container(
                  child: Center(
                    child: Text(
                      _errorMessage,
                      style: kErrorMessageTextDecoration,
                    ),
                  ),
                )
              : SizedBox(
                  height: 0,
                ),
          _gotError
              ? SizedBox(
                  height: 10.0,
                )
              : SizedBox(
                  height: 0.0,
                ),
          RaisedButton(
            child: Text('Submit'),
            onPressed: () async {
              print(_itemBarcode);
              print(_itemProductName);
              print(_itemProductBrand);
              print(_itemProductQuantity);
              print(_itemProductQuantityUnit);
              _returnedMessage = await addToProductDB(
                barcode: _itemBarcode,
                productName: _itemProductName,
                productBrand: _itemProductBrand,
                productQuantity: _itemProductQuantity,
                quantityUnit: _itemProductQuantityUnit,
              );
              if (_returnedMessage != null) {
                _gotError = true;
                setState(() {
                  _errorMessage = _returnedMessage;
                });
              } else {
                _gotError = false;
                _productNameTextEditingController.clear();
                _productBrandTextEditingController.clear();
                _barcodeTextEditingController.clear();
                _productQuantityTextEditingController.clear();
                _quantityUnitTextEditingController.clear();
              }
            },
          ),
        ],
      ),
    );
  }
}
