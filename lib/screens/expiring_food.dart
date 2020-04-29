import 'package:flutter/material.dart';
import 'package:bearserkpantry/utilities/app_drawer.dart';

class ExpiringFood extends StatefulWidget {
  static String id = 'expiring_food';
  @override
  _BasicItemState createState() => _BasicItemState();
}

class _BasicItemState extends State<ExpiringFood> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Expiring Food',
        ),
      ),
      drawer: AppDrawer(),
    );
  }
}
