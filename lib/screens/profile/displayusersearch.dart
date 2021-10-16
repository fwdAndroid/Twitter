import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter/models/postmodel.dart';
import 'package:twitter/models/usermodel.dart';

class ListUsers extends StatefulWidget {
  const ListUsers({Key? key}) : super(key: key);

  @override
  _ListUsersState createState() => _ListUsersState();
}

class _ListUsersState extends State<ListUsers> {
  @override
  Widget build(BuildContext context) {
    final postProvider = Provider.of<List<UserModel>>(context);

    return ListView.builder(
      shrinkWrap: true,
      itemCount: postProvider.length,
      itemBuilder: (context, index) {
        final user = postProvider[index];
        return InkWell(
          onTap: () {
            Navigator.pushNamed(context, '/profile', arguments: user.id);
          },
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    user.profileImageURL != null
                        ? CircleAvatar(
                            radius: 20,
                            backgroundImage:
                                NetworkImage(user.profileImageURL.toString()),
                          )
                        : Icon(
                            Icons.person,
                            size: 30,
                          ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(user.name.toString())
                  ],
                ),
              ),
              Divider(
                thickness: 1,
              )
            ],
          ),
        );
      },
    );
  }
}
