import 'package:bearserkpantry/services/stream_builder_functions.dart';
import 'package:flutter/material.dart';
import 'package:bearserkpantry/utilities/app_drawer.dart';
import 'package:bearserkpantry/services/build_list.dart';
import 'package:bearserkpantry/utilities/constants.dart';

class ShoppingList extends StatefulWidget {
  static String id = 'shopping_list';
  @override
  _ShoppingListState createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  String _addItemName;
  int _addItemQuantity = 1;
  final _itemNameEditingController = TextEditingController();
  final _itemQtyEditingController = TextEditingController(text: '1');

  @override
  void dispose() {
    // TODO: implement dispose
    _itemNameEditingController.dispose();
    _itemQtyEditingController.dispose();
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
                    flex: 3,
                    child: TextField(
                      decoration:
                          kTextFieldDecoration.copyWith(hintText: 'Item Name'),
                      onChanged: (value) {
                        _addItemName = value;
                      },
                      controller: _itemNameEditingController,
                      textInputAction: TextInputAction.done,
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration:
                          kTextFieldDecoration.copyWith(hintText: 'Quantity'),
                      onChanged: (value) {
                        _addItemQuantity = int.parse(value);
                      },
                      controller: _itemQtyEditingController,
                    ),
                  ),
                  RaisedButton(
                    child: Text('Add Item'),
                    onPressed: () {
                      try {
                        addShoppingListItem(_addItemName, _addItemQuantity);
                        _itemNameEditingController.clear();
                        _itemQtyEditingController.text = '1';
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
