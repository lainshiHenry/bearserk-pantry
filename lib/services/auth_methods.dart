import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bearserkpantry/data/pantry_user.dart';

Future<bool> signInMethod({String email, String password}) async {
  final _auth = FirebaseAuth.instance;
  bool _signInSuccess = false;

  try {
    final loggedInUser = await _auth.signInWithEmailAndPassword(
        email: email, password: password);

    if (loggedInUser != null) {
      FirebaseUser _firebaseUser = await FirebaseAuth.instance.currentUser();
      String _pantryID = await getPantryID(
          email: _firebaseUser.email, firebaseUID: _firebaseUser.uid);

      if (_pantryID != null) {
        currentUser = PantryUser(
          email: _firebaseUser.email,
          firebaseUID: _firebaseUser.uid,
          pantryID: _pantryID,
        );
      }
      if (currentUser != null) {
        _signInSuccess = true;
      }
    }
  } catch (e) {
    print(e);
  }

  return _signInSuccess;
}

Future<String> getPantryID({String email, String firebaseUID}) async {
  String retrievedPantryID;
  final _firestoreInstance = Firestore.instance;

  try {
    retrievedPantryID = await _firestoreInstance
        .collection('users')
        .where('uID', isEqualTo: firebaseUID)
        .getDocuments()
        .then((value) => value.documents[0].data['pantryID'].toString());
  } catch (e) {
    print(e);
    retrievedPantryID = null;
  }
  return retrievedPantryID;
}

void signOutCurrentUser() async {
  final _auth = FirebaseAuth.instance;

  try {
    _auth.signOut();
  } catch (e) {
    print(e);
  }
}
