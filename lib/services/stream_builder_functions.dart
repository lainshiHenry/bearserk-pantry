import 'package:bearserkpantry/data/pantry_user.dart';
import 'package:bearserkpantry/services/stream_data.dart';
import 'package:bearserkpantry/utilities/shopping_list_item.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bearserkpantry/utilities/dismissible_list_item.dart';
import 'package:bearserkpantry/utilities/pantry_list_item.dart';
import 'package:bearserkpantry/services/shopping_list_stream_builder.dart';

final _firestoreInstance = Firestore.instance;

Widget getPantryStream() {
  return StreamBuilder<QuerySnapshot>(
      stream: _firestoreInstance
          .collection('pantry')
          .document('${currentUser.pantryID}')
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
          .document('${currentUser.pantryID}')
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
        List<ShoppingListItem> shoppingListStream2 = [];

        for (var shoppingListItem in shoppingList) {
          final String itemName = shoppingListItem.data['itemName'];
          final int quantity = shoppingListItem.data['quantity'];
          final String storeName = shoppingListItem.data['storeName'];

          /*final sListItem = DismissibleListItem(
            itemName: itemName,
            quantity: quantity,
            storeName: storeName,
          );*/
          final sListItem2 = ShoppingListItem(
            itemName: itemName,
            quantity: quantity,
            storeName: storeName,
          );

          //shoppingListStream.add(sListItem);
          shoppingListStream2.add(sListItem2);
        }
        userShoppingListStream = shoppingListStream;

        return ShoppingListStreamBuilder(
          list: shoppingListStream2,
        );
//
      });
}

void addToErrorLog({String errorMessage, String itemName}) async {
  String currentTimestamp = DateTime.now().millisecondsSinceEpoch.toString();
  String _formattedItemName = itemName != null ? itemName.toLowerCase() : '';

  if (itemName != '') {
    try {
      await _firestoreInstance
          .collection('errorLog')
          .document('$currentTimestamp')
          .setData({
        'itemName': '$_formattedItemName',
        'errorMessage': '$errorMessage',
      }, merge: false);
    } catch (e) {
      print(e);
    }
  }
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
          .document('${currentUser.pantryID}')
          .collection('shoppingList')
          .document('$_formattedItemName')
          .setData({
        'itemName': '$_formattedItemName',
        'quantity': quantity,
        'storeName': '$_formattedStoreName',
      }, merge: true);
      _result = true;

      addTransactionHistory(
        itemName: _formattedItemName,
        quantity: quantity,
        storeName: _formattedStoreName,
        action: 'add',
        fromMenu: 'shopping list',
      );
    } catch (e) {
      print(e);
      String _errorMsg = e.message.toString();
      addToErrorLog(errorMessage: _errorMsg, itemName: _formattedItemName);
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
  String _formattedStoreName = storeName != null ? storeName.toLowerCase() : '';
  if (_formattedItemName != '') {
    try {
      await _firestoreInstance
          .collection('pantry')
          .document('${currentUser.pantryID}')
          .collection('shoppingList')
          .document('$_formattedItemName')
          .delete();

      addTransactionHistory(
        itemName: _formattedItemName,
        quantity: quantity,
        storeName: _formattedStoreName,
        action: 'delete',
        fromMenu: 'shopping list',
      );
    } catch (e) {
      print(e);
      String _errorMsg = e.message.toString();
      addToErrorLog(errorMessage: _errorMsg, itemName: _formattedItemName);
    }
  }
}

Future<bool> purchaseItem(
    {String itemName, int quantity, String storeName}) async {
  String _formattedItemName = itemName != null ? itemName.toLowerCase() : '';
  bool _result = false;
  try {
    await _firestoreInstance
        .collection('pantry')
        .document('${currentUser.pantryID}')
        .collection('shoppingList')
        .document('$_formattedItemName')
        .delete();

    addToPurchaseHistory(
      itemName: itemName,
      quantity: quantity,
    );

    addToPantry(
      itemName: itemName,
      quantity: quantity,
    );
    _result = true;
  } catch (e) {
    print(e);
    String _errorMsg = e.message.toString();
    addToErrorLog(errorMessage: _errorMsg, itemName: _formattedItemName);
  }
  return _result;
}

void addToPurchaseHistory({String itemName, int quantity}) async {
  String currentTimestamp = DateTime.now().millisecondsSinceEpoch.toString();
  String _formattedItemName = itemName != null ? itemName.toLowerCase() : '';
  if (_formattedItemName != '') {
    try {
      await _firestoreInstance
          .collection('pantry')
          .document('${currentUser.pantryID}')
          .collection('purchaseHistory')
          .document('$currentTimestamp')
          .setData({
        'itemName': '$_formattedItemName',
        'quantity': quantity,
      }, merge: true);

      addTransactionHistory(
          itemName: _formattedItemName,
          quantity: quantity,
          action: 'add',
          fromMenu: 'purchase history');
    } catch (e) {
      print(e);
      String _errorMsg = e.message.toString();
      addToErrorLog(errorMessage: _errorMsg, itemName: _formattedItemName);
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
  String _formattedBarcode = barcode != null ? barcode : '';

  if (_formattedItemName != '') {
    try {
      await _firestoreInstance
          .collection('pantry')
          .document('${currentUser.pantryID}')
          .collection('pantry')
          .document('$_formattedItemName')
          .setData({
        'itemName': '$_formattedItemName',
        'quantity': quantity,
        'storageLocation': '$_formattedStorageLocation',
        'barcode': '$_formattedBarcode',
      }, merge: true);

      addTransactionHistory(
        itemName: _formattedItemName,
        quantity: quantity,
        storageLocation: _formattedStorageLocation,
        barcode: _formattedBarcode,
        action: 'add',
        storeName: 'pantry',
      );
    } catch (e) {
      print(e);
      String _errorMsg = e.message.toString();
      addToErrorLog(errorMessage: _errorMsg, itemName: _formattedItemName);
    }
  }
}

Future<String> deleteFromPantry({String itemName, String barcode}) async {
  String _formattedItemName = itemName != null ? itemName.toLowerCase() : '';
  String _formattedBarcode = barcode != null ? barcode : '';
  String _errorMsg;

  if (_formattedItemName != '') {
    try {
      await _firestoreInstance
          .collection('pantry')
          .document('${currentUser.pantryID}')
          .collection('pantry')
          .document('$_formattedItemName')
          .delete();
      _errorMsg = null;

      addTransactionHistory(
        itemName: itemName,
        barcode: _formattedBarcode,
        action: 'delete',
        fromMenu: 'pantry',
      );
    } catch (e) {
      print(e);
      _errorMsg = e.message.toString();
      addToErrorLog(errorMessage: _errorMsg, itemName: _formattedItemName);
    }
  } else {
    _errorMsg = 'Could not locate $itemName or $barcode';
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

    addTransactionHistory(
      itemName: productName,
      barcode: barcode,
      action: 'add',
      fromMenu: 'product database',
    );
  } catch (e) {
    print(e);
    String _errorMsg = e.message.toString();
    addToErrorLog(errorMessage: _errorMsg, itemName: productName);
  }
  return _errorMsg;
}

void editProductDB() {}

void addTransactionHistory(
    {String itemName,
    int quantity,
    String storageLocation,
    String barcode,
    String storeName,
    String action,
    String fromMenu}) async {
  String currentTimestamp = DateTime.now().millisecondsSinceEpoch.toString();
  String _formattedItemName = itemName != null ? itemName.toLowerCase() : '';
  String _formattedStorageLocation =
      storageLocation != null ? storageLocation.toLowerCase() : '';
  String _formattedStoreName = storeName != null ? storeName.toLowerCase() : '';
  String _formattedBarcode = barcode != null ? barcode : '';
  String _formattedAction = action.toLowerCase();
  String _formattedFromMenu = fromMenu.toLowerCase();

  try {
    await _firestoreInstance
        .collection('pantry')
        .document('${currentUser.pantryID}')
        .collection('transactionHistory')
        .document('$currentTimestamp')
        .setData({
      'timestamp': '$currentTimestamp',
      'itemName': '$_formattedItemName',
      'quantity': quantity,
      'barcode': '$_formattedBarcode',
      'storageLocation': '$_formattedStorageLocation',
      'storeName': '$_formattedStoreName',
      'action': '$_formattedAction',
      'fromMenu': '$_formattedFromMenu',
    }, merge: true);
  } catch (e) {
    print(e);
    String _errorMsg = e.message.toString();
    addToErrorLog(errorMessage: _errorMsg, itemName: _formattedItemName);
  }
}
