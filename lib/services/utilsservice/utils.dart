import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:twitter/models/usermodel.dart';

class UtilsService {
  //Parse User Information From usermodal
  UserModel? userFirebasesSnapshote(DocumentSnapshot documentSnapshot) {
    return documentSnapshot != null
        ? UserModel(
            id: documentSnapshot.id,
            name: documentSnapshot.get('name'),
            profileImageURL: documentSnapshot.get('profileImageURL') ?? '',
            bannerImageURL: documentSnapshot.get('bannerImageURL') ?? '',
            email: documentSnapshot.get('email') ?? '',
          )
        : null;
  }

  List<UserModel?> userListFromQuerySnapshot(
      QuerySnapshot<Map<String, dynamic>> event) {
    return event.docs.map((doc) {
      return UserModel(
        id: doc.id,
        name: doc.get('name'),
        profileImageURL: doc.get('profileImageURL') ?? '',
        bannerImageURL: doc.get('bannerImageURL') ?? '',
        email: doc.get('email') ?? '',
      );
    }).toList();
  }

  //Get User Information
  Stream<UserModel?> getUserInfo(uid) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .snapshots()
        .map(userFirebasesSnapshote);
  }

  //Search User
  Stream<List<UserModel?>> queryByName(search) {
    return FirebaseFirestore.instance
        .collection('users')
        .orderBy("name")
        .startAt([search])
        .endAt([search + '\uf8ff'])
        .limit(10)
        .snapshots()
        .map(userListFromQuerySnapshot);
  }

  //upload image in firsbase storage

  Future<String> uploadFile(File _image, String path) async {
    firebase_storage.Reference storageReference =
        firebase_storage.FirebaseStorage.instance.ref(path);

    firebase_storage.UploadTask uploadTask = storageReference.putFile(_image);

    await uploadTask.whenComplete(() => null);
    String returnURL = '';
    await storageReference.getDownloadURL().then((fileUrl) {
      returnURL = fileUrl;
    });

    return returnURL;
  }
}
