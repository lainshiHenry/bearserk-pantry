import 'package:flutter/material.dart';
import 'package:bearserkpantry/utilities/list_item.dart';
import 'package:bearserkpantry/services/stream_builder_functions.dart';
import 'package:strings/strings.dart';
import 'dart:async';

class DismissibleListItem extends StatefulWidget {
  final String itemName;
  final int quantity;

  DismissibleListItem({@required this.itemName, this.quantity});

  @override
  _DismissibleListItemState createState() => _DismissibleListItemState();
}

class _DismissibleListItemState extends State<DismissibleListItem> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      background: Container(
        color: Colors.red,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Icon(Icons.delete),
          ],
        ),
      ),
      secondaryBackground: Container(
        color: Colors.green,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Icon(Icons.check),
          ],
        ),
      ),
      key: Key(widget.itemName),
      child: ListItem(
        itemName: capitalize(widget.itemName),
        quantity: widget.quantity.toString(),
      ),
      onDismissed: (direction) async {
        setState(() async {
          await purchaseItem(
            itemName: widget.itemName,
            quantity: widget.quantity,
          );
        });
        Timer(Duration(seconds: 2), () {});
      },
    );
  }
}
