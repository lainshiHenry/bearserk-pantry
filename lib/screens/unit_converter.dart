import 'package:flutter/material.dart';
import 'package:bearserkpantry/utilities/app_drawer.dart';
import 'package:bearserkpantry/utilities/constants.dart';

class UnitConverter extends StatefulWidget {
  static String id = 'unit_converter';
  @override
  _UnitConverterState createState() => _UnitConverterState();
}

class _UnitConverterState extends State<UnitConverter> {
  List<String> convertCategories = ['Length', 'Volume'];
  List<String> convertUnits = ['cm', 'm', 'in', 'ft'];

  String _dropdownCategoryValue;
  String _dropdownUnit1Value;
  String _dropdownUnit2Value;
  @override
  void initState() {
    _dropdownCategoryValue = convertCategories[0];
    _dropdownUnit1Value = convertUnits[0];
    _dropdownUnit2Value = convertUnits[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryAppColour[600],
        elevation: 0.0,
        title: Text(
          'Unit Converter',
        ),
      ),
      drawer: AppDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            color: kPrimaryAppColour[500],
            height: 50.0,
            child: Center(
              child: DropdownButton(
                  value: _dropdownCategoryValue,
                  items: convertCategories
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String newValue) {
                    setState(() {
                      _dropdownCategoryValue = newValue;
                    });
                  }),
            ),
          ),
          Expanded(
            child: Stack(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              //Color(0xFF32A7FD),
                              //Color(0xFF63C9FC),
                              kPrimaryAppColour[500],
                              kPrimaryAppColour[200],
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          textBaseline: TextBaseline.alphabetic,
                          children: <Widget>[
                            SizedBox(
                              width: 100.0,
                              child: TextField(
                                keyboardType: TextInputType.number,
                                decoration: kUnitConverterTextFieldDecoration,
                                style: TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                  color: kPrimaryAppColour,
                                ),
                              ),
                            ),
                            SizedBox(
                              child: DropdownButton(
                                  value: _dropdownUnit1Value,
                                  items: convertUnits
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  underline: Container(
                                    height: 2,
                                    color: Colors.grey[700],
                                  ),
                                  onChanged: (String newValue) {
                                    setState(() {
                                      _dropdownUnit1Value = newValue;
                                    });
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          textBaseline: TextBaseline.alphabetic,
                          children: <Widget>[
                            SizedBox(
                              width: 100.0,
                              child: TextField(
                                keyboardType: TextInputType.number,
                                decoration: kUnitConverterTextFieldDecoration,
                                style: TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                  color: kPrimaryAppColour,
                                ),
                              ),
                            ),
                            SizedBox(
                              child: DropdownButton(
                                  value: _dropdownUnit2Value,
                                  items: convertUnits
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  underline: Container(
                                    height: 2,
                                    color: Colors.grey[700],
                                  ),
                                  onChanged: (String newValue) {
                                    setState(() {
                                      _dropdownUnit2Value = newValue;
                                    });
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Center(
                  child: IconButton(
                    iconSize: 50.0,
                    icon: Icon(
                      Icons.compare_arrows,
                    ),
                    color: Colors.black,
                    onPressed: () {},
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
