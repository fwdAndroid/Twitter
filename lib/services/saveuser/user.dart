import 'dart:collection';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:twitter/services/utilsservice/utils.dart';

class UserService {
  UtilsService utilsService = UtilsService();
  //Update User Profile
  Future<void> updateProfile(
      File _bannerImage, File _profileImage, String name) async {
    String _bannerImageUrl = "";
    String _profileImageUrl = "";

    if (_bannerImage != null) {
      //Save Image to Storage
      _bannerImageUrl = await utilsService.uploadFile(_bannerImage,
          'user/profile/${FirebaseAuth.instance.currentUser!.uid}/banner');
    }
    if (_profileImage != null) {
      //Save Image to Storage
      _profileImageUrl = await utilsService.uploadFile(_profileImage, 'path');
    }

    Map<String, Object> data = new HashMap();
    if (name != '') data['name'] = name;
    if (_bannerImageUrl != '') data['_bannerImageUrl'] = _bannerImageUrl;
    if (_profileImageUrl != '') data['_profileImageUrl'] = _profileImageUrl;

    //Updating User Profile
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update(data);
  }
}
