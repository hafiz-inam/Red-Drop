import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reddrop/Post.dart';

class PostTile extends StatelessWidget {
  final Post post;
  PostTile({this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: NetworkImage(post.pic),
            ),
            title: Text(
              post.name,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(post.time),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Text(post.postContent),
          ),
        ],
      ),
    );
  }
}
