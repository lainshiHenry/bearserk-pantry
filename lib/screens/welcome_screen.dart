import 'package:bearserkpantry/dev/dev_data.dart';
import 'package:bearserkpantry/screens/all_items.dart';
import 'package:bearserkpantry/screens/shopping_list.dart';
import 'package:bearserkpantry/services/auth_methods.dart';
import 'package:bearserkpantry/utilities/constants.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryAppColour,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Flexible(
              child: Container(
                height: 240.0,
                child: Image.asset('assets/rilakkuma_eating.jpg'),
              ),
            ),
            SizedBox(
              height: 24.0,
            ),
            FlatButton(
              onPressed: () async {
                bool _signinSuccessful = await signInMethod(
                  email: devEmail,
                  password: devPassword,
                );
                if (_signinSuccessful) {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, ShoppingList.id);
                }
              },
              child: Text('Get Started'),
            ),
          ],
        ),
      ),
    );
  }
}
