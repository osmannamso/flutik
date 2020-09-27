import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: FlatButton(
        onPressed: () {
          Navigator.pushNamed(context, '/');
        },
        color: Colors.grey,
        child: Text('Profile'),
      )
    );
  }

}