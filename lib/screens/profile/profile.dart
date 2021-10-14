import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter/models/usermodel.dart';
import 'package:twitter/screens/posts/listpost.dart';
import 'package:twitter/services/postservices/postservice.dart';
import 'package:twitter/services/saveuser/user.dart';

//Multiprovider is used when multiples servicess are used in one class
class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PostService postService = PostService();
    UserService userService = UserService();
    return MultiProvider(
      // ignore: prefer_const_literals_to_create_immutables
      providers: [
        StreamProvider.value(
          initialData: null,
          value: postService
              .getPostsByUser(FirebaseAuth.instance.currentUser!.uid),
        ),
        StreamProvider.value(
            initialData: null,
            value: userService.utilsService
                .getUserInfo(FirebaseAuth.instance.currentUser!.uid))
      ],
      child: Scaffold(
          body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
            headerSliverBuilder: (context, _) {
              return [
                SliverAppBar(
                  floating: false,
                  pinned: true,
                  expandedHeight: 130,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Image.network(
                      Provider.of<UserModel>(context).bannerImageURL ?? '',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SliverList(
                    delegate: SliverChildListDelegate([
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.network(
                              Provider.of<UserModel>(context).profileImageURL ??
                                  '',
                              fit: BoxFit.cover,
                              height: 60,
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/edit');
                              },
                              child: Text('Edit Profile'),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  Provider.of<UserModel>(context).name ?? '',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ]))
              ];
            },
            body: ListPost()),
      )),
    );
  }
}
