import 'package:bearserkpantry/services/stream_builder_functions.dart';
import 'package:flutter/material.dart';

Widget buildShoppingList() {
  return getShoppingListStream();
}

Widget buildPantryList() {
  return getPantryStream();
}
