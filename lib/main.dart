import 'package:bearserkpantry/dev/dev_test.dart';
import 'package:bearserkpantry/screens/add_pantry_Item.dart';
import 'package:bearserkpantry/screens/add_product_database.dart';
import 'package:bearserkpantry/screens/pantry_item_details.dart';
import 'package:bearserkpantry/screens/shopping_list_item_details.dart';
import 'package:bearserkpantry/screens/unit_converter.dart';
import 'package:bearserkpantry/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:bearserkpantry/screens/all_items.dart';
import 'package:bearserkpantry/screens/shopping_list.dart';
import 'package:bearserkpantry/screens/welcome_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: kPrimaryAppColour,
      ),
      initialRoute: '/',
      routes: {
//        '/': (context) => DevTest(),
        '/': (context) => WelcomeScreen(),
        AllItems.id: (context) => AllItems(),
        ShoppingList.id: (context) => ShoppingList(),
        UnitConverter.id: (context) => UnitConverter(),
        AddPantryItem.id: (context) => AddPantryItem(),
        AddProductDatabase.id: (context) => AddProductDatabase(),
        PantryItemDetails.id: (context) => PantryItemDetails(),
        PantryItemDetails.routeName: (context) => PantryItemDetails(),
        ShoppingListItemDetails.id: (context) => ShoppingListItemDetails(),
        // ignore: equal_keys_in_map
        ShoppingListItemDetails.routeName: (context) =>
            ShoppingListItemDetails(),
      },
    );
  }
}
