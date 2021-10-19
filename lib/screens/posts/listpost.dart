import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter/models/postmodel.dart';
import 'package:twitter/models/usermodel.dart';
import 'package:twitter/services/postservices/postservice.dart';
import 'package:twitter/services/utilsservice/utils.dart';

class ListPost extends StatefulWidget {
  @override
  State<ListPost> createState() => _ListPostState();
}

class _ListPostState extends State<ListPost> {
  UtilsService utilsService = UtilsService();
  PostService postService = PostService();

  @override
  Widget build(BuildContext context) {
    final postProvider = Provider.of<List<PostModel>>(context);
    //Geting Information From Stream
    return ListView.builder(
      itemCount: postProvider.length,
      itemBuilder: (context, index) {
        final post = postProvider[index];
        return StreamBuilder(
          stream: utilsService.getUserInfo(post.creator),
          builder:
              (BuildContext context, AsyncSnapshot<UserModel?> snapshotUser) {
            if (!snapshotUser.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            //Stream Builder TO GET USER LIKE
            return StreamBuilder(
              stream: postService.getCurrentUserLike(post),
              builder:
                  (BuildContext context, AsyncSnapshot<bool> snapshotLike) {
                if (!snapshotLike.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                return Card(
                  elevation: 5,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: ListTile(
                    title: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                      child: Row(
                        children: [
                          snapshotUser.data!.profileImageURL != ''
                              ? CircleAvatar(
                                  radius: 20,
                                  backgroundImage: NetworkImage(
                                    snapshotUser.data!.profileImageURL
                                        .toString(),
                                  ),
                                )
                              : const Icon(
                                  Icons.person,
                                  size: 40,
                                ),
                          const SizedBox(
                            width: 20,
                          ),
                          //Display Name
                          Text(snapshotUser.data!.name.toString())
                        ],
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(post.text),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(post.timestamp.toDate().toString()),
                              //Add Button UI For Like Post
                              const SizedBox(
                                height: 10,
                              ),
                              IconButton(
                                onPressed: () {
                                  //Like Functiion
                                  postService.likePost(
                                      post, snapshotLike.data!);
                                },
                                icon: Icon(
                                  snapshotLike.data!
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: Colors.blue,
                                  size: 30,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider()
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
