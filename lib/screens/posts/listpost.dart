import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter/models/postmodel.dart';
import 'package:twitter/models/usermodel.dart';
import 'package:twitter/screens/posts/itempost.dart';
import 'package:twitter/services/postservices/postservice.dart';
import 'package:twitter/services/utilsservice/utils.dart';

class ListPost extends StatefulWidget {
  PostModel post;
  ListPost(this.post, {Key? key}) : super(key: key);

  @override
  _ListPostState createState() => _ListPostState();
}

class _ListPostState extends State<ListPost> {
  UtilsService userService = UtilsService();
  PostService postService = PostService();
  @override
  Widget build(BuildContext context) {
    List<PostModel> posts = Provider.of<List<PostModel>>(context) ?? [];
    if (widget.post != null) {
      posts.insert(0, widget.post);
    }
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];
        if (post.retweet) {
          return FutureBuilder(
              future: postService.getPostById(post.orginalId),
              builder: (BuildContext context,
                  AsyncSnapshot<PostModel> snapshotPost) {
                if (!snapshotPost.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                return mainPost(snapshotPost.data!, true);
              });
        }
        return mainPost(post, false);
      },
    );
  }

  StreamBuilder<UserModel?> mainPost(PostModel post, bool retweet) {
    return StreamBuilder(
        stream: userService.getUserInfo(post.creator),
        builder:
            (BuildContext context, AsyncSnapshot<UserModel?> snapshotUser) {
          if (!snapshotUser.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          //stream builder to get user like
          return StreamBuilder(
              stream: postService.getCurrentUserLike(post),
              builder:
                  (BuildContext context, AsyncSnapshot<bool> snapshotLike) {
                if (!snapshotLike.hasData) {
                  return Center(child: CircularProgressIndicator());
                } //stream builder to get user like

                return StreamBuilder(
                    stream: postService.getCurrentUserRetweet(post),
                    builder: (BuildContext context,
                        AsyncSnapshot<bool> snapshotRetweet) {
                      if (!snapshotLike.hasData) {
                        return Center(child: CircularProgressIndicator());
                      }

                      return ItemPost(
                          post,
                          snapshotUser as AsyncSnapshot<UserModel>,
                          snapshotLike,
                          snapshotRetweet,
                          retweet);
                    });
              });
        });
  }
}
