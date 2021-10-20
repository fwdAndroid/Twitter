import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String id;
  final String creator;
  final String text;
  final Timestamp timestamp;
  final String orginalId;
  bool retweet;
  int likesCount;
  int retweetsCount;
  PostModel(
      {required this.id,
      required this.creator,
      required this.text,
      required this.timestamp,
      required this.orginalId,
      required this.retweet,
      required this.likesCount,
      required this.retweetsCount});
}
