import 'package:bearserkpantry/screens/unit_converter.dart';
import 'package:bearserkpantry/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:bearserkpantry/screens/all_items.dart';
import 'package:bearserkpantry/screens/basic_item.dart';
import 'package:bearserkpantry/screens/category_page.dart';
import 'package:bearserkpantry/screens/expired_food.dart';
import 'package:bearserkpantry/screens/expiring_food.dart';
import 'package:bearserkpantry/screens/shopping_list.dart';
import 'package:bearserkpantry/screens/storage_area.dart';
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
        '/': (context) => WelcomeScreen(),
        AllItems.id: (context) => AllItems(),
        BasicItem.id: (context) => BasicItem(),
        CategoryPage.id: (context) => CategoryPage(),
        ExpiredFood.id: (context) => ExpiredFood(),
        ExpiringFood.id: (context) => ExpiringFood(),
        ShoppingList.id: (context) => ShoppingList(),
        StorageArea.id: (context) => StorageArea(),
        UnitConverter.id: (context) => UnitConverter(),
      },
    );
  }
}
