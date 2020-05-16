import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  String itemName;
  String quantity;
  String expireDate;
  String storageLocation;

  ListItem(
      {@required this.itemName,
      this.quantity,
      this.expireDate,
      this.storageLocation});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('$itemName'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          expireDate == null ? Text('') : Text('Expire: $expireDate'),
          storageLocation == null ? Text('') : Text('$storageLocation'),
        ],
      ),
      trailing: quantity == null ? null : Text('$quantity'),
    );
  }
}
