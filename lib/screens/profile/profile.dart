import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter/screens/posts/listpost.dart';
import 'package:twitter/services/postservices/postservice.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PostService postService = PostService();
    return StreamProvider.value(
      // ignore: prefer_const_literals_to_create_immutables
      initialData: null,
      value: postService.getPostsByUser(FirebaseAuth.instance.currentUser!.uid),
      child: Scaffold(
        body: Container(
          child: ListPost(),
        ),
      ),
    );
  }
}
