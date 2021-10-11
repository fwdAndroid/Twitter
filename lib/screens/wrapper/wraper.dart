import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter/models/usermodel.dart';
import 'package:twitter/screens/authentication/signin.dart';
import 'package:twitter/screens/main/home.dart';
import 'package:twitter/screens/posts/addpost.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);
    // ignore: unnecessary_null_comparison
    if (user == null) {
      return SignIn();
    } else {
      return MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => Home(),
          '/add': (context) => AddPost(),
        },
      );
    }
  }
}
