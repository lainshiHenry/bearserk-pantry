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
      title: Text(
        '$itemName',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          expireDate == null ? Text('') : Text('Expire: $expireDate'),
          storageLocation == null
              ? Text('')
              : Text('Location: $storageLocation'),
        ],
      ),
      trailing: quantity == null
          ? null
          : Text(
              '$quantity',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
    );
  }
}
