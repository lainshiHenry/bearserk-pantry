import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  final String itemName;
  final String quantity;
  final String expireDate;
  final String storageLocation;
  final String mainTitle;
  final String column1Row1Heading;
  final String column1Row1Body;
  final String column1Row2Heading;
  final String column1Row2Body;
  final String column2Row1Heading;
  final String column2Row1Body;
  final String column2Row2Heading;
  final String column2Row2Body;
  final String trailingItem;
  final Function increaseQty;
  final Function decreaseQty;
  final Function moveItem;
  final Function onTapFunction;

  ListItem(
      {@required this.itemName,
      this.quantity,
      this.expireDate,
      this.storageLocation,
      this.increaseQty,
      this.decreaseQty,
      this.moveItem,
      this.mainTitle,
      this.column1Row1Heading,
      this.column1Row1Body,
      this.column1Row2Heading,
      this.column1Row2Body,
      this.column2Row1Heading,
      this.column2Row1Body,
      this.column2Row2Heading,
      this.column2Row2Body,
      this.trailingItem,
      this.onTapFunction});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      title: Text(
        '$itemName',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      onTap: () {},
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
                column1Row1Body == null
                    ? SizedBox(height: 0)
                    : Text('$column1Row1Heading: $column1Row1Body'),
                column1Row2Body == null
                    ? SizedBox(height: 0)
                    : Text('$column1Row2Heading: $column1Row2Body'),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                column2Row1Body == null
                    ? SizedBox(height: 0)
                    : Text('$column2Row1Heading: $column2Row1Body'),
                column2Row2Body == null
                    ? SizedBox(height: 0)
                    : Text('$column2Row2Heading: $column2Row2Body'),
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
