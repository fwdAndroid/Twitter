import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter/screens/posts/listpost.dart';
import 'package:twitter/services/postservices/postservice.dart';

class Feed extends StatefulWidget {
  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  PostService _postService = PostService();

  @override
  Widget build(BuildContext context) {
    return FutureProvider.value(
        initialData: CircularProgressIndicator(),
        value: _postService.getFeed(),
        child: Scaffold(body: ListPost(null!)));
  }
}
