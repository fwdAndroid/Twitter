import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:twitter/authentication/signin.dart';
import 'package:twitter/authentication/signup.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  User? firebaseUser = FirebaseAuth.instance.currentUser;
  Widget? firstWidget;

  @override
  Widget build(BuildContext context) {
    // Assign widget based on availability of currentUser
    if (firebaseUser != null) {
      firstWidget = SignIn();
    } else {
      firstWidget = SignUp();
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UniClass',
      theme: ThemeData(
        primaryColor: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: firstWidget,
    );
  }
}
