import 'package:bearserkpantry/services/stream_builder_functions.dart';
import 'package:flutter/material.dart';
import 'package:bearserkpantry/utilities/constants.dart';
import 'package:bearserkpantry/utilities/arguments/edit_pantry_item_arguments.dart';

class PantryItemDetails extends StatefulWidget {
  static String id = 'item_details';
  static const routeName = '/extractArguments';
  @override
  _PantryItemDetailsState createState() => _PantryItemDetailsState();
}

class _PantryItemDetailsState extends State<PantryItemDetails> {
  String _itemName;
  int _itemQuantity;
  String _itemStorageLocation;
  String _itemBarcode;

  TextEditingController _itemNameTextEditingController =
      TextEditingController();
  TextEditingController _itemQuantityTextEditingController =
      TextEditingController();
  TextEditingController _itemStorageLocationTextEditingController =
      TextEditingController();
  TextEditingController _itemBarcodeTextEditingController =
      TextEditingController();

  @override
  void dispose() {
    _itemNameTextEditingController.dispose();
    _itemQuantityTextEditingController.dispose();
    _itemStorageLocationTextEditingController.dispose();
    _itemBarcodeTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ItemArgs args = ModalRoute.of(context).settings.arguments;
    _itemNameTextEditingController.text = args.productName;
    _itemName = args.productName;
    _itemQuantityTextEditingController.text = args.itemQuantity.toString();
    _itemQuantity = args.itemQuantity;
    _itemStorageLocationTextEditingController.text = args.storageLocation;
    _itemStorageLocation = args.storageLocation;
    _itemBarcodeTextEditingController.text = args.barcode;
    _itemBarcode = args.barcode;

    return Scaffold(
      appBar: AppBar(
        title: Text('Detailed View'),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            TextField(
              controller: _itemNameTextEditingController,
              decoration: kTextFieldDecoration.copyWith(hintText: 'Item Name'),
              onChanged: (value) {
                _itemName = value;
              },
            ),
            TextField(
              controller: _itemQuantityTextEditingController,
              decoration: kTextFieldDecoration.copyWith(hintText: 'Quantity'),
              onChanged: (value) {
                _itemQuantity = int.parse(value);
              },
            ),
            args.storageLocation == null
                ? SizedBox(
                    height: 0.0,
                  )
                : TextField(
                    controller: _itemStorageLocationTextEditingController,
                    decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Storage Location'),
                    onChanged: (value) {
                      _itemStorageLocation = value;
                    },
                  ),
            args.barcode == null
                ? SizedBox(
                    height: 0.0,
                  )
                : TextField(
                    controller: _itemBarcodeTextEditingController,
                    decoration:
                        kTextFieldDecoration.copyWith(hintText: 'Item Barcode'),
                    onChanged: (value) {
                      _itemBarcode = value;
                    },
                  ),
            Row(
              children: <Widget>[
                RaisedButton(
                  child: Text('Submit'),
                  onPressed: () {
                    try {
                      addToPantry(
                        itemName: _itemName,
                        quantity: _itemQuantity,
                        storageLocation: _itemStorageLocation,
                        barcode: _itemBarcode,
                      );
                      Navigator.pop(context);
                    } catch (e) {
                      print(e);
                    }
                  },
                ),
                RaisedButton(
                  child: Text('Cancel'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
