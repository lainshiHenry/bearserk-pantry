import 'package:bearserkpantry/utilities/arguments/edit_pantry_item_arguments.dart';
import 'package:bearserkpantry/utilities/list_item.dart';
import 'package:flutter/material.dart';
import 'package:strings/strings.dart';
import 'package:bearserkpantry/screens/pantry_item_details.dart';

class PantryListItem extends StatelessWidget {
  static String id = 'pantry_list_item';
  final String itemName;
  final int quantity;
  final String expireDate;
  final String storageLocation;

  PantryListItem(
      {@required this.itemName,
      @required this.quantity,
      this.expireDate,
      this.storageLocation});

  @override
  Widget build(BuildContext context) {
    return ListItem(
      itemName: capitalize(itemName),
      quantity: quantity.toString(),
      storageLocation: capitalize(storageLocation),
      destinationRouteName: PantryItemDetails.id,
      destinationArguments: ItemArgs(
          productName: itemName,
          itemQuantity: quantity,
          storageLocation: storageLocation),
    );
  }
}
