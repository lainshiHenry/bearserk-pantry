import 'package:bearserkpantry/services/stream_builder_functions.dart';
import 'package:flutter/material.dart';
import 'package:bearserkpantry/utilities/arguments/edit_pantry_item_arguments.dart';
import 'package:bearserkpantry/utilities/constants.dart';

class ShoppingListItemDetails extends StatefulWidget {
  static String id = 'shopping_list_item_details';
  static const routeName = '/extractArguments';
  @override
  _ShoppingListItemDetailsState createState() =>
      _ShoppingListItemDetailsState();
}

class _ShoppingListItemDetailsState extends State<ShoppingListItemDetails> {
  String _itemName;
  int _itemQuantity;
  String _purchaseStoreLocation;
  String _itemBarcode;

  TextEditingController _itemNameTextEditingController =
      TextEditingController();
  TextEditingController _itemQuantityTextEditingController =
      TextEditingController();
  TextEditingController _purchaseStoreLocationTextEditingController =
      TextEditingController();
  TextEditingController _itemBarcodeTextEditingController =
      TextEditingController();

  @override
  void dispose() {
    _itemNameTextEditingController.dispose();
    _itemQuantityTextEditingController.dispose();
    _purchaseStoreLocationTextEditingController.dispose();
    _itemBarcodeTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ItemArgs args = ModalRoute.of(context).settings.arguments;
    _itemName = args.productName;
    _itemNameTextEditingController.text = args.productName;
    _itemQuantity = args.itemQuantity;
    _itemQuantityTextEditingController.text = args.itemQuantity.toString();
    _purchaseStoreLocation = args.purchaseStoreName;
    _purchaseStoreLocationTextEditingController.text = args.purchaseStoreName;
    _itemBarcode = args.barcode;
    _itemBarcodeTextEditingController.text = args.barcode;

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
            TextField(
              controller: _purchaseStoreLocationTextEditingController,
              decoration:
                  kTextFieldDecoration.copyWith(hintText: 'store location'),
              onChanged: (value) {
                _purchaseStoreLocation = value;
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
                      addShoppingListItem(
                        itemName: _itemName,
                        quantity: _itemQuantity,
                        storeName: _purchaseStoreLocation,
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
