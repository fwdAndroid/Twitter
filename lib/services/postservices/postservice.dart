import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:twitter/models/postmodel.dart';

class PostService {
  //Add Tweet
  Future savePost(text) async {
    await FirebaseFirestore.instance.collection('posts').add({
      'text': text,
      'creator': FirebaseAuth.instance.currentUser!.uid,
      'timestamp': FieldValue.serverTimestamp()
    });
  }

  //To Create Information in form of list and store inside the map of above getPostsByUser fuuction we create the list of postmodal
  List<PostModel> _postListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return PostModel(
        id: doc.id,
        creator: doc.get('creator') ?? '',
        text: doc.get('text') ?? '',
        timestamp: doc.get('timestamp') ?? 0,
      );
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
}
