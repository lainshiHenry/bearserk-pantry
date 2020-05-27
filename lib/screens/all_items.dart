import 'package:bearserkpantry/screens/add_pantry_Item.dart';
import 'package:bearserkpantry/services/add_via_barcode.dart';
import 'package:bearserkpantry/services/build_list.dart';
import 'package:bearserkpantry/utilities/bottom_nav_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bearserkpantry/utilities/constants.dart';
import 'package:bearserkpantry/utilities/app_drawer.dart';
import 'dart:math';

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
      bottomNavigationBar: BottomNavBar(),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  onPressed: () {
                    addViaBarcode = false;
                    Navigator.pushNamed(context, AddPantryItem.id);
                  },
                  child: Text('Add'),
                ),
                RaisedButton(
                  onPressed: () {},
                  child: Text('Delete'),
                ),
              ],
            ),
            Expanded(
              child: buildPantryList(),
            ),
          ],
        ),
      ),
    );
  }
}
