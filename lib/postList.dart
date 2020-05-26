import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reddrop/postTile.dart';
import 'package:reddrop/Post.dart';

class PostList extends StatefulWidget {
  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  @override
  Widget build(BuildContext context) {
    List<Post> postsFromFirebase = Provider.of<List<Post>>(context) ?? [];

    return Scaffold(
      body: ListView.builder(
        itemCount: postsFromFirebase.length,
        itemBuilder: (context, index) {
          return PostTile(
            post: postsFromFirebase[index],
          );
        },
      ),
    );
  }
}
