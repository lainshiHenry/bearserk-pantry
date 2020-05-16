import 'package:flutter/material.dart';
import 'package:bearserkpantry/utilities/app_drawer.dart';

class UnitConverter extends StatefulWidget {
  static String id = 'unit_converter';
  @override
  _UnitConverterState createState() => _UnitConverterState();
}

class _UnitConverterState extends State<UnitConverter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Unit Converter',
        ),
      ),
      drawer: AppDrawer(),
      body: Expanded(
        child: Row(
          children: <Widget>[
            Text('number 1'),
          ],
        ),
      ),
    );
  }
}
