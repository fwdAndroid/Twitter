import 'package:flutter/material.dart';
import 'package:twitter/screens/authentication/signin.dart';
import 'package:twitter/services/authfiresbase/auth.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseAuthentication firebaseAuthentication = FirebaseAuthentication();

    return Scaffold(
      appBar: AppBar(
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
    );
  }
}
