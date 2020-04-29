import 'package:flutter/material.dart';
import 'package:bearserkpantry/utilities/app_drawer.dart';

class StorageArea extends StatefulWidget {
  static String id = 'storage_area';
  @override
  _StorageAreaState createState() => _StorageAreaState();
}

class _StorageAreaState extends State<StorageArea> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Storage Area'),
      ),
      drawer: AppDrawer(),
    );
  }
}
