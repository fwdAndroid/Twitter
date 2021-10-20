import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quiver/iterables.dart';
import 'package:twitter/models/postmodel.dart';
import 'package:twitter/services/utilsservice/utils.dart';

class PostService {
  //Add Tweet
  Future savePost(text) async {
    await FirebaseFirestore.instance.collection('posts').add({
      'text': text,
      'creator': FirebaseAuth.instance.currentUser!.uid,
      'timestamp': FieldValue.serverTimestamp()
    });
  }

  //Like Post
  Future likePost(PostModel post, bool current) async {
    print(post.id);
    if (current) {
      post.likesCount = (post.likesCount - 1);
      await FirebaseFirestore.instance
          .collection("posts")
          .doc(post.id)
          .collection("likes")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .delete();
    }
    if (!current) {
      post.likesCount = post.likesCount + 1;
      await FirebaseFirestore.instance
          .collection("posts")
          .doc(post.id)
          .collection("likes")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({});
    }
  }

  //Like Get Userr Like
  Stream<bool> getCurrentUserLike(PostModel post) {
    return FirebaseFirestore.instance
        .collection("posts")
        .doc(post.id)
        .collection("likes")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .map((snapshot) {
      return snapshot.exists;
    });
  }

  //Retweet
  Future retweet(PostModel post, bool current) async {
    if (current) {
      post.retweetsCount = post.retweetsCount - 1;
      await FirebaseFirestore.instance
          .collection("posts")
          .doc(post.id)
          .collection("retweets")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .delete();

      await FirebaseFirestore.instance
          .collection("posts")
          .where("originalId", isEqualTo: post.id)
          .where("creator", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((value) {
        if (value.docs.length == 0) {
          return;
        }
        FirebaseFirestore.instance
            .collection("posts")
            .doc(value.docs[0].id)
            .delete();
      });
      // Todo remove the retweet
      return;
    }
    post.retweetsCount = post.retweetsCount + 1;
    await FirebaseFirestore.instance
        .collection("posts")
        .doc(post.id)
        .collection("retweets")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({});

    await FirebaseFirestore.instance.collection("posts").add({
      'creator': FirebaseAuth.instance.currentUser!.uid,
      'timestamp': FieldValue.serverTimestamp(),
      'retweet': true,
      'originalId': post.id
    });
  }

  //Get Retweet Details
  Stream<bool> getCurrentUserRetweet(PostModel post) {
    return FirebaseFirestore.instance
        .collection("posts")
        .doc(post.id)
        .collection("retweets")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .map((snapshot) {
      return snapshot.exists;
    });
  }

  Future<PostModel> getPostById(String id) async {
    DocumentSnapshot postSnap =
        await FirebaseFirestore.instance.collection("posts").doc(id).get();

    return _postFromSnapshot(postSnap);
  }

  //To Create Information in form of list and store inside the map of above getPostsByUser fuuction we create the list of postmodal
  List<PostModel> _postListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return PostModel(
          id: doc.id,
          creator: doc.get('creator') ?? '',
          text: doc.get('text') ?? '',
          timestamp: doc.get('timestamp') ?? 0,
          likesCount: doc.get('likesCount') ?? 0,
          retweetsCount: doc.get('retweetsCount') ?? 0,
          retweet: doc.get('retweet') ?? false,
          orginalId: doc.get('orginalId') ?? null);
    }).toList();
  }

  //Fetch Data using Stream
  Stream<List<PostModel>> getPostsByUser(uid) {
    return FirebaseFirestore.instance
        .collection('posts')
        .where('creator', isEqualTo: uid)
        .snapshots()
        .map(_postListFromSnapshot);
  }

  //List of Post
  Future<List<PostModel>> getFeed() async {
    List<String> usersFollowing = await UtilsService() //['uid1', 'uid2']
        .getUserFollowing(FirebaseAuth.instance.currentUser!.uid);

    var splitUsersFollowing = partition<dynamic>(usersFollowing, 10);
    inspect(splitUsersFollowing);

    List<PostModel> feedList = [];

    for (int i = 0; i < splitUsersFollowing.length; i++) {
      inspect(splitUsersFollowing.elementAt(i));
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('posts')
          .where('creator', whereIn: splitUsersFollowing.elementAt(i))
          .orderBy('timestamp', descending: true)
          .get();

      feedList.addAll(_postListFromSnapshot(querySnapshot));
    }

    feedList.sort((a, b) {
      var adate = a.timestamp;
      var bdate = b.timestamp;
      return bdate.compareTo(adate);
    });

    return feedList;
  }

  //Get User Retweet
  Stream<bool> getCurrentUserRetweet(PostModel post) {
    return FirebaseFirestore.instance
        .collection("posts")
        .doc(post.id)
        .collection("retweets")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .snapshots()
        .map((snapshot) {
      return snapshot.exists;
    });
  }

  PostModel _postFromSnapshot(DocumentSnapshot snapshot) {
    return snapshot.exists
        ? PostModel(
            id: snapshot.id,
            text: snapshot.get('text') ?? '',
            creator: snapshot.get('creator') ?? '',
            timestamp: snapshot.get('timestamp') ?? 0,
            likesCount: snapshot.get('likesCount') ?? 0,
            retweetsCount: snapshot.get('retweetsCount') ?? 0,
            retweet: snapshot.get('retweet') ?? false,
            orginalId: snapshot.get('originalId') ?? null,
            // ref: snapshot.reference,
          )
        : null as PostModel;
  }
}
