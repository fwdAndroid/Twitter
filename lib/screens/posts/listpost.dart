import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter/models/postmodel.dart';

class ListPost extends StatefulWidget {
  @override
  State<ListPost> createState() => _ListPostState();
}

class _ListPostState extends State<ListPost> {
  @override
  Widget build(BuildContext context) {
    final postProvider = Provider.of<List<PostModel>>(context);

    return ListView.builder(
      itemCount: postProvider.length,
      itemBuilder: (context, index) {
        final post = postProvider[index];
        return Card(
            elevation: 5,
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: ListTile(
                title: Text(post.text),
                subtitle: Text(post.timestamp.toString())));
      },
    );
  }
}
