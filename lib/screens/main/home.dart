// ignore_for_file: prefer_const_constructors, duplicate_ignore

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twitter/screens/authentication/signin.dart';
import 'package:twitter/services/authfiresbase/auth.dart';
import 'package:twitter/widgets/bottomnavigationwidget.dart';
import 'package:twitter/widgets/drawer.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    FirebaseAuthentication firebaseAuthentication = FirebaseAuthentication();

    return Scaffold(
      // ignore: duplicate_ignore
      appBar: AppBar(
        backgroundColor: Colors.blue[300],
        // ignore: prefer_const_constructors
        title: Text(
          'MyProfileName',
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton.icon(
              onPressed: () async {
                await firebaseAuthentication.signOut();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignIn()),
                );
              },
              icon: const Icon(Icons.logout),
              label:
                  const Text('LogOut', style: TextStyle(color: Colors.white)))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue[300],
        onPressed: () {
          Navigator.pushNamed(context, '/add');
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      drawer: MyDrawer(),
      bottomNavigationBar: BottomNavigationWidget(),
    );
  }
}
