import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reddrop/DrawerLayout.dart';
import 'package:reddrop/Profile.dart';
import 'package:reddrop/authService.dart';
import 'package:reddrop/databaseService.dart';
import 'package:reddrop/postList.dart';
import 'package:reddrop/user.dart';
import 'package:reddrop/userList.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
//  int _currentIndex = 0;
//  final tabs = [
//    UserList(),
//    PostList(),
//    Profile(),
//  ];

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<User>>.value(
      value: DatabaseService().userList,
      child: Scaffold(
//        drawer: Drawer(
//          child: DrawerLayout()
//        ),
//        appBar: AppBar(
//          backgroundColor: Colors.red,
//          actions: <Widget>[
//
//          ],
//        ),
        body: UserList(),
//        bottomNavigationBar: BottomNavigationBar(
//          backgroundColor: Colors.white,
//          type: BottomNavigationBarType.fixed,
//          currentIndex: _currentIndex,
//          onTap: (index){
//            setState(() {
//              _currentIndex = index;
//            });
//          },
//          items: <BottomNavigationBarItem>[
//            BottomNavigationBarItem(
//                icon: Icon(Icons.home),
//                title: Text('Home'),
//            ),
//            BottomNavigationBarItem(
//              icon: Icon(Icons.image),
//              title: Text('Request')
//            ),
//            BottomNavigationBarItem(
//              icon: Icon(Icons.person),
//              title: Text('Profile'),
//            ),
//          ],
//        ),
      ),
    );
  }
}
