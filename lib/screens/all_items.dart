import 'package:flutter/material.dart';
import 'package:bearserkpantry/utilities/constants.dart';
import 'package:bearserkpantry/utilities/app_drawer.dart';

class AllItems extends StatefulWidget {
  static String id = 'all_items';
  @override
  _AllItemsState createState() => _AllItemsState();
}

class _AllItemsState extends State<AllItems> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(kAppTitle),
      ),
      drawer: AppDrawer(),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Egg'),
            subtitle: Text('Expire: 2020-05-01'),
            isThreeLine: true,
            trailing: Column(
              children: <Widget>[
                Text('Fridge'),
                Text('30'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
