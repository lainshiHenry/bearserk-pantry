import 'package:bearserkpantry/utilities/app_drawer.dart';
import 'package:flutter/material.dart';

class CategoryPage extends StatefulWidget {
  static String id = 'category_page';
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Category Page'),
      ),
      drawer: AppDrawer(),
    );
  }
}
