import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bearserkpantry/utilities/dismissible_list_item.dart';
import 'package:bearserkpantry/utilities/pantry_list_view.dart';
import 'package:bearserkpantry/utilities/dev_constants.dart';

final _firestoreInstance = Firestore.instance;

Widget getPantryStream() {
  return StreamBuilder<QuerySnapshot>(
      stream: _firestoreInstance
          .collection('pantry')
          .document('$pantryID')
          .collection('pantry')
          .where('quantity', isGreaterThan: 0)
          .orderBy('quantity', descending: false)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final pantryList = snapshot.data.documents;
        List<PantryListView> pantryListStream = [];

        for (var pantryListItem in pantryList) {
          final String itemName = pantryListItem.data['itemName'];
          final int quantity = pantryListItem.data['quantity'];
          final String storageLocation = pantryListItem.data['storageLocation'];

          final pListItem = PantryListView(
            itemName: itemName,
            quantity: quantity,
            storageLocation: storageLocation,
          );
          pantryListStream.add(pListItem);
        }
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
          .where('quantity', isGreaterThan: 0)
          .orderBy('quantity', descending: false)
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

void addShoppingListItem(
    String itemName, int quantity, String storeName) async {
  try {
    await _firestoreInstance
        .collection('pantry')
        .document('$pantryID')
        .collection('shoppingList')
        .document('${itemName.toLowerCase()}')
        .setData({
      'itemName': '${itemName.toLowerCase()}',
      'quantity': quantity,
      'storeName': '${storeName.toLowerCase()}',
    }, merge: true);
  } catch (e) {
    print(e);
  }
}

Future<void> purchaseItem(
    {String itemName, int quantity, String storeName}) async {
//  var currentQuantity = _firestoreInstance.collection('pantry').document('$pantryID').collection('shoppingList').document('$itemName');

  try {
    /* only used when buying less than required amount
    await _firestoreInstance
        .collection('pantry')
        .document('$pantryID')
        .collection('shoppingList')
        .document('$itemName')
        .setData({
      'itemName': '$itemName',
      'quantity': 0,
    }, merge: true);*/

    await _firestoreInstance
        .collection('pantry')
        .document('$pantryID')
        .collection('shoppingList')
        .document('$itemName')
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
  try {
    await _firestoreInstance
        .collection('pantry')
        .document('$pantryID')
        .collection('purchaseHistory')
        .document('$currentTimestamp')
        .setData({
      'itemName': '$itemName',
      'quantity': quantity,
    }, merge: true);
  } catch (e) {
    print(e);
  }
}

void addToPantry(
    {String itemName,
    int quantity,
    String storageLocation,
    String barcode}) async {
  await _firestoreInstance
      .collection('pantry')
      .document('$pantryID')
      .collection('pantry')
      .document('$itemName')
      .setData({
    'itemName': '$itemName',
    'quantity': quantity,
    'storageLocation': '$storageLocation',
    'barcode': '$barcode',
  }, merge: true);
}
