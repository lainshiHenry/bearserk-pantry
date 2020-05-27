import 'package:flutter/material.dart';
import 'package:bearserkpantry/utilities/pantry_list_item.dart';

class PantryListView extends StatefulWidget {
  final String itemName;
  final int quantity;
  final String storageLocation;

  PantryListView(
      {@required this.itemName, this.quantity, this.storageLocation});
  @override
  _PantryListViewState createState() => _PantryListViewState();
}

class _PantryListViewState extends State<PantryListView> {
  @override
  Widget build(BuildContext context) {
    return PantryListItem(
      itemName: widget.itemName,
      quantity: widget.quantity,
      storageLocation: widget.storageLocation,
    );
  }
}
