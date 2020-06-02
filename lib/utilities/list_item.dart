import 'package:flutter/material.dart';
import 'package:bearserkpantry/utilities/constants.dart';

class ListItem extends StatelessWidget {
  final String itemName;
  final String quantity;
  final String expireDate;
  final String storageLocation;
  final String mainTitle;
  final String purchaseStoreName;
  final String column1Row1Heading;
  final String column1Row1Body;
  final String column1Row2Heading;
  final String column1Row2Body;
  final String column2Row1Heading;
  final String column2Row1Body;
  final String column2Row2Heading;
  final String column2Row2Body;
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
      this.column1Row1Heading,
      this.column1Row1Body,
      this.column1Row2Heading,
      this.column1Row2Body,
      this.column2Row1Heading,
      this.column2Row1Body,
      this.column2Row2Heading,
      this.column2Row2Body,
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
      onTap: () {
        Navigator.pushNamed(context, destinationRouteName,
            arguments: destinationArguments);
      },
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
      /*children: <Widget>[
        Column(
          children: <Widget>[
            TextField(
              controller: _itemNameTextEditingController,
              decoration: kTextFieldDecoration.copyWith(hintText: 'Item Name'),
              onChanged: (value) {
                _itemName = value;
              },
            ),
            TextField(
              keyboardType: TextInputType.number,
              controller: _itemQuantityTextEditingController,
              decoration: kTextFieldDecoration.copyWith(hintText: 'Quantity'),
              onChanged: (value) {
                _itemQuantity = int.parse(value);
              },
            ),
            TextField(
              controller: _itemStorageLocationTextEditingController,
              decoration:
                  kTextFieldDecoration.copyWith(hintText: 'Storage Location'),
              onChanged: (value) {
                _itemStorageLocation = value;
              },
            ),
            Row(
              children: <Widget>[
                RaisedButton(
                  child: Text('Submit'),
                  onPressed: () {},
                ),
                RaisedButton(
                  child: Text('Cancel'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ],
        )
      ],*/
    );
  }
}
