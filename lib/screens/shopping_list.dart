import 'package:bearserkpantry/services/stream_builder_functions.dart';
import 'package:bearserkpantry/utilities/bottom_nav_bar.dart';
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
  String _addItemStoreName;
  final _itemNameEditingController = TextEditingController();
  final _itemQtyEditingController = TextEditingController(text: '1');
  final _itemStoreNameEditingController = TextEditingController();

  @override
  void dispose() {
    _itemNameEditingController.dispose();
    _itemQtyEditingController.dispose();
    _itemStoreNameEditingController.dispose();
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
      bottomNavigationBar: BottomNavBar(),
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
                  Expanded(
                    child: TextField(
                      decoration:
                          kTextFieldDecoration.copyWith(hintText: 'Store'),
                      onChanged: (value) {
                        _addItemStoreName = value;
                      },
                    ),
                  ),
                  RaisedButton(
                    child: Icon(Icons.add),
                    onPressed: () {
                      try {
                        addShoppingListItem(
                            _addItemName, _addItemQuantity, _addItemStoreName);
                        _itemNameEditingController.clear();
                        _itemQtyEditingController.clear();
                        _itemQtyEditingController.text = '1';
                        _itemStoreNameEditingController.clear();
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
