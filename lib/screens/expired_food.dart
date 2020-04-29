import 'package:bearserkpantry/utilities/app_drawer.dart';
import 'package:flutter/material.dart';

class ExpiredFood extends StatefulWidget {
  static String id = 'expired_food';
  @override
  _ExpiredFoodState createState() => _ExpiredFoodState();
}

class _ExpiredFoodState extends State<ExpiredFood> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Expired Food',
        ),
      ),
      drawer: AppDrawer(),
    );
  }
}
