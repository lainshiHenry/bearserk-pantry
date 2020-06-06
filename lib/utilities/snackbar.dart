import 'package:flutter/material.dart';

Widget snackBarPantryUndo({String title, Function undoFunction}) {
  return SnackBar(
    content: Text(title),
    action: SnackBarAction(
      label: 'Undo',
      onPressed: undoFunction,
    ),
  );
}

Widget snackBarPantry({String title}) {
  return SnackBar(
    content: Text(title),
  );
}
