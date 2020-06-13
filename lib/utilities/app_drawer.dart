import 'package:bearserkpantry/screens/add_product_database.dart';
import 'package:bearserkpantry/screens/unit_converter.dart';
import 'package:bearserkpantry/services/auth_methods.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:bearserkpantry/screens/all_items.dart';
import 'package:bearserkpantry/screens/shopping_list.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            child: Text(kAppTitle),
            decoration: BoxDecoration(
              color: kPrimaryAppColour,
            ),
          ),
          NavigationItem(
            navItemName: 'All Items',
            destination: AllItems.id,
          ),
          NavigationItem(
            navItemName: 'Shopping List',
            destination: ShoppingList.id,
            leftIcon: Icons.shopping_cart,
          ),
          NavigationItem(
            navItemName: 'Unit Converter',
            destination: UnitConverter.id,
          ),
          NavigationItem(
            navItemName: 'Add To Product DB',
            destination: AddProductDatabase.id,
            leftIcon: Icons.sd_storage,
          ),
          ListTile(
            leading: Icon(Icons.power_settings_new),
            title: Text('Log Off'),
            onTap: () {
              signOutCurrentUser();
              Navigator.pop(context);
              Navigator.pushNamed(context, '/');
            },
          ),
        ],
      ),
    );
  }
}

class NavigationItem extends StatelessWidget {
  final IconData leftIcon;
  final String navItemName;
  final String destination;

  NavigationItem({this.leftIcon, this.navItemName, this.destination});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(leftIcon),
      title: Text(navItemName),
      onTap: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, destination);
      },
    );
  }
}
