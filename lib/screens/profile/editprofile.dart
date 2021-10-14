import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String name = "";
  File? profileImage;
  File? bannerImage;
  final imagePicker = ImagePicker();

  //Get Image Function From Camera
  Future getImage(int type) async {
    final pickedFile = await imagePicker.getImage(source: ImageSource.camera);
    setState(() {
      //Setting State of image file

      //Show Profile Image
      if (pickedFile != null && type == 0) {
        profileImage = File(pickedFile.path);
      }
      //Show Banner Image
      if (pickedFile != null && type == 1) {
        bannerImage = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (AppBar(
        backgroundColor: Colors.blue[300],
        automaticallyImplyLeading: true,
        actions: [
          TextButton(
            onPressed: () => {},
            child: Text('Save',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                )),
          ),
        ],
      )),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: Form(
          child: Column(
            children: [
              //Profile Image
              TextButton(
                onPressed: () => getImage(0),
                child: profileImage == null
                    ? Icon(Icons.person)
                    : Image.file(
                        profileImage!,
                        height: 100,
                      ),
              ),
              //Baaner Image
              TextButton(
                onPressed: () => getImage(1),
                child: bannerImage == null
                    ? Icon(Icons.person)
                    : Image.file(
                        bannerImage!,
                        height: 100,
                      ),
              ),
              Container(
                margin: const EdgeInsets.only(
                    top: 10, bottom: 10, left: 15, right: 15),
                child: TextFormField(
                  // validator: (val) => val!.length < 5
                  //     ? "Password length must be greater than 5 characters"
                  //     : null,

                  onChanged: (val) {
                    setState(() {
                      name = val;
                    });
                  },
                  decoration: InputDecoration(
                      // fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: const BorderSide(),
                      ),
                      fillColor: Colors.green),
                  keyboardType: TextInputType.text,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
