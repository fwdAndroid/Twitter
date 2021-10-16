import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter/screens/profile/displayusersearch.dart';
import 'package:twitter/services/utilsservice/utils.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  UtilsService userService = UtilsService();
  String search = '';

  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      initialData: null,
      value: userService.queryByName(search),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              onChanged: (text) {
                setState(() {
                  search = text;
                });
              },
              decoration: InputDecoration(hintText: 'Search.......'),
            ),
          ),
          ListUsers()
        ],
      ),
    );
  }
}
