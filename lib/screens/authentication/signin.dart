import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:twitter/screens/authentication/signup.dart';
import 'package:twitter/screens/main/home.dart';
import 'package:twitter/services/authfiresbase/auth.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final auth = FirebaseAuth.instance;
  final formKey = GlobalKey<FormState>();

  String email = "";
  String password = "";
  var url =
      "https://www.lter-europe.net/document-archive/image-gallery/albums/logos/TwitterLogo_55acee.png/image";
  FirebaseAuthentication firebaseAuthentication = FirebaseAuthentication();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue[300],
        // ignore: prefer_const_constructors
        title: Text(
          'Sign In',
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
              margin: const EdgeInsets.only(
                  top: 10, bottom: 10, left: 15, right: 15),
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
                      borderSide: const BorderSide(),
                    ),
                    fillColor: Colors.green),
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            //Password
            Container(
              margin: const EdgeInsets.only(
                  top: 10, bottom: 10, left: 15, right: 15),
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
                      borderSide: const BorderSide(),
                    ),
                    fillColor: Colors.green),
                keyboardType: TextInputType.visiblePassword,
              ),
            ),
            //Implementation Button
            ElevatedButton.icon(
              onPressed: () async {
                // Respond to button press
                await firebaseAuthentication.signInTwitter(email, password);
                Navigator.push(
                    context, MaterialPageRoute(builder: (ctx) => Home()));
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                primary: Colors.blue[300],
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              ),
              // ignore: prefer_const_constructors
              icon: Icon(Icons.app_registration, size: 18),
              // ignore: prefer_const_constructors
              label: Text(
                "Sign IN",
                style: const TextStyle(color: Colors.white),
              ),
            ),
            // ignore: prefer_const_constructors
            SizedBox(
              height: 20,
            ),
            TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUp()),
                  );
                },
                child: Text(
                  'Create Account ! If you are not registered',
                  style: TextStyle(color: Colors.blue[300]),
                ))
          ],
        ),
      ),
    );
    ;
  }
}
