import 'package:flutter/material.dart';
import 'package:bearserkpantry/utilities/constants.dart';

class ListItem extends StatelessWidget {
  final String itemName;
  final String quantity;
  final String expireDate;
  final String storageLocation;
  final String mainTitle;
  final String purchaseStoreName;
  final String trailingItem;
  final String destinationRouteName;
  final Object destinationArguments;
  final Function moveItem;

  ListItem(
      {@required this.itemName,
      this.quantity,
      this.expireDate,
      this.storageLocation,
      this.moveItem,
      this.purchaseStoreName,
      this.mainTitle,
      this.trailingItem,
      this.destinationRouteName,
      this.destinationArguments});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      title: Text(
        '$itemName',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      /*onTap: () {
        Navigator.pushNamed(context, destinationRouteName,
            arguments: destinationArguments);
      },*/
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                storageLocation == null
                    ? SizedBox(height: 0)
                    : Text('Location: $storageLocation'),
                expireDate == null
                    ? SizedBox(height: 0)
                    : Text('Expire: $expireDate'),
                purchaseStoreName == null
                    ? SizedBox(height: 0)
                    : Text('Store: $purchaseStoreName'),
              ],
            ),
          ),
        ],
      ),
      trailing: quantity == null
          ? Text('')
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
