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
            profileImageURL: documentSnapshot.get('profileImageURL'),
            bannerImageURL: documentSnapshot.get('bannerImageURL'),
            email: documentSnapshot.get('email'),
          )
        : null;
  }

  //Get User Information
  Stream<UserModel?> getUserInfo(uid) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .snapshots()
        .map(userFirebasesSnapshote);
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
