import 'package:bearserkpantry/utilities/list_item.dart';
import 'package:strings/strings.dart';
import 'package:flutter/material.dart';

class PantryListItem extends StatefulWidget {
  final String itemName;
  final int quantity;
  final String storageLocation;

  PantryListItem(
      {@required this.itemName, this.quantity, this.storageLocation});
  @override
  _PantryListItemState createState() => _PantryListItemState();
}

class _PantryListItemState extends State<PantryListItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Dismissible(
        key: Key(widget.itemName),
        child: ListItem(
          itemName: capitalize(widget.itemName),
          quantity: widget.quantity.toString(),
          storageLocation: capitalize(widget.storageLocation),
        ),
        onDismissed: (direction) {},
      ),
    );
  }
}
