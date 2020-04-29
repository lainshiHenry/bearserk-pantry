import 'package:flutter/material.dart';
import 'package:bearserkpantry/utilities/app_drawer.dart';

class ShoppingList extends StatefulWidget {
  static String id = 'shopping_list';
  @override
  _ShoppingListState createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Storage Area',
        ),
      ),
      drawer: AppDrawer(),
    );
  }
}
