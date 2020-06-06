import 'package:bearserkpantry/services/stream_data.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bearserkpantry/utilities/dismissible_list_item.dart';
import 'package:bearserkpantry/utilities/pantry_list_item.dart';
import 'package:bearserkpantry/utilities/dev_constants.dart';

final _firestoreInstance = Firestore.instance;

Widget getPantryStream() {
  return StreamBuilder<QuerySnapshot>(
      stream: _firestoreInstance
          .collection('pantry')
          .document('$pantryID')
          .collection('pantry')
          .orderBy('itemName', descending: false)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final pantryList = snapshot.data.documents;
        List<PantryListItem> pantryListStream = [];

        for (var pantryListItem in pantryList) {
          final String itemName = pantryListItem.data['itemName'];
          final int quantity = pantryListItem.data['quantity'];
          final String storageLocation = pantryListItem.data['storageLocation'];

          final pListItem = PantryListItem(
            itemName: itemName,
            quantity: quantity,
            storageLocation: storageLocation,
          );
          pantryListStream.add(pListItem);
        }
        userPantryListStream = pantryListStream;
        return ListView.separated(
          itemCount: pantryListStream.length,
          separatorBuilder: (BuildContext context, int index) => const Divider(
            thickness: 2.0,
            indent: 30.0,
            endIndent: 30.0,
            height: 0.0,
          ),
          padding: EdgeInsets.symmetric(vertical: 20.0),
          itemBuilder: (BuildContext context, int index) {
            return Container(
              child: pantryListStream[index],
            );
          },
        );
      });
}

Widget getShoppingListStream() {
  return StreamBuilder<QuerySnapshot>(
      stream: _firestoreInstance
          .collection('pantry')
          .document('$pantryID')
          .collection('shoppingList')
          .orderBy('itemName', descending: false)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final shoppingList = snapshot.data.documents;
        List<DismissibleListItem> shoppingListStream = [];

        for (var shoppingListItem in shoppingList) {
          final String itemName = shoppingListItem.data['itemName'];
          final int quantity = shoppingListItem.data['quantity'];
          final String storeName = shoppingListItem.data['storeName'];

          final sListItem = DismissibleListItem(
            itemName: itemName,
            quantity: quantity,
            storeName: storeName,
          );

          shoppingListStream.add(sListItem);
        }
        userShoppingListStream = shoppingListStream;

        return Container(
          child: ListView.separated(
            itemCount: shoppingListStream.length,
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(
              thickness: 2.0,
              indent: 30.0,
              endIndent: 30.0,
              height: 0.0,
            ),
            //padding: EdgeInsets.symmetric(vertical: 20.0),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                child: shoppingListStream[index],
              );
            },
          ),
        );
      });
}

Future<bool> addShoppingListItem(
    {String itemName, int quantity, String storeName}) async {
  String _formattedItemName = itemName != null ? itemName.toLowerCase() : '';
  String _formattedStoreName = storeName != null ? storeName.toLowerCase() : '';
  bool _result = false;

  if (itemName != '') {
    try {
      await _firestoreInstance
          .collection('pantry')
          .document('$pantryID')
          .collection('shoppingList')
          .document('$_formattedItemName')
          .setData({
        'itemName': '$_formattedItemName',
        'quantity': quantity,
        'storeName': '$_formattedStoreName',
      }, merge: true);
      _result = true;
    } catch (e) {
      print(e);
      _result = false;
    }
  } else {
    _result = false;
  }
  return _result;
}

void deleteShoppingListItem(
    {String itemName, int quantity, String storeName}) async {
  String _formattedItemName = itemName != null ? itemName.toLowerCase() : '';
  if (_formattedItemName != '') {
    try {
      await _firestoreInstance
          .collection('pantry')
          .document('$pantryID')
          .collection('shoppingList')
          .document('$_formattedItemName')
          .delete();
    } catch (e) {
      print(e);
    }
  }
}

Future<void> purchaseItem(
    {String itemName, int quantity, String storeName}) async {
  String _formattedItemName = itemName != null ? itemName.toLowerCase() : '';
  try {
    await _firestoreInstance
        .collection('pantry')
        .document('$pantryID')
        .collection('shoppingList')
        .document('${itemName.toLowerCase()}')
        .delete();

    addToPurchaseHistory(
      itemName: itemName,
      quantity: quantity,
    );

    addToPantry(
      itemName: itemName,
      quantity: quantity,
    );
  } catch (e) {
    print(e);
  }
}

void addToPurchaseHistory({String itemName, int quantity}) async {
  String currentTimestamp = DateTime.now().millisecondsSinceEpoch.toString();
  String _formattedItemName = itemName != null ? itemName.toLowerCase() : '';
  if (_formattedItemName != '') {
    try {
      await _firestoreInstance
          .collection('pantry')
          .document('$pantryID')
          .collection('purchaseHistory')
          .document('$currentTimestamp')
          .setData({
        'itemName': '$_formattedItemName',
        'quantity': quantity,
      }, merge: true);
    } catch (e) {
      print(e);
    }
  }
}

void addToPantry(
    {String itemName,
    int quantity,
    String storageLocation,
    String barcode}) async {
  String _formattedItemName = itemName != null ? itemName.toLowerCase() : '';
  String _formattedStorageLocation =
      storageLocation != null ? storageLocation.toLowerCase() : '';

  if (_formattedItemName != '') {
    try {
      await _firestoreInstance
          .collection('pantry')
          .document('$pantryID')
          .collection('pantry')
          .document('$_formattedItemName')
          .setData({
        'itemName': '$_formattedItemName',
        'quantity': quantity,
        'storageLocation': '$_formattedStorageLocation',
        'barcode': '$barcode',
      }, merge: true);
    } catch (e) {
      print(e);
    }
  }
}

Future<String> deleteFromPantry({String itemName, String barcode}) async {
  String _errorMsg;
  try {
    await _firestoreInstance
        .collection('pantry')
        .document('$pantryID')
        .collection('pantry')
        .document('${itemName.toLowerCase()}')
        .delete();
    _errorMsg = null;
  } catch (e) {
    print(e);
    _errorMsg = e.message.toString();
  }
  return _errorMsg;
}

Future<String> addToProductDB(
    {String barcode,
    String productName,
    String productBrand,
    int productQuantity,
    String quantityUnit}) async {
  String _errorMsg;

  try {
    await _firestoreInstance
        .collection('productDB')
        .document('$barcode')
        .setData({
      'barcode': '$barcode',
      'productName': '${productName.toLowerCase()}',
      'productBrand': '${productBrand.toLowerCase()}',
      'productQuantity': productQuantity,
      'quantityUnit': '${quantityUnit.toLowerCase()}',
    }, merge: true);
    _errorMsg = null;
  } catch (e) {
    print(e);
    _errorMsg = e.message.toString();
  }
  return _errorMsg;
}
