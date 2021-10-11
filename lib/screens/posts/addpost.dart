import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twitter/services/postservices/postservice.dart';

class AddPost extends StatefulWidget {
  const AddPost({Key? key}) : super(key: key);

  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  String text = "";
  PostService postService = PostService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[300],
        title: const Text(
          'Tweets',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              await postService.savePost(text);
              Navigator.pop(context);
            },
            child: const Text(
              'Add Tweet',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Form(
          child: TextFormField(
            validator: (val) => val!.length < 5
                ? "Tweet Must not be less than 5 characters"
                : null,
            onChanged: (val) {
              setState(() {
                text = val;
              });
            },
            decoration: InputDecoration(
                labelText: "Write A Tweet",
                // fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: const BorderSide(),
                ),
                fillColor: Colors.green),
            keyboardType: TextInputType.text,
          ),
        ),
      ),
    );
  }
}
