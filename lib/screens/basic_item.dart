import 'package:flutter/material.dart';
import 'package:bearserkpantry/utilities/app_drawer.dart';

class BasicItem extends StatefulWidget {
  static String id = 'basic_item';
  @override
  _BasicItemState createState() => _BasicItemState();
}

class _BasicItemState extends State<BasicItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Basic Items',
        ),
      ),
      drawer: AppDrawer(),
    );
  }
}
