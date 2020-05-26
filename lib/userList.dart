import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reddrop/DrawerLayout.dart';
import 'package:reddrop/user.dart';
import 'package:reddrop/userTile.dart';

class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  List<String> bloodGroups = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];
  List<String> cities = ['Islamabad', 'Lahore', 'Faisalabad', 'Gujranwala'];

  String _selectedBloodGroup;
  String _selectedCity;
  String firstCity = 'City';
  String firstBloodGroup = 'A+';

  List<User> filteredUsers;

  @override
  Widget build(BuildContext context) {
    List<User> users = Provider.of<List<User>>(context) ?? [];

    return Scaffold(
      drawer: Drawer(child: DrawerLayout()),
      appBar: AppBar(
        backgroundColor: Colors.red,
        actions: <Widget>[
          Flexible(
            child: Container(
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      alignment: Alignment.center,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      child: DropdownButtonFormField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            hintText: 'BloodGroup'),
                        items: bloodGroups.map((bloodGroup) {
                          return DropdownMenuItem(
                            value: bloodGroup,
                            child: Text(bloodGroup),
                          );
                        }).toList(),
                        onChanged: ((val) {
                          setState(() {
                            _selectedBloodGroup = val;
                          });
                        }),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      height: 40,
                      child: DropdownButtonFormField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            hintText: 'City'),
                        items: cities.map((city) {
                          return DropdownMenuItem(
                            value: city,
                            child: Text(city),
                          );
                        }).toList(),
                        onChanged: ((val) {
                          setState(() {
                            _selectedCity = val;
                            filteredUsers = users
                                .where((user) =>
                                    user.city == val &&
                                    user.bloodGroup == _selectedBloodGroup)
                                .toList();
                          });
                        }),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(6, 12, 6, 0),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20.0,
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount:
                    filteredUsers != null ? filteredUsers.length : users.length,
                itemBuilder: (context, index) {
                  return UserTile(
                      user: filteredUsers != null
                          ? filteredUsers[index]
                          : users[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
