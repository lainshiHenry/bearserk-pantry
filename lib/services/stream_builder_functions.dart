import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bearserkpantry/utilities/list_item.dart';

final _firestoreInstance = Firestore.instance;

Widget getShoppingListStream() {
  return StreamBuilder<QuerySnapshot>(
      stream: _firestoreInstance
          .collection('pantry')
          .document('pantry')
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

          final sListItem =
              DismissibleListItem(itemName: itemName, quantity: quantity);

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
            ),
            padding: EdgeInsets.symmetric(vertical: 20.0),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                child: shoppingListStream[index],
              );
            },
          ),
        );
      });
}

class DismissibleListItem extends StatefulWidget {
  final String itemName;
  final int quantity;

  DismissibleListItem({@required this.itemName, this.quantity});

  @override
  _DismissibleListItemState createState() => _DismissibleListItemState();
}

class _DismissibleListItemState extends State<DismissibleListItem> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      background: Container(
        color: Colors.red,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Icon(Icons.delete),
          ],
        ),
      ),
      secondaryBackground: Container(
        color: Colors.green,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Icon(Icons.check),
          ],
        ),
      ),
      key: Key(widget.itemName),
      child: ListItem(
        itemName: widget.itemName,
        quantity: widget.quantity.toString(),
      ),
      onDismissed: (direction) {
        setState(() async {
          try {
            await _firestoreInstance
                .collection('pantry')
                .document('pantry')
                .collection('shoppingList')
                .document('${widget.itemName}')
                .setData({
              'itemName': '${widget.itemName}',
              'quantity': (widget.quantity - 1),
            }, merge: true);
          } catch (e) {
            print(e);
          }
        });
      },
    );
  }
}

void addShoppingListItem(String itemName, int quantity) async {
  try {
    await _firestoreInstance
        .collection('pantry')
        .document('pantry')
        .collection('shoppingList')
        .document('$itemName')
        .setData({
      'itemName': '$itemName',
      'quantity': quantity,
    }, merge: true);
  } catch (e) {
    print(e);
  }
}
