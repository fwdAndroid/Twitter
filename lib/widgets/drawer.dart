// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:twitter/services/authfiresbase/auth.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseAuthentication firebaseAuthentication = FirebaseAuthentication();
    return Drawer(
        child: ListView(
      children: [
        DrawerHeader(
          child: const Text('Header'),
          decoration: BoxDecoration(color: Colors.blue[300]),
        ),
        ListTile(
          title: Text('Profile'),
          onTap: () {
            Navigator.pushNamed(context, '/profile');
          },
        ),
        ListTile(
          title: Text('Edit Profile'),
          onTap: () {
            Navigator.pushNamed(context, '/edit');
          },
        ),
        const Divider(color: Colors.black),
        ListTile(
          title: Text('SignOut'),
          onTap: () async {
            await firebaseAuthentication.signOut();
          },
        ),
      ],
    ));
  }
}
