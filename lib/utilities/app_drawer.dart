import 'package:bearserkpantry/screens/add_product_database.dart';
import 'package:bearserkpantry/screens/unit_converter.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:bearserkpantry/screens/all_items.dart';
import 'package:bearserkpantry/screens/basic_item.dart';
import 'package:bearserkpantry/screens/category_page.dart';
import 'package:bearserkpantry/screens/expired_food.dart';
import 'package:bearserkpantry/screens/expiring_food.dart';
import 'package:bearserkpantry/screens/shopping_list.dart';
import 'package:bearserkpantry/screens/storage_area.dart';

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
            navItemName: 'Category',
            destination: CategoryPage.id,
            leftIcon: Icons.category,
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

/*            NavigationItem(
            navItemName: 'Storage Area',
            destination: StorageArea.id,
            leftIcon: Icons.storage,
          ),
          NavigationItem(
            navItemName: 'Expired Items',
            destination: ExpiredFood.id,
            leftIcon: Icons.delete,
          ),
NavigationItem(

            navItemName: 'Basic Items',
            destination: BasicItem.id,
            leftIcon: Icons.fastfood,
          ),
          NavigationItem(
            navItemName: 'Expiring Food',
            destination: ExpiringFood.id,
            leftIcon: Icons.alarm,
          ),

 */
