import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Egg'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Expire: 2020-05-01'),
          Text('Location: Fridge'),
        ],
      ),
      trailing: Text('30'),
    );
  }
}
