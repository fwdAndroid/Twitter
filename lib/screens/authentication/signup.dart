// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twitter/screens/authentication/signin.dart';
import 'package:twitter/services/authfiresbase/auth.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final formKey = GlobalKey<FormState>();
  final auth = FirebaseAuth.instance;
  FirebaseAuthentication firebaseAuthentication = FirebaseAuthentication();
  String email = "";
  String password = "";
  var url =
      "https://www.lter-europe.net/document-archive/image-gallery/albums/logos/TwitterLogo_55acee.png/image";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue[300],
        title: Text(
          'SignUp',
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Colors.blue[100],
              radius: 70,
              backgroundImage: NetworkImage(url),
            ),
            //Email
            Container(
              margin: EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
              child: TextFormField(
                validator: (val) => val!.isEmpty ? "Enter An Email" : null,
                onChanged: (val) {
                  setState(() {
                    email = val;
                  });
                },
                decoration: InputDecoration(
                    labelText: "Enter Email",
                    // fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(),
                    ),
                    fillColor: Colors.green),
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            //Password
            Container(
              margin: EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
              child: TextFormField(
                validator: (val) => val!.length < 5
                    ? "Password length must be greater than 5 characters"
                    : null,
                obscureText: true,
                onChanged: (val) {
                  setState(() {
                    password = val;
                  });
                },
                decoration: InputDecoration(
                    labelText: "Enter Password",
                    // fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(),
                    ),
                    fillColor: Colors.green),
                keyboardType: TextInputType.visiblePassword,
              ),
            ),
            //Implementation Button
            ElevatedButton.icon(
              onPressed: () async {
                // Respond to button press
                await firebaseAuthentication.signUpTwitter(email, password);
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0),
                ),
                primary: Colors.blue[300],
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              ),
              icon: Icon(Icons.app_registration, size: 18),
              label: Text(
                "Sign UP",
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignIn()),
                  );
                },
                child: Text(
                  'Already Register',
                  style: TextStyle(color: Colors.blue[300]),
                ))
          ],
        ),
      ),
    );
  }
}
