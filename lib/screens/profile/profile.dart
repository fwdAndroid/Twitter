import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter/models/usermodel.dart';
import 'package:twitter/screens/posts/listpost.dart';
import 'package:twitter/services/postservices/postservice.dart';
import 'package:twitter/services/utilsservice/utils.dart';

//Multiprovider is used when multiples servicess are used in one class
class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PostService postService = PostService();
    UtilsService utilsService = UtilsService();

    var uid = ModalRoute.of(context)!.settings.arguments;
    return MultiProvider(
      // ignore: prefer_const_literals_to_create_immutables
      providers: [
        StreamProvider.value(
          initialData: null,
          value: postService.getPostsByUser(uid),
        ),
        StreamProvider.value(
          initialData: null,
          value: utilsService.getUserInfo(uid),
        ),
        StreamProvider.value(
          initialData: null,
          value: utilsService.isFollowing(
              FirebaseAuth.instance.currentUser!.uid, uid),
        ),
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
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Provider.of<UserModel>(context).profileImageURL !=
                                    ''
                                ? CircleAvatar(
                                    radius: 30,
                                    backgroundImage: NetworkImage(
                                        Provider.of<UserModel>(context)
                                            .profileImageURL
                                            .toString()),
                                  )
                                : const Icon(
                                    Icons.person,
                                    size: 50,
                                  ),
                            if (FirebaseAuth.instance.currentUser!.uid == uid)
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/edit');
                                },
                                child: const Text('Edit Profile'),
                              )
                            else if (FirebaseAuth.instance.currentUser!.uid !=
                                    uid &&
                                !Provider.of<bool>(context))
                              TextButton(
                                  onPressed: () {
                                    utilsService.followUser(uid);
                                  },
                                  child: const Text("Follow"))
                            else if (FirebaseAuth.instance.currentUser!.uid !=
                                    uid &&
                                Provider.of<bool>(context))
                              TextButton(
                                  onPressed: () {
                                    utilsService.unfollowUser(uid);
                                  },
                                  child: const Text("Unfollow")),
                          ],
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              Provider.of<UserModel>(context).name ?? '',
                              // ignore: prefer_const_constructors
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 25),
                            ),
                          ),
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
