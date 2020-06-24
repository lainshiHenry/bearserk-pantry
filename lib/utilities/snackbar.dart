import 'package:flutter/material.dart';

void showSnackBarPantry(
    {BuildContext context, String displayText, Function undoFunction}) {
  Scaffold.of(context).showSnackBar(
    SnackBar(
      content: Text(displayText),
      action: undoFunction == null
          ? null
          : SnackBarAction(
              label: 'Undo',
              onPressed: undoFunction,
            ),
    ),
  );
}
