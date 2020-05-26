import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reddrop/databaseService.dart';
import 'package:reddrop/requestWall.dart';
import 'package:reddrop/user.dart';
import 'package:random_string/random_string.dart';

class PostRequest extends StatefulWidget {
  @override
  _PostRequestState createState() => _PostRequestState();
}

class _PostRequestState extends State<PostRequest> {
  String postId;
  String _postContent;
  String _currentTime = DateTime.now().hour.toString() +
      ':' +
      DateTime.now().minute.toString() +
      " | " +
      DateTime.now().day.toString() +
      '/' +
      DateTime.now().month.toString() +
      '/' +
      DateTime.now().year.toString();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamBuilder<User>(
        stream: DatabaseService(uid: user.uid).currentUser,
        builder: (context, snapshot) {
          User userData = snapshot.data;

          return Scaffold(
            appBar: AppBar(
              title: Text('Post Request'),
              centerTitle: true,
            ),
            body: Container(
              padding: EdgeInsets.all(16),
              child: Form(
                  child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        hintText: 'Type here',
                      ),
                      onChanged: ((val) => setState(() => _postContent = val)),
                    ),
                    SizedBox(height: 30.0),
                    RaisedButton(
                      onPressed: () async {
                        postId = randomAlphaNumeric(16);
                        dynamic result = await DatabaseService(uid: user.uid)
                            .createPost(postId, userData.name, userData.picUrl,
                                _postContent, _currentTime);
                        print(user.uid);
                        print(userData.name);
                        print(userData.picUrl);
                        print(_postContent);
                        Navigator.pop(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RequestWall()));
                      },
                      color: Colors.red,
                      child: Text(
                        'Post',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              )),
            ),
          );
        });
  }
}
