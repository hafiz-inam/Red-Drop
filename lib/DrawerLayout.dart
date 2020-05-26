import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reddrop/Profile.dart';
import 'package:reddrop/authService.dart';
import 'package:reddrop/databaseService.dart';
import 'package:reddrop/requestWall.dart';
import 'package:reddrop/user.dart';

class DrawerLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamBuilder<User>(
        stream: DatabaseService(uid: user.uid).currentUser,
        builder: (context, snapshot) {
          User userData = snapshot.data;
          return Column(
            children: <Widget>[
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/bg2.jpg'), fit: BoxFit.cover),
                ),
                accountName: Text(
                  userData.name,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 18),
                ),
                accountEmail: Text(
                  userData.phone,
                  style: TextStyle(color: Colors.black),
                ),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: NetworkImage(userData.picUrl),
                ),
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Profile'),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Profile()));
                },
              ),
              ListTile(
                leading: Icon(Icons.assistant),
                title: Text('Request Wall'),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => RequestWall()));
                },
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text('Logout'),
                onTap: () {
                  AuthService().signUserOut();
                },
              ),
            ],
          );
        });
  }
}
