import 'package:bearserkpantry/screens/add_pantry_Item.dart';
import 'package:bearserkpantry/screens/all_items.dart';
import 'package:bearserkpantry/screens/shopping_list.dart';
import 'package:flutter/material.dart';

int _selectedIndex = 2;

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  List<BottomNavigationBarItem> bottomNavBarItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      title: Text('Pantry'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.add),
      title: Text('Add'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.shopping_cart),
      title: Text('Shopping Cart'),
    ),
  ];
  List<String> _navMenuOptions = [
    AllItems.id,
    AddPantryItem.id,
    ShoppingList.id,
  ];

  void _onItemTapped(int index) {
    print(index);
    setState(() {
      Navigator.pushReplacementNamed(context, _navMenuOptions[index]);
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: bottomNavBarItems,
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
    );
  }
}
