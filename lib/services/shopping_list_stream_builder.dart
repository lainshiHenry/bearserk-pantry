import 'package:bearserkpantry/utilities/list_item.dart';
import 'package:flutter/material.dart';
import 'package:bearserkpantry/utilities/shopping_list_item.dart';
import 'package:bearserkpantry/utilities/constants.dart';
import 'package:strings/strings.dart';
import 'package:bearserkpantry/services/stream_builder_functions.dart';
import 'package:bearserkpantry/utilities/snackbar.dart';

class ShoppingListStreamBuilder extends StatefulWidget {
  final List<ShoppingListItem> list;

  ShoppingListStreamBuilder({this.list});

  @override
  _ShoppingListStreamBuilderState createState() =>
      _ShoppingListStreamBuilderState();
}

class _ShoppingListStreamBuilderState extends State<ShoppingListStreamBuilder> {
  int newQuantity;
  TextEditingController _itemNameTextEditingController =
      TextEditingController();
  TextEditingController _itemQuantityTextEditingController =
      TextEditingController();
  TextEditingController _purchaseStoreLocationTextEditingController =
      TextEditingController();

  @override
  void dispose() {
    _itemNameTextEditingController.dispose();
    _itemQuantityTextEditingController.dispose();
    _purchaseStoreLocationTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: ExpansionPanelList(
          expansionCallback: (int index, bool isExpanded) {
            setState(() {
              widget.list[index].isExpanded = !isExpanded;
              _itemNameTextEditingController.text = widget.list[index].itemName;
              _itemQuantityTextEditingController.text =
                  widget.list[index].quantity.toString();
              _purchaseStoreLocationTextEditingController.text =
                  widget.list[index].storeName;
            });
          },
          children: widget.list.map<ExpansionPanel>(
            (ShoppingListItem item) {
              return ExpansionPanel(
                isExpanded: item.isExpanded,
                canTapOnHeader: true,
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return ListItem(
                    itemName: capitalize(item.itemName),
                    quantity: item.quantity.toString(),
                    purchaseStoreName: capitalize(item.storeName),
                  );
                },
                body: ListTile(
                  subtitle: Column(
                    children: <Widget>[
                      TextField(
                        controller: _itemNameTextEditingController,
                        decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Item Name'),
                      ),
                      TextField(
                        controller: _itemQuantityTextEditingController,
                        decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Item Quantity'),
                        onChanged: (value) {
                          newQuantity = int.parse(value);
                        },
                      ),
                      TextField(
                        controller: _purchaseStoreLocationTextEditingController,
                        decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Store Name'),
                      ),
                      Row(
                        children: <Widget>[
                          RaisedButton(
                            child: Text('Submit'),
                            onPressed: () async {
                              bool result = false;
                              String _resultText;

                              try {
                                if (newQuantity == 0) {
                                  deleteShoppingListItem(
                                    itemName: item.itemName,
                                    quantity: newQuantity,
                                    storeName: item.storeName,
                                  );
                                  _resultText = 'Delete';
                                } else {
                                  result = await addShoppingListItem(
                                    itemName: item.itemName,
                                    quantity: newQuantity,
                                    storeName: item.storeName,
                                  );
                                  _resultText = 'Edit';
                                  result
                                      ? showSnackBarPantry(
                                          context: context,
                                          displayText:
                                              '${item.itemName} Edited',
                                        )
                                      : showSnackBarPantry(
                                          context: context,
                                          displayText:
                                              'Error ${item.itemName} Edited');
                                }

                                setState(() {
                                  item.isExpanded = false;
                                });
                              } catch (e) {
                                print(e);
                              }
                            },
                          ),
                          RaisedButton(
                            child: Text('Cancel'),
                            onPressed: () {
                              setState(() {
                                item.isExpanded = false;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}
