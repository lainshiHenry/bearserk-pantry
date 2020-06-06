import 'package:bearserkpantry/services/stream_builder_functions.dart';
import 'package:bearserkpantry/utilities/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:bearserkpantry/utilities/app_drawer.dart';
import 'package:bearserkpantry/services/build_list.dart';
import 'package:bearserkpantry/utilities/constants.dart';
import 'package:bearserkpantry/services/math_functions.dart';
import 'package:bearserkpantry/utilities/snackbar.dart';

class ShoppingList extends StatefulWidget {
  static String id = 'shopping_list';
  @override
  _ShoppingListState createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  String _addItemName;
  int _addItemQuantity = 1;
  String _addItemStoreName;
  bool _inputNameError = false;
  bool _inputQuantityError = false;
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
      body: Builder(
        builder: (BuildContext context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Flexible(
                    flex: 2,
                    child: TextField(
                      decoration: _inputNameError
                          ? kErrorTextFieldDecoration.copyWith(
                              hintText: 'Invalid Item Name',
                            )
                          : kTextFieldDecoration.copyWith(
                              hintText: 'Item Name'),
                      onChanged: (value) {
                        _addItemName = value;
                      },
                      controller: _itemNameEditingController,
                      textInputAction: TextInputAction.done,
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: _inputQuantityError
                          ? kErrorTextFieldDecoration.copyWith(
                              hintText: 'Invalid Quantity')
                          : kTextFieldDecoration.copyWith(hintText: 'Quantity'),
                      onChanged: (value) {
                        if (isNumeric(value)) {
                          _addItemQuantity = int.parse(value);
                          setState(() {
                            _inputQuantityError = false;
                          });
                        } else {
                          setState(() {
                            _inputQuantityError = true;
                          });
                        }
                      },
                      controller: _itemQtyEditingController,
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: TextField(
                      controller: _itemStoreNameEditingController,
                      decoration:
                          kTextFieldDecoration.copyWith(hintText: 'Store'),
                      onChanged: (value) {
                        _addItemStoreName = value;
                      },
                    ),
                  ),
                  RaisedButton(
                    child: Icon(Icons.add),
                    onPressed: () async {
                      try {
                        if ((_addItemName != null && _addItemName.length > 0) &&
                            _addItemQuantity > 0) {
                          setState(() {
                            _inputNameError = false;
                            _inputQuantityError = false;
                          });
                          print(_addItemName);
                          bool addResult = await addShoppingListItem(
                            itemName: _addItemName,
                            quantity: _addItemQuantity,
                            storeName: _addItemStoreName,
                          );
                          addResult
                              ? Scaffold.of(context).showSnackBar(
                                  snackBarPantry(
                                    title:
                                        'Added $_addItemName to Shopping List',
                                  ),
                                )
                              : Scaffold.of(context).showSnackBar(
                                  snackBarPantry(
                                    title:
                                        'Error adding $_addItemName to Shopping List',
                                  ),
                                );
                          _itemNameEditingController.clear();
                          _itemQtyEditingController.clear();
                          _itemQtyEditingController.text = '1';
                          _itemStoreNameEditingController.clear();
                          _addItemName = '';
                          _addItemQuantity = 1;
                          _addItemStoreName = '';
                        } else {
                          setState(() {
                            _inputNameError = true;
                            _inputQuantityError = true;
                            _itemQtyEditingController.clear();
                          });
                        }
                      } catch (e) {
                        print(e);
                      }
                    },
                  ),
                ],
              ),
              Expanded(
                child: buildShoppingList(),
              ),
            ],
          );
        },
      ),
    );
  }
}
