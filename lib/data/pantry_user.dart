import 'package:flutter/material.dart';

PantryUser currentUser;

class PantryUser {
  final String email;
  final String pantryID;
  final String firebaseUID;

  PantryUser(
      {@required this.email,
      @required this.pantryID,
      @required this.firebaseUID});
}
