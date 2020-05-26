import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reddrop/PostRequest.dart';
import 'package:reddrop/databaseService.dart';
import 'package:reddrop/postList.dart';

class RequestWall extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: DatabaseService().postList,
      child: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            FlatButton.icon(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PostRequest()));
                },
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                label: Text(
                  'Post Request',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ))
          ],
        ),
        body: PostList(),
      ),
    );
  }
}
