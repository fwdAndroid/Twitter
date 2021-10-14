import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class UtilsService {
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