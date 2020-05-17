import 'package:bearserkpantry/services/stream_builder_functions.dart';
import 'package:flutter/material.dart';
import 'package:bearserkpantry/utilities/app_drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bearserkpantry/services/build_list.dart';
import 'package:bearserkpantry/utilities/constants.dart';

class ShoppingList extends StatefulWidget {
  static String id = 'shopping_list';
  @override
  _ShoppingListState createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  Firestore _firestore = Firestore.instance;
  String _addItemName;
  int _addItemQuantity = 1;
  final _textEditingController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Shopping List',
        ),
      ),
      drawer: AppDrawer(),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      decoration:
                          kTextFieldDecoration.copyWith(hintText: 'Item Name'),
                      onChanged: (value) {
                        _addItemName = value;
                      },
                      controller: _textEditingController,
                    ),
                  ),
                  RaisedButton(
                    child: Text('Add Item'),
                    onPressed: () {
                      try {
                        addShoppingListItem(_addItemName, _addItemQuantity);
                        _textEditingController.clear();
                      } catch (e) {
                        print(e);
                      }
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: buildShoppingList(),
            ),
          ],
        ),
      ),
    );
  }
}
