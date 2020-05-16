import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bearserkpantry/utilities/constants.dart';
import 'package:bearserkpantry/utilities/app_drawer.dart';
import 'package:bearserkpantry/utilities/list_item.dart';

class AllItems extends StatefulWidget {
  static String id = 'all_items';
  @override
  _AllItemsState createState() => _AllItemsState();
}

class _AllItemsState extends State<AllItems> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          kAppTitle,
        ),
      ),
      drawer: AppDrawer(),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  onPressed: () {},
                  child: Text('Add'),
                ),
                RaisedButton(
                  onPressed: () {},
                  child: Text('Delete'),
                ),
              ],
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  ListItem(
                    itemName: 'Egg',
                    quantity: '30',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
